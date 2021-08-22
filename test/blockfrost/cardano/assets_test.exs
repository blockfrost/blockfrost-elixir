defmodule Blockfrost.Cardano.AssetsTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Assets

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    AssetsResponse,
    SpecificAssetResponse,
    AssetHistoryResponse,
    AssetTransactionsResponse,
    AssetAddressesResponse,
    SpecificPolicyAssetsResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "assets/0,1,2" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/assets"

        response(
          200,
          [
            %{
              asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
              quantity: "1"
            },
            %{
              asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e75d",
              quantity: "100000"
            },
            %{
              asset: "6804edf9712d2b619edb6ac86861fe93a730693183a262b165fcc1ba1bc99cad",
              quantity: "18605647"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %AssetsResponse.Asset{
                  asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                  quantity: "1"
                },
                %AssetsResponse.Asset{
                  asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e75d",
                  quantity: "100000"
                },
                %AssetsResponse.Asset{
                  asset: "6804edf9712d2b619edb6ac86861fe93a730693183a262b165fcc1ba1bc99cad",
                  quantity: "18605647"
                }
              ]} == Assets.assets()
    end
  end

  describe "specific_asset/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/assets/b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e"

        response(
          200,
          %{
            asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
            policy_id: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a7",
            asset_name: "6e7574636f696e",
            fingerprint: "asset1pkpwyknlvul7az0xx8czhl60pyel45rpje4z8w",
            quantity: "12000",
            initial_mint_tx_hash:
              "6804edf9712d2b619edb6ac86861fe93a730693183a262b165fcc1ba1bc99cad",
            mint_or_burn_count: 1,
            onchain_metadata: %{
              name: "My NFT token",
              image: "ipfs://ipfs/QmfKyJ4tuvHowwKQCbCHj4L5T3fSj8cjs7Aau8V7BWv226"
            },
            metadata: %{
              name: "nutcoin",
              description: "The Nut Coin",
              ticker: "nutc",
              url: "https://www.stakenuts.com/",
              logo: "iVBOR",
              decimals: 6
            }
          }
        )
      end)

      assert {:ok,
              %SpecificAssetResponse{
                asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                policy_id: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a7",
                asset_name: "6e7574636f696e",
                fingerprint: "asset1pkpwyknlvul7az0xx8czhl60pyel45rpje4z8w",
                quantity: "12000",
                initial_mint_tx_hash:
                  "6804edf9712d2b619edb6ac86861fe93a730693183a262b165fcc1ba1bc99cad",
                mint_or_burn_count: 1,
                onchain_metadata: %SpecificAssetResponse.OnchainMetadata{
                  name: "My NFT token",
                  image: "ipfs://ipfs/QmfKyJ4tuvHowwKQCbCHj4L5T3fSj8cjs7Aau8V7BWv226"
                },
                metadata: %SpecificAssetResponse.Metadata{
                  name: "nutcoin",
                  description: "The Nut Coin",
                  ticker: "nutc",
                  url: "https://www.stakenuts.com/",
                  logo: "iVBOR",
                  decimals: 6
                }
              }} ==
               Assets.specific_asset(
                 "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e"
               )
    end
  end

  describe "asset_history/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/assets/b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e/history"

        response(
          200,
          [
            %{
              tx_hash: "2dd15e0ef6e6a17841cb9541c27724072ce4d4b79b91e58432fbaa32d9572531",
              amount: "10",
              action: "minted"
            },
            %{
              tx_hash: "9c190bc1ac88b2ab0c05a82d7de8b71b67a9316377e865748a89d4426c0d3005",
              amount: "5",
              action: "burned"
            },
            %{
              tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dde628516157f0",
              amount: "5",
              action: "burned"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %AssetHistoryResponse.AssetHistory{
                  tx_hash: "2dd15e0ef6e6a17841cb9541c27724072ce4d4b79b91e58432fbaa32d9572531",
                  amount: "10",
                  action: :minted
                },
                %AssetHistoryResponse.AssetHistory{
                  tx_hash: "9c190bc1ac88b2ab0c05a82d7de8b71b67a9316377e865748a89d4426c0d3005",
                  amount: "5",
                  action: :burned
                },
                %AssetHistoryResponse.AssetHistory{
                  tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dde628516157f0",
                  amount: "5",
                  action: :burned
                }
              ]} ==
               Assets.asset_history(
                 "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e"
               )
    end
  end

  describe "asset_transactions/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/assets/b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e/transactions"

        response(
          200,
          [
            %{
              tx_hash: "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
              tx_index: 6,
              block_height: 69
            },
            %{
              tx_hash: "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
              tx_index: 9,
              block_height: 4547
            },
            %{
              tx_hash: "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b",
              tx_index: 0,
              block_height: 564_654
            }
          ]
        )
      end)

      assert {:ok,
              [
                %AssetTransactionsResponse.Transaction{
                  tx_hash: "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
                  tx_index: 6,
                  block_height: 69
                },
                %AssetTransactionsResponse.Transaction{
                  tx_hash: "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
                  tx_index: 9,
                  block_height: 4547
                },
                %AssetTransactionsResponse.Transaction{
                  tx_hash: "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b",
                  tx_index: 0,
                  block_height: 564_654
                }
              ]} ==
               Assets.asset_transactions(
                 "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e"
               )
    end
  end

  describe "asset_addresses/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/assets/b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e/addresses"

        response(
          200,
          [
            %{
              address:
                "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz",
              quantity: "1"
            },
            %{
              address:
                "addr1qyhr4exrgavdcn3qhfcc9f939fzsch2re5ry9cwvcdyh4x4re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qdpvhza",
              quantity: "100000"
            },
            %{
              address:
                "addr1q8zup8m9ue3p98kxlxl9q8rnyan8hw3ul282tsl9s326dfj088lvedv4zckcj24arcpasr0gua4c5gq4zw2rpcpjk2lq8cmd9l",
              quantity: "18605647"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %AssetAddressesResponse.AssetAddress{
                  address:
                    "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz",
                  quantity: "1"
                },
                %AssetAddressesResponse.AssetAddress{
                  address:
                    "addr1qyhr4exrgavdcn3qhfcc9f939fzsch2re5ry9cwvcdyh4x4re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qdpvhza",
                  quantity: "100000"
                },
                %AssetAddressesResponse.AssetAddress{
                  address:
                    "addr1q8zup8m9ue3p98kxlxl9q8rnyan8hw3ul282tsl9s326dfj088lvedv4zckcj24arcpasr0gua4c5gq4zw2rpcpjk2lq8cmd9l",
                  quantity: "18605647"
                }
              ]} ==
               Assets.asset_addresses(
                 "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e"
               )
    end
  end

  describe "specific_policy_assets/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/assets/policy/476039a0949cf0b22f6a800f56780184c44533887ca6e821007840c3"

        response(
          200,
          [
            %{
              asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
              quantity: "1"
            },
            %{
              asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a766e",
              quantity: "100000"
            },
            %{
              asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb574636f696e",
              quantity: "18605647"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %SpecificPolicyAssetsResponse.Asset{
                  asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                  quantity: "1"
                },
                %SpecificPolicyAssetsResponse.Asset{
                  asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a766e",
                  quantity: "100000"
                },
                %SpecificPolicyAssetsResponse.Asset{
                  asset: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb574636f696e",
                  quantity: "18605647"
                }
              ]} ==
               Assets.specific_policy_assets(
                 "476039a0949cf0b22f6a800f56780184c44533887ca6e821007840c3"
               )
    end
  end
end
