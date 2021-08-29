defmodule Blockfrost.Cardano.AddresesTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Addresses

  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    SpecificAddressResponse,
    AddressDetailsResponse,
    AddressTransactionsResponse,
    AddressUTXOsResponse,
    AddressTransactionsResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "specific_address/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/addresses/addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz"

        response(200, %{
          address:
            "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz",
          amount: [
            %{
              unit: "lovelace",
              quantity: "42000000"
            },
            %{
              unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
              quantity: "12"
            }
          ],
          stake_address: "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7",
          type: "shelley"
        })
      end)

      assert {:ok,
              %SpecificAddressResponse{
                address:
                  "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz",
                amount: [
                  %Blockfrost.Shared.Amount{
                    unit: "lovelace",
                    quantity: "42000000"
                  },
                  %Blockfrost.Shared.Amount{
                    unit:
                      "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                    quantity: "12"
                  }
                ],
                stake_address: "stake1ux3g2c9dx2nhhehyrezyxpkstartcqmu9hk63qgfkccw5rqttygt7",
                type: :shelley
              }} =
               Addresses.specific_address(
                 Blockfrost,
                 "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz"
               )
    end
  end

  describe "address_details/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/addresses/addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz/total"

        response(
          200,
          %{
            address:
              "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz",
            received_sum: [
              %{
                unit: "lovelace",
                quantity: "42000000"
              },
              %{
                unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                quantity: "12"
              }
            ],
            sent_sum: [
              %{
                unit: "lovelace",
                quantity: "42000000"
              },
              %{
                unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                quantity: "12"
              }
            ],
            tx_count: 12
          }
        )
      end)

      assert {:ok,
              %AddressDetailsResponse{
                address:
                  "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz",
                received_sum: [
                  %{
                    unit: "lovelace",
                    quantity: "42000000"
                  },
                  %{
                    unit:
                      "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                    quantity: "12"
                  }
                ],
                sent_sum: [
                  %{
                    unit: "lovelace",
                    quantity: "42000000"
                  },
                  %{
                    unit:
                      "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                    quantity: "12"
                  }
                ],
                tx_count: 12
              }} =
               Addresses.address_details(
                 Blockfrost,
                 "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz"
               )
    end
  end

  describe "address_utxos/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/addresses/addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz/utxos"

        response(
          200,
          [
            %{
              tx_hash: "39a7a284c2a0948189dc45dec670211cd4d72f7b66c5726c08d9b3df11e44d58",
              output_index: 0,
              amount: [
                %{
                  unit: "lovelace",
                  quantity: "42000000"
                }
              ],
              block: "7eb8e27d18686c7db9a18f8bbcfe34e3fed6e047afaa2d969904d15e934847e6"
            },
            %{
              tx_hash: "4c4e67bafa15e742c13c592b65c8f74c769cd7d9af04c848099672d1ba391b49",
              output_index: 0,
              amount: [
                %{
                  unit: "lovelace",
                  quantity: "729235000"
                }
              ],
              block: "953f1b80eb7c11a7ffcd67cbd4fde66e824a451aca5a4065725e5174b81685b7"
            },
            %{
              tx_hash: "768c63e27a1c816a83dc7b07e78af673b2400de8849ea7e7b734ae1333d100d2",
              output_index: 1,
              amount: [
                %{
                  unit: "lovelace",
                  quantity: "42000000"
                },
                %{
                  unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                  quantity: "12"
                }
              ],
              block: "5c571f83fe6c784d3fbc223792627ccf0eea96773100f9aedecf8b1eda4544d7"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %AddressUTXOsResponse.UTXO{
                  tx_hash: "39a7a284c2a0948189dc45dec670211cd4d72f7b66c5726c08d9b3df11e44d58",
                  output_index: 0,
                  amount: [
                    %{
                      unit: "lovelace",
                      quantity: "42000000"
                    }
                  ],
                  block: "7eb8e27d18686c7db9a18f8bbcfe34e3fed6e047afaa2d969904d15e934847e6"
                },
                %AddressUTXOsResponse.UTXO{
                  tx_hash: "4c4e67bafa15e742c13c592b65c8f74c769cd7d9af04c848099672d1ba391b49",
                  output_index: 0,
                  amount: [
                    %{
                      unit: "lovelace",
                      quantity: "729235000"
                    }
                  ],
                  block: "953f1b80eb7c11a7ffcd67cbd4fde66e824a451aca5a4065725e5174b81685b7"
                },
                %AddressUTXOsResponse.UTXO{
                  tx_hash: "768c63e27a1c816a83dc7b07e78af673b2400de8849ea7e7b734ae1333d100d2",
                  output_index: 1,
                  amount: [
                    %{
                      unit: "lovelace",
                      quantity: "42000000"
                    },
                    %{
                      unit:
                        "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                      quantity: "12"
                    }
                  ],
                  block: "5c571f83fe6c784d3fbc223792627ccf0eea96773100f9aedecf8b1eda4544d7"
                }
              ]} =
               Addresses.address_utxos(
                 Blockfrost,
                 "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz"
               )
    end
  end

  describe "address_transactions/1,2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/addresses/addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz/transactions"

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
                %AddressTransactionsResponse.Transaction{
                  tx_hash: "8788591983aa73981fc92d6cddbbe643959f5a784e84b8bee0db15823f575a5b",
                  tx_index: 6,
                  block_height: 69
                },
                %AddressTransactionsResponse.Transaction{
                  tx_hash: "52e748c4dec58b687b90b0b40d383b9fe1f24c1a833b7395cdf07dd67859f46f",
                  tx_index: 9,
                  block_height: 4547
                },
                %AddressTransactionsResponse.Transaction{
                  tx_hash: "e8073fd5318ff43eca18a852527166aa8008bee9ee9e891f585612b7e4ba700b",
                  tx_index: 0,
                  block_height: 564_654
                }
              ]} =
               Addresses.address_transactions(
                 Blockfrost,
                 "addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz"
               )
    end
  end
end
