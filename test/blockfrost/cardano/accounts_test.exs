defmodule Blockfrost.Cardano.AccountsTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Accounts

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    SpecificAccountAddressResponse,
    AccountRewardHistoryResponse.Reward,
    AccountHistoryResponse.History,
    AccountDelegationHistoryResponse.Delegation,
    AccountRegistrationHistoryResponse.Registration,
    AccountWithdrawalHistoryResponse.Withdrawal,
    AccountMIRHistoryResponse.MIR,
    AccountAssociatedAdressesResponse.Address,
    AssetsAssociatedWithAccountAddressResponse.AssetAssociatedWithAccountAddress
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "specific_account_address/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"

        response(200, %{
          "stake_address" => "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7",
          "active" => true,
          "active_epoch" => 412,
          "controlled_amount" => "619154618165",
          "rewards_sum" => "319154618165",
          "withdrawals_sum" => "12125369253",
          "reserves_sum" => "319154618165",
          "treasury_sum" => "12000000",
          "withdrawable_amount" => "319154618165",
          "pool_id" => "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
        })
      end)

      assert {:ok,
              %SpecificAccountAddressResponse{
                stake_address: "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7",
                active: true,
                active_epoch: 412,
                controlled_amount: "619154618165",
                rewards_sum: "319154618165",
                withdrawals_sum: "12125369253",
                reserves_sum: "319154618165",
                treasury_sum: "12000000",
                withdrawable_amount: "319154618165",
                pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
              }} =
               Accounts.specific_account_address(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )
    end
  end

  describe "account_reward_history/1,2,3" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/rewards"

        response(200, [
          %{
            epoch: 215,
            amount: "12695385",
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
          },
          %{
            epoch: 216,
            amount: "3586329",
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
          },
          %{
            epoch: 217,
            amount: "0",
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
          },
          %{
            epoch: 218,
            amount: "1395265",
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
          }
        ])
      end)

      assert {:ok,
              [
                %Reward{
                  epoch: 215,
                  amount: "12695385",
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
                },
                %Reward{
                  epoch: 216,
                  amount: "3586329",
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
                },
                %Reward{
                  epoch: 217,
                  amount: "0",
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
                },
                %Reward{
                  epoch: 218,
                  amount: "1395265",
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
                }
              ]} =
               Accounts.account_reward_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )
    end

    test "allows fetching any page" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/rewards"

        assert request.query == "page=5"

        response(200, [
          %{
            epoch: 215,
            amount: "12695385",
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
          }
        ])
      end)

      Accounts.account_reward_history(
        Blockfrost,
        "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7",
        page: 5
      )
    end

    test "can fetch all pages" do
      expect(HTTPClientMock, :request, 11, fn _request, _finch, _opts ->
        sample = %{
          epoch: 215,
          amount: "12695385",
          pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
        }

        response(200, List.duplicate(sample, 100))
      end)

      expect(HTTPClientMock, :request, 9, fn _request, _finch, _opts ->
        response(200, [])
      end)

      assert {:ok, result} =
               Accounts.account_reward_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7",
                 page: :all
               )

      assert Enum.count(result) == 100 * 11
    end
  end

  describe "account_history/1,2,3" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/history"

        response(
          200,
          [
            %{
              active_epoch: 210,
              amount: "12695385",
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
            },
            %{
              active_epoch: 211,
              amount: "22695385",
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
            }
          ]
        )
      end)

      assert {:ok, result} =
               Accounts.account_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %History{
                 active_epoch: 210,
                 amount: "12695385",
                 pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               },
               %History{
                 active_epoch: 211,
                 amount: "22695385",
                 pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               }
             ] == result
    end
  end

  describe "account_delegation_history/1,2,3" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/delegations"

        response(
          200,
          [
            %{
              active_epoch: 210,
              tx_hash: "2dd15e0ef6e6a17841cb9541c27724072ce4d4b79b91e58432fbaa32d9572531",
              amount: "12695385",
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
            },
            %{
              active_epoch: 242,
              tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dde628516157f0",
              amount: "12691385",
              pool_id: "pool1kchver88u3kygsak8wgll7htr8uxn5v35lfrsyy842nkscrzyvj"
            }
          ]
        )
      end)

      assert {:ok, result} =
               Accounts.account_delegation_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %Delegation{
                 active_epoch: 210,
                 tx_hash: "2dd15e0ef6e6a17841cb9541c27724072ce4d4b79b91e58432fbaa32d9572531",
                 amount: "12695385",
                 pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               },
               %Delegation{
                 active_epoch: 242,
                 tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dde628516157f0",
                 amount: "12691385",
                 pool_id: "pool1kchver88u3kygsak8wgll7htr8uxn5v35lfrsyy842nkscrzyvj"
               }
             ] == result
    end
  end

  describe "account_registration_history/1,2,3" do
    test "properly decodes a 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/registrations"

        response(200, [
          %{
            tx_hash: "2dd15e0ef6e6a17841cb9541c27724072ce4d4b79b91e58432fbaa32d9572531",
            action: "registered"
          },
          %{
            tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dde628516157f0",
            action: "deregistered"
          }
        ])
      end)

      assert {:ok, result} =
               Accounts.account_registration_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %Registration{
                 tx_hash: "2dd15e0ef6e6a17841cb9541c27724072ce4d4b79b91e58432fbaa32d9572531",
                 action: "registered"
               },
               %Registration{
                 tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dde628516157f0",
                 action: "deregistered"
               }
             ] == result
    end
  end

  describe "account_withdrawal_history/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/withdrawals"

        response(200, [
          %{
            tx_hash: "48a9625c841eea0dd2bb6cf551eabe6523b7290c9ce34be74eedef2dd8f7ecc5",
            amount: "454541212442"
          },
          %{
            tx_hash: "4230b0cbccf6f449f0847d8ad1d634a7a49df60d8c142bb8cc2dbc8ca03d9e34",
            amount: "97846969"
          }
        ])
      end)

      assert {:ok, result} =
               Accounts.account_withdrawal_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %Withdrawal{
                 tx_hash: "48a9625c841eea0dd2bb6cf551eabe6523b7290c9ce34be74eedef2dd8f7ecc5",
                 amount: "454541212442"
               },
               %Withdrawal{
                 tx_hash: "4230b0cbccf6f449f0847d8ad1d634a7a49df60d8c142bb8cc2dbc8ca03d9e34",
                 amount: "97846969"
               }
             ] == result
    end
  end

  describe "account_mir_history/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/mirs"

        response(200, [
          %{
            tx_hash: "48a9625c841eea0dd2bb6cf551eabe6523b7290c9ce34be74eedef2dd8f7ecc5",
            amount: "454541212442"
          },
          %{
            tx_hash: "4230b0cbccf6f449f0847d8ad1d634a7a49df60d8c142bb8cc2dbc8ca03d9e34",
            amount: "97846969"
          }
        ])
      end)

      assert {:ok, result} =
               Accounts.account_mir_history(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %MIR{
                 tx_hash: "48a9625c841eea0dd2bb6cf551eabe6523b7290c9ce34be74eedef2dd8f7ecc5",
                 amount: "454541212442"
               },
               %MIR{
                 tx_hash: "4230b0cbccf6f449f0847d8ad1d634a7a49df60d8c142bb8cc2dbc8ca03d9e34",
                 amount: "97846969"
               }
             ] == result
    end
  end

  describe "account_associated_addresses/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/addresses"

        response(200, [
          %{
            address:
              "addr1qx2kd28nq8ac5prwg32hhvudlwggpgfp8utlyqxu6wqgz62f79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9sy0f4qd"
          },
          %{
            address:
              "addr1qys3czp8s9thc6u2fqed9yq3h24nyw28uk0m6mkgn9dkckjf79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9suth4w4"
          },
          %{
            address:
              "addr1q8j55h253zcvl326sk5qdt2n8z7eghzspe0ekxgncr796s2f79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9sjmd35m"
          },
          %{
            address:
              "addr1q8f7gxrprank3drhx8k5grlux7ene0nlwun8y9thu8mc3yjf79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9sls6vnt"
          }
        ])
      end)

      assert {:ok, result} =
               Accounts.account_associated_addresses(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %Address{
                 address:
                   "addr1qx2kd28nq8ac5prwg32hhvudlwggpgfp8utlyqxu6wqgz62f79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9sy0f4qd"
               },
               %Address{
                 address:
                   "addr1qys3czp8s9thc6u2fqed9yq3h24nyw28uk0m6mkgn9dkckjf79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9suth4w4"
               },
               %Address{
                 address:
                   "addr1q8j55h253zcvl326sk5qdt2n8z7eghzspe0ekxgncr796s2f79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9sjmd35m"
               },
               %Address{
                 address:
                   "addr1q8f7gxrprank3drhx8k5grlux7ene0nlwun8y9thu8mc3yjf79qsdmm5dsknt9ecr5w468r9ey0fxwkdrwh08ly3tu9sls6vnt"
               }
             ] == result
    end
  end

  describe "assets_associated_with_account_address/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/accounts/stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7/addresses/assets"

        response(200, [
          %{
            unit:
              "d5e6bf0500378d4f0da4e8dde6becec7621cd8cbf5cbb9b87013d4cc537061636542756433343132",
            quantity: "1"
          },
          %{
            unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
            quantity: "125"
          }
        ])
      end)

      assert {:ok, result} =
               Accounts.assets_associated_with_account_address(
                 Blockfrost,
                 "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7"
               )

      assert [
               %AssetAssociatedWithAccountAddress{
                 unit:
                   "d5e6bf0500378d4f0da4e8dde6becec7621cd8cbf5cbb9b87013d4cc537061636542756433343132",
                 quantity: "1"
               },
               %AssetAssociatedWithAccountAddress{
                 unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                 quantity: "125"
               }
             ] == result
    end
  end
end
