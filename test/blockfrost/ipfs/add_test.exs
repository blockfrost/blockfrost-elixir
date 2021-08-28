defmodule Blockfrost.IPFS.AddTest do
  use Blockfrost.Case

  alias Blockfrost.IPFS.Add

  alias Blockfrost.Response.AddFileResponse

  alias Blockfrost.HTTPClientMock

  setup_all do
    start_supervised!({Blockfrost, name: IPFS, api_key: "apikey", network: :ipfs})
    :ok
  end

  describe "add_file" do
    test "allows uploading files from path" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/add"
        assert request.method == "POST"
        assert {:stream, stream} = request.body

        content_disposition =
          stream
          |> Enum.to_list()
          |> Enum.find(&String.starts_with?(&1, "Content-Disposition"))

        assert content_disposition ==
                 "Content-Disposition: form-data; name=file; filename=\"README.md\""

        response(200, %{})
      end)

      Add.add_file(IPFS, "README.md")
    end

    test "allows uploading files from streams" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/ipfs/add"
        assert request.method == "POST"
        assert {:stream, stream} = request.body

        content_disposition =
          stream
          |> Enum.to_list()
          |> Enum.find(&String.starts_with?(&1, "Content-Disposition"))

        assert content_disposition ==
                 "Content-Disposition: form-data; name=file"

        response(200, %{})
      end)

      Add.add_file(IPFS, File.stream!("README.md"))
    end

    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn _request, _finch, _opts ->
        response(
          200,
          %{
            name: "README.md",
            ipfs_hash: "QmZbHqiCxKEVX7QfijzJTkZiSi3WEVTcvANgNAWzDYgZDr",
            size: 125_297
          }
        )
      end)

      assert {:ok,
              %AddFileResponse{
                name: "README.md",
                ipfs_hash: "QmZbHqiCxKEVX7QfijzJTkZiSi3WEVTcvANgNAWzDYgZDr",
                size: 125_297
              }} == Add.add_file(IPFS, File.stream!("README.md"))
    end
  end
end
