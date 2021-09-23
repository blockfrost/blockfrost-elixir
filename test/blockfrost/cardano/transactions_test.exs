defmodule Blockfrost.Cardano.TransactionsTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Transactions
  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    SpecificTransactionResponse,
    TransactionUTXOsResponse,
    TransactionStakeAddressCertificatesResponse,
    TransactionDelegationCertificatesResponse,
    TransactionWithdrawalsResponse,
    TransactionMIRsResponse,
    TransactionStakePoolRetirementCertificatesResponse,
    TransactionMetadataResponse,
    TransactionMetadataCBORResponse,
    TransactionRedeemersResponse
  }

  alias Blockfrost.Response.TransactionStakePoolRegistrationAndUpdateCertificatesResponse,
    as: Update

  @transaction_hash "1020"

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "specific_transaction/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}"

        response(
          200,
          %{
            hash: "1e043f100dce12d107f679685acd2fc0610e10f72a92d412794c9773d11d8477",
            block: "356b7d7dbb696ccd12775c016941057a9dc70898d87a63fc752271bb46856940",
            block_height: 123_456,
            slot: 42_000_000,
            index: 1,
            output_amount: [
              %{
                unit: "lovelace",
                quantity: "42000000"
              },
              %{
                unit: "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                quantity: "12"
              }
            ],
            fees: "182485",
            deposit: "0",
            size: 433,
            invalid_before: nil,
            invalid_hereafter: "13885913",
            utxo_count: 4,
            withdrawal_count: 0,
            mir_cert_count: 0,
            delegation_count: 0,
            stake_cert_count: 0,
            pool_update_count: 0,
            pool_retire_count: 0,
            asset_mint_or_burn_count: 0,
            redeemer_count: 0
          }
        )
      end)

      assert {:ok,
              %SpecificTransactionResponse{
                hash: "1e043f100dce12d107f679685acd2fc0610e10f72a92d412794c9773d11d8477",
                block: "356b7d7dbb696ccd12775c016941057a9dc70898d87a63fc752271bb46856940",
                block_height: 123_456,
                slot: 42_000_000,
                index: 1,
                output_amount: [
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
                fees: "182485",
                deposit: "0",
                size: 433,
                invalid_before: nil,
                invalid_hereafter: "13885913",
                utxo_count: 4,
                withdrawal_count: 0,
                mir_cert_count: 0,
                delegation_count: 0,
                stake_cert_count: 0,
                pool_update_count: 0,
                pool_retire_count: 0,
                asset_mint_or_burn_count: 0,
                redeemer_count: 0
              }} == Transactions.specific_transaction(Blockfrost, @transaction_hash)
    end
  end

  describe "transaction_utxos/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/utxos"

        response(
          200,
          %{
            hash: @transaction_hash,
            inputs: [
              %{
                address:
                  "addr1q9ld26v2lv8wvrxxmvg90pn8n8n5k6tdst06q2s856rwmvnueldzuuqmnsye359fqrk8hwvenjnqultn7djtrlft7jnq7dy7wv",
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
                tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dce628516157f0",
                output_index: 0,
                data_hash: "string",
                collateral: false
              }
            ],
            outputs: [
              %{
                address:
                  "addr1q9ld26v2lv8wvrxxmvg90pn8n8n5k6tdst06q2s856rwmvnueldzuuqmnsye359fqrk8hwvenjnqultn7djtrlft7jnq7dy7wv",
                amount: [
                  %{
                    unit: "lovelace",
                    quantity: "42000000",
                    data_hash: nil
                  },
                  %{
                    unit:
                      "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                    quantity: "12",
                    data_hash: "9e478573ab81ea7a8e31891ce0648b81229f408d596a3483e6f4f9b92d3cf710"
                  }
                ]
              }
            ]
          }
        )
      end)

      assert {:ok,
              %TransactionUTXOsResponse{
                hash: @transaction_hash,
                inputs: [
                  %TransactionUTXOsResponse.UTXOInput{
                    address:
                      "addr1q9ld26v2lv8wvrxxmvg90pn8n8n5k6tdst06q2s856rwmvnueldzuuqmnsye359fqrk8hwvenjnqultn7djtrlft7jnq7dy7wv",
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
                    tx_hash: "1a0570af966fb355a7160e4f82d5a80b8681b7955f5d44bec0dce628516157f0",
                    output_index: 0,
                    data_hash: "string",
                    collateral: false
                  }
                ],
                outputs: [
                  %TransactionUTXOsResponse.UTXOOutput{
                    address:
                      "addr1q9ld26v2lv8wvrxxmvg90pn8n8n5k6tdst06q2s856rwmvnueldzuuqmnsye359fqrk8hwvenjnqultn7djtrlft7jnq7dy7wv",
                    amount: [
                      %TransactionUTXOsResponse.UTXOOutput.AmountWithDataHash{
                        unit: "lovelace",
                        quantity: "42000000",
                        data_hash: nil
                      },
                      %TransactionUTXOsResponse.UTXOOutput.AmountWithDataHash{
                        unit:
                          "b0d07d45fe9514f80213f4020e5a61241458be626841cde717cb38a76e7574636f696e",
                        quantity: "12",
                        data_hash:
                          "9e478573ab81ea7a8e31891ce0648b81229f408d596a3483e6f4f9b92d3cf710"
                      }
                    ]
                  }
                ]
              }} == Transactions.utxos(Blockfrost, @transaction_hash)
    end
  end

  describe "stake_address_certificates/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/stakes"

        response(
          200,
          [
            %{
              cert_index: 0,
              address: "stake1u9t3a0tcwune5xrnfjg4q7cpvjlgx9lcv0cuqf5mhfjwrvcwrulda",
              registration: true
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionStakeAddressCertificatesResponse.StakeAddressCertificate{
                  cert_index: 0,
                  address: "stake1u9t3a0tcwune5xrnfjg4q7cpvjlgx9lcv0cuqf5mhfjwrvcwrulda",
                  registration: true
                }
              ]} == Transactions.stake_address_certificates(Blockfrost, @transaction_hash)
    end
  end

  describe "delegation_certificates/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/delegations"

        response(
          200,
          [
            %{
              index: 0,
              cert_index: 0,
              address: "stake1u9r76ypf5fskppa0cmttas05cgcswrttn6jrq4yd7jpdnvc7gt0yc",
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
              active_epoch: 210
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionDelegationCertificatesResponse.DelegationCertificate{
                  index: 0,
                  cert_index: 0,
                  address: "stake1u9r76ypf5fskppa0cmttas05cgcswrttn6jrq4yd7jpdnvc7gt0yc",
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                  active_epoch: 210
                }
              ]} == Transactions.delegation_certificates(Blockfrost, @transaction_hash)
    end
  end

  describe "withdrawals/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/withdrawals"

        response(
          200,
          [
            %{
              address: "stake1u9r76ypf5fskppa0cmttas05cgcswrttn6jrq4yd7jpdnvc7gt0yc",
              amount: "431833601"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionWithdrawalsResponse.Withdrawal{
                  address: "stake1u9r76ypf5fskppa0cmttas05cgcswrttn6jrq4yd7jpdnvc7gt0yc",
                  amount: "431833601"
                }
              ]} == Transactions.withdrawals(Blockfrost, @transaction_hash)
    end
  end

  describe "mirs/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/mirs"

        response(
          200,
          [
            %{
              pot: "reserve",
              cert_index: 0,
              address: "stake1u9r76ypf5fskppa0cmttas05cgcswrttn6jrq4yd7jpdnvc7gt0yc",
              amount: "431833601"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionMIRsResponse.MIR{
                  pot: :reserve,
                  cert_index: 0,
                  address: "stake1u9r76ypf5fskppa0cmttas05cgcswrttn6jrq4yd7jpdnvc7gt0yc",
                  amount: "431833601"
                }
              ]} == Transactions.mirs(Blockfrost, @transaction_hash)
    end
  end

  describe "stake_pool_registration_and_update_certificates/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/updates"

        response(
          200,
          [
            %{
              cert_index: 0,
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
              vrf_key: "0b5245f9934ec2151116fb8ec00f35fd00e0aa3b075c4ed12cce440f999d8233",
              pledge: "5000000000",
              margin_cost: 0.05,
              fixed_cost: "340000000",
              reward_account: "stake1uxkptsa4lkr55jleztw43t37vgdn88l6ghclfwuxld2eykgpgvg3f",
              owners: [
                "stake1u98nnlkvkk23vtvf9273uq7cph5ww6u2yq2389psuqet90sv4xv9v"
              ],
              metadata: %{
                url: "https://stakenuts.com/mainnet.json",
                hash: "47c0c68cb57f4a5b4a87bad896fc274678e7aea98e200fa14a1cb40c0cab1d8c",
                ticker: "NUTS",
                name: "Stake Nuts",
                description: "The best pool ever",
                homepage: "https://stakentus.com/"
              },
              relays: [
                %{
                  ipv4: "4.4.4.4",
                  ipv6: "https://stakenuts.com/mainnet.json",
                  dns: "relay1.stakenuts.com",
                  dns_srv: "_relays._tcp.relays.stakenuts.com",
                  port: 3001
                }
              ],
              active_epoch: 210
            }
          ]
        )
      end)

      assert {:ok,
              [
                %Update.Certificate{
                  cert_index: 0,
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                  vrf_key: "0b5245f9934ec2151116fb8ec00f35fd00e0aa3b075c4ed12cce440f999d8233",
                  pledge: "5000000000",
                  margin_cost: 0.05,
                  fixed_cost: "340000000",
                  reward_account: "stake1uxkptsa4lkr55jleztw43t37vgdn88l6ghclfwuxld2eykgpgvg3f",
                  owners: [
                    "stake1u98nnlkvkk23vtvf9273uq7cph5ww6u2yq2389psuqet90sv4xv9v"
                  ],
                  metadata: %Blockfrost.Shared.StakePoolMetadata{
                    url: "https://stakenuts.com/mainnet.json",
                    hash: "47c0c68cb57f4a5b4a87bad896fc274678e7aea98e200fa14a1cb40c0cab1d8c",
                    ticker: "NUTS",
                    name: "Stake Nuts",
                    description: "The best pool ever",
                    homepage: "https://stakentus.com/"
                  },
                  relays: [
                    %Blockfrost.Shared.StakePoolRelay{
                      ipv4: "4.4.4.4",
                      ipv6: "https://stakenuts.com/mainnet.json",
                      dns: "relay1.stakenuts.com",
                      dns_srv: "_relays._tcp.relays.stakenuts.com",
                      port: 3001
                    }
                  ],
                  active_epoch: 210
                }
              ]} ==
               Transactions.stake_pool_registration_and_update_certificates(
                 Blockfrost,
                 @transaction_hash
               )
    end
  end

  describe "stake_pool_retirement_certificates/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/pool_retires"

        response(
          200,
          [
            %{
              cert_index: 0,
              pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
              retiring_epoch: 216
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionStakePoolRetirementCertificatesResponse.Certificate{
                  cert_index: 0,
                  pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                  retiring_epoch: 216
                }
              ]} == Transactions.stake_pool_retirement_certificates(Blockfrost, @transaction_hash)
    end
  end

  describe "metadata/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/metadata"

        response(
          200,
          [
            %{
              label: "1967",
              json_metadata: %{
                metadata: "https://nut.link/metadata.json",
                hash: "6bf124f217d0e5a0a8adb1dbd8540e1334280d49ab861127868339f43b3948af"
              }
            },
            %{
              label: "1968",
              json_metadata: %{
                ADAUSD: [
                  %{
                    value: "0.10409800535729975",
                    source: "ergoOracles"
                  }
                ]
              }
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionMetadataResponse.Metadata{
                  label: "1967",
                  json_metadata: %{
                    "hash" => "6bf124f217d0e5a0a8adb1dbd8540e1334280d49ab861127868339f43b3948af",
                    "metadata" => "https://nut.link/metadata.json"
                  }
                },
                %TransactionMetadataResponse.Metadata{
                  label: "1968",
                  json_metadata: %{
                    "ADAUSD" => [
                      %{
                        "value" => "0.10409800535729975",
                        "source" => "ergoOracles"
                      }
                    ]
                  }
                }
              ]} == Transactions.metadata(Blockfrost, @transaction_hash)
    end
  end

  describe "metadata_cbor/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/metadata_cbor"

        response(
          200,
          [
            %{
              label: "1968",
              cbor_metadata: "\\xa100a16b436f6d62696e6174696f6e8601010101010c"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionMetadataCBORResponse.MetadataCBOR{
                  label: "1968",
                  cbor_metadata: "\\xa100a16b436f6d62696e6174696f6e8601010101010c"
                }
              ]} == Transactions.metadata_cbor(Blockfrost, @transaction_hash)
    end
  end

  describe "redeemers/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/txs/#{@transaction_hash}/redeemers"

        response(
          200,
          [
            %{
              tx_index: 0,
              purpose: "spend",
              unit_mem: "1700",
              unit_steps: "476468",
              fee: "172033"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %TransactionRedeemersResponse.Redeemer{
                  tx_index: 0,
                  purpose: :spend,
                  unit_mem: "1700",
                  unit_steps: "476468",
                  fee: "172033"
                }
              ]} == Transactions.redeemers(Blockfrost, @transaction_hash)
    end
  end

  describe "submit/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/tx/submit"
        assert {"Content-Type", "application/cbor"} in request.headers
        assert request.body == "mycborhere"

        response(200, @transaction_hash)
      end)

      assert {:ok, @transaction_hash} == Transactions.submit(Blockfrost, "mycborhere")
    end
  end
end
