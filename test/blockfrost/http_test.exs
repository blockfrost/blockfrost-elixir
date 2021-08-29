defmodule Blockfrost.HTTPTest do
  use Blockfrost.Case

  alias Blockfrost.HTTPClientMock
  alias Blockfrost.HTTP

  setup_all do
    start_supervised!({Blockfrost, name: TestNet, api_key: "apikey", network: :cardano_testnet})
    start_supervised!({Blockfrost, name: MainNet, api_key: "apikey", network: :cardano_mainnet})
    :ok
  end

  describe "build/2,3,4" do
    test "uses host for network" do
      test_req = HTTP.build(TestNet, :get, "/")
      main_req = HTTP.build(MainNet, :get, "/")

      refute test_req.host == main_req.host
    end

    test "merges path with base path" do
      req = HTTP.build(MainNet, :get, "/foo")

      base_path =
        MainNet
        |> Blockfrost.config()
        |> Map.get(:network_uri)
        |> Map.get(:path)

      assert req.path == base_path <> "/foo"
    end

    test "considers query params" do
      req = HTTP.build(MainNet, :get, "/foo", %{"a" => 1, "b" => 2})

      assert req.query == "a=1&b=2"
    end

    test "puts correct headers" do
      req = HTTP.build(MainNet, :get, "/foo", %{"a" => 1, "b" => 2})
      {:ok, vsn} = :application.get_key(:blockfrost, :vsn)

      assert [
               {"project_id", "apikey"},
               {"User-Agent", user_agent_value},
               {"Content-Type", "application/json"}
             ] = req.headers

      assert "blockfrost-elixir/#{vsn}" == user_agent_value
    end
  end

  describe "request/1,2,3" do
    test "returns treated errors" do
      expect(HTTPClientMock, :request, fn _req, _finch, _opts ->
        response(418, [])
      end)

      req = HTTP.build(MainNet, :get, "/foo")
      assert {:error, :ip_banned} = HTTP.request(MainNet, req)
    end

    test "retries if receives a retryable status" do
      # expected 3 times
      expect(HTTPClientMock, :request, 3, fn _req, _finch, _opts ->
        response(429, [])
      end)

      # on fourth, we return a success
      expect(HTTPClientMock, :request, fn _req, _finch, _opts ->
        response(200, %{})
      end)

      req = HTTP.build(MainNet, :get, "/foo")
      assert {:ok, %{status: 200}} = HTTP.request(MainNet, req)
    end

    test "returns error if surpassing max retries amount" do
      expect(HTTPClientMock, :request, 5, fn _req, _finch, _opts ->
        response(429, [])
      end)

      req = HTTP.build(MainNet, :get, "/foo")
      assert {:error, :usage_limit_reached} = HTTP.request(MainNet, req, retry_max_attempts: 5)
    end
  end

  describe "build_and_send/3,4" do
    test "fetches first page if none specified" do
      expect(HTTPClientMock, :request, fn _req, _finch, _opts ->
        response(200, [])
      end)

      HTTP.build_and_send(MainNet, :get, "/foo")
    end

    test "allows specifying pagination params" do
      expect(HTTPClientMock, :request, fn req, _finch, _opts ->
        assert req.query == "count=50&page=3"

        response(200, [])
      end)

      HTTP.build_and_send(MainNet, :get, "/foo", pagination: %{page: 3, count: 50})
    end

    test "fetches all pages if given :all as page" do
      expect(HTTPClientMock, :request, 10, fn req, _finch, _opts ->
        assert %{"page" => page, "order" => "asc", "count" => "100"} = URI.decode_query(req.query)

        assert page in Enum.map(1..10, &Integer.to_string/1)

        response(200, List.duplicate(%{}, 100))
      end)

      expect(HTTPClientMock, :request, 10, fn req, _finch, _opts ->
        assert %{"page" => page, "order" => "asc", "count" => "100"} = URI.decode_query(req.query)

        assert page in Enum.map(11..20, &Integer.to_string/1)

        response(200, [])
      end)

      assert {:ok, _responses} =
               HTTP.build_and_send(MainNet, :get, "/foo", pagination: %{page: :all, count: 50})
    end

    test "keeps pages in order if given :all as page" do
      expect(HTTPClientMock, :request, 11, fn req, _finch, _opts ->
        %{"page" => page} = URI.decode_query(req.query)
        response(200, List.duplicate(page, 100))
      end)

      expect(HTTPClientMock, :request, 9, fn _req, _finch, _opts ->
        response(200, [])
      end)

      assert {:ok, responses} =
               HTTP.build_and_send(MainNet, :get, "/foo", pagination: %{page: :all, count: 50})

      %Finch.Response{body: first_resp_body} = List.first(responses)
      assert first_resp_body =~ ~s/["1","1","1"/

      %Finch.Response{body: eleventh_resp_body} = Enum.at(responses, 10)
      assert eleventh_resp_body =~ ~s/["11","11","11"/
    end
  end
end
