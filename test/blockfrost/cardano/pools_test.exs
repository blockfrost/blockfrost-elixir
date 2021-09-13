defmodule Blockfrost.Cardano.PoolsTest do
  use Blockfrost.Case

  alias Blockfrost.Cardano.Pools
  alias Blockfrost.HTTPClientMock

  alias Blockfrost.Response.{
    ListOfRetiredStakePoolsResponse,
    ListOfRetiringStakePoolsResponse,
    SpecificStakePoolResponse,
    StakePoolHistoryResponse,
    StakePoolMetadataResponse,
    StakePoolRelaysResponse,
    StakePoolDelegatorsResponse,
    StakePoolUpdatesResponse
  }

  setup_all do
    start_supervised!({Blockfrost, api_key: "apikey", network: :cardano_testnet})
    :ok
  end

  describe "list_of_stake_pools/1" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/pools"

        response(200, [
          "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
          "pool1hn7hlwrschqykupwwrtdfkvt2u4uaxvsgxyh6z63703p2knj288",
          "pool1ztjyjfsh432eqetadf82uwuxklh28xc85zcphpwq6mmezavzad2"
        ])
      end)

      assert {:ok,
              [
                "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                "pool1hn7hlwrschqykupwwrtdfkvt2u4uaxvsgxyh6z63703p2knj288",
                "pool1ztjyjfsh432eqetadf82uwuxklh28xc85zcphpwq6mmezavzad2"
              ]} == Pools.list_of_stake_pools(Blockfrost)
    end
  end

  describe "list_of_retired_stake_pools/1" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/pools/retired"

        response(
          200,
          [
            %{
              pool_id: "pool19u64770wqp6s95gkajc8udheske5e6ljmpq33awxk326zjaza0q",
              epoch: 225
            },
            %{
              pool_id: "pool1dvla4zq98hpvacv20snndupjrqhuc79zl6gjap565nku6et5zdx",
              epoch: 215
            },
            %{
              pool_id: "pool1wvccajt4eugjtf3k0ja3exjqdj7t8egsujwhcw4tzj4rzsxzw5w",
              epoch: 231
            }
          ]
        )
      end)

      assert {:ok,
              [
                %ListOfRetiredStakePoolsResponse.RetiredStakePool{
                  pool_id: "pool19u64770wqp6s95gkajc8udheske5e6ljmpq33awxk326zjaza0q",
                  epoch: 225
                },
                %ListOfRetiredStakePoolsResponse.RetiredStakePool{
                  pool_id: "pool1dvla4zq98hpvacv20snndupjrqhuc79zl6gjap565nku6et5zdx",
                  epoch: 215
                },
                %ListOfRetiredStakePoolsResponse.RetiredStakePool{
                  pool_id: "pool1wvccajt4eugjtf3k0ja3exjqdj7t8egsujwhcw4tzj4rzsxzw5w",
                  epoch: 231
                }
              ]} == Pools.list_of_retired_stake_pools(Blockfrost)
    end
  end

  describe "list_of_retiring_stake_pools/1" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path == "/api/v0/pools/retiring"

        response(
          200,
          [
            %{
              pool_id: "pool19u64770wqp6s95gkajc8udheske5e6ljmpq33awxk326zjaza0q",
              epoch: 225
            },
            %{
              pool_id: "pool1dvla4zq98hpvacv20snndupjrqhuc79zl6gjap565nku6et5zdx",
              epoch: 215
            },
            %{
              pool_id: "pool1wvccajt4eugjtf3k0ja3exjqdj7t8egsujwhcw4tzj4rzsxzw5w",
              epoch: 231
            }
          ]
        )
      end)

      assert {:ok,
              [
                %ListOfRetiringStakePoolsResponse.RetiringStakePool{
                  pool_id: "pool19u64770wqp6s95gkajc8udheske5e6ljmpq33awxk326zjaza0q",
                  epoch: 225
                },
                %ListOfRetiringStakePoolsResponse.RetiringStakePool{
                  pool_id: "pool1dvla4zq98hpvacv20snndupjrqhuc79zl6gjap565nku6et5zdx",
                  epoch: 215
                },
                %ListOfRetiringStakePoolsResponse.RetiringStakePool{
                  pool_id: "pool1wvccajt4eugjtf3k0ja3exjqdj7t8egsujwhcw4tzj4rzsxzw5w",
                  epoch: 231
                }
              ]} == Pools.list_of_retiring_stake_pools(Blockfrost)
    end
  end

  describe "specific_stake_pool/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"

        response(
          200,
          %{
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
            hex: "0f292fcaa02b8b2f9b3c8f9fd8e0bb21abedb692a6d5058df3ef2735",
            vrf_key: "0b5245f9934ec2151116fb8ec00f35fd00e0aa3b075c4ed12cce440f999d8233",
            blocks_minted: 69,
            live_stake: "6900000000",
            live_size: 0.42,
            live_saturation: 0.93,
            live_delegators: 127,
            active_stake: "4200000000",
            active_size: 0.43,
            declared_pledge: "5000000000",
            live_pledge: "5000000001",
            margin_cost: 0.05,
            fixed_cost: "340000000",
            reward_account: "stake1uxkptsa4lkr55jleztw43t37vgdn88l6ghclfwuxld2eykgpgvg3f",
            owners: [
              "stake1u98nnlkvkk23vtvf9273uq7cph5ww6u2yq2389psuqet90sv4xv9v"
            ],
            registration: [
              "9f83e5484f543e05b52e99988272a31da373f3aab4c064c76db96643a355d9dc",
              "7ce3b8c433bf401a190d58c8c483d8e3564dfd29ae8633c8b1b3e6c814403e95",
              "3e6e1200ce92977c3fe5996bd4d7d7e192bcb7e231bc762f9f240c76766535b9"
            ],
            retirement: [
              "252f622976d39e646815db75a77289cf16df4ad2b287dd8e3a889ce14c13d1a8"
            ]
          }
        )
      end)

      assert {:ok,
              %SpecificStakePoolResponse{
                pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                hex: "0f292fcaa02b8b2f9b3c8f9fd8e0bb21abedb692a6d5058df3ef2735",
                vrf_key: "0b5245f9934ec2151116fb8ec00f35fd00e0aa3b075c4ed12cce440f999d8233",
                blocks_minted: 69,
                live_stake: "6900000000",
                live_size: 0.42,
                live_saturation: 0.93,
                live_delegators: 127,
                active_stake: "4200000000",
                active_size: 0.43,
                declared_pledge: "5000000000",
                live_pledge: "5000000001",
                margin_cost: 0.05,
                fixed_cost: "340000000",
                reward_account: "stake1uxkptsa4lkr55jleztw43t37vgdn88l6ghclfwuxld2eykgpgvg3f",
                owners: [
                  "stake1u98nnlkvkk23vtvf9273uq7cph5ww6u2yq2389psuqet90sv4xv9v"
                ],
                registration: [
                  "9f83e5484f543e05b52e99988272a31da373f3aab4c064c76db96643a355d9dc",
                  "7ce3b8c433bf401a190d58c8c483d8e3564dfd29ae8633c8b1b3e6c814403e95",
                  "3e6e1200ce92977c3fe5996bd4d7d7e192bcb7e231bc762f9f240c76766535b9"
                ],
                retirement: [
                  "252f622976d39e646815db75a77289cf16df4ad2b287dd8e3a889ce14c13d1a8"
                ]
              }} ==
               Pools.specific_stake_pool(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end

  describe "stake_pool_history/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy/history"

        response(
          200,
          [
            %{
              epoch: 233,
              blocks: 22,
              active_stake: "20485965693569",
              active_size: 1.2345,
              delegators_count: 115,
              rewards: "206936253674159",
              fees: "1290968354"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %StakePoolHistoryResponse.StakePoolHistory{
                  epoch: 233,
                  blocks: 22,
                  active_stake: "20485965693569",
                  active_size: 1.2345,
                  delegators_count: 115,
                  rewards: "206936253674159",
                  fees: "1290968354"
                }
              ]} ==
               Pools.stake_pool_history(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end

  describe "stake_pool_metadata/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy/metadata"

        response(
          200,
          %{
            pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
            hex: "0f292fcaa02b8b2f9b3c8f9fd8e0bb21abedb692a6d5058df3ef2735",
            url: "https://stakenuts.com/mainnet.json",
            hash: "47c0c68cb57f4a5b4a87bad896fc274678e7aea98e200fa14a1cb40c0cab1d8c",
            ticker: "NUTS",
            name: "Stake Nuts",
            description: "The best pool ever",
            homepage: "https://stakentus.com/"
          }
        )
      end)

      assert {:ok,
              %StakePoolMetadataResponse{
                pool_id: "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy",
                hex: "0f292fcaa02b8b2f9b3c8f9fd8e0bb21abedb692a6d5058df3ef2735",
                url: "https://stakenuts.com/mainnet.json",
                hash: "47c0c68cb57f4a5b4a87bad896fc274678e7aea98e200fa14a1cb40c0cab1d8c",
                ticker: "NUTS",
                name: "Stake Nuts",
                description: "The best pool ever",
                homepage: "https://stakentus.com/"
              }} ==
               Pools.stake_pool_metadata(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end

  describe "stake_pool_relays/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy/relays"

        response(
          200,
          [
            %{
              ipv4: "4.4.4.4",
              ipv6: "https://stakenuts.com/mainnet.json",
              dns: "relay1.stakenuts.com",
              dns_srv: "_relays._tcp.relays.stakenuts.com",
              port: 3001
            }
          ]
        )
      end)

      assert {:ok,
              [
                %StakePoolRelaysResponse.StakePoolRelay{
                  ipv4: "4.4.4.4",
                  ipv6: "https://stakenuts.com/mainnet.json",
                  dns: "relay1.stakenuts.com",
                  dns_srv: "_relays._tcp.relays.stakenuts.com",
                  port: 3001
                }
              ]} ==
               Pools.stake_pool_relays(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end

  describe "stake_pool_delegators/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy/delegators"

        response(
          200,
          [
            %{
              address: "stake1ux4vspfvwuus9uwyp5p3f0ky7a30jq5j80jxse0fr7pa56sgn8kha",
              live_stake: "1137959159981411"
            },
            %{
              address: "stake1uylayej7esmarzd4mk4aru37zh9yz0luj3g9fsvgpfaxulq564r5u",
              live_stake: "16958865648"
            },
            %{
              address: "stake1u8lr2pnrgf8f7vrs9lt79hc3sxm8s2w4rwvgpncks3axx6q93d4ck",
              live_stake: "18605647"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %StakePoolDelegatorsResponse.StakePoolDelegator{
                  address: "stake1ux4vspfvwuus9uwyp5p3f0ky7a30jq5j80jxse0fr7pa56sgn8kha",
                  live_stake: "1137959159981411"
                },
                %StakePoolDelegatorsResponse.StakePoolDelegator{
                  address: "stake1uylayej7esmarzd4mk4aru37zh9yz0luj3g9fsvgpfaxulq564r5u",
                  live_stake: "16958865648"
                },
                %StakePoolDelegatorsResponse.StakePoolDelegator{
                  address: "stake1u8lr2pnrgf8f7vrs9lt79hc3sxm8s2w4rwvgpncks3axx6q93d4ck",
                  live_stake: "18605647"
                }
              ]} ==
               Pools.stake_pool_delegators(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end

  describe "stake_pool_blocks/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy/blocks"

        response(200, [
          "d8982ca42cfe76b747cc681d35d671050a9e41e9cfe26573eb214e94fe6ff21d",
          "026436c539e2ce84c7f77ffe669f4e4bbbb3b9c53512e5857dcba8bb0b4e9a8c",
          "bcc8487f419b8c668a18ea2120822a05df6dfe1de1f0fac3feba88cf760f303c",
          "86bf7b4a274e0f8ec9816171667c1b4a0cfc661dc21563f271acea9482b62df7"
        ])
      end)

      assert {:ok,
              [
                "d8982ca42cfe76b747cc681d35d671050a9e41e9cfe26573eb214e94fe6ff21d",
                "026436c539e2ce84c7f77ffe669f4e4bbbb3b9c53512e5857dcba8bb0b4e9a8c",
                "bcc8487f419b8c668a18ea2120822a05df6dfe1de1f0fac3feba88cf760f303c",
                "86bf7b4a274e0f8ec9816171667c1b4a0cfc661dc21563f271acea9482b62df7"
              ]} ==
               Pools.stake_pool_blocks(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end

  describe "stake_pool_updates/2,3" do
    test "properly decodes 200 response" do
      expect(HTTPClientMock, :request, fn request, _finch, _opts ->
        assert request.path ==
                 "/api/v0/pools/pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy/updates"

        response(
          200,
          [
            %{
              tx_hash: "6804edf9712d2b619edb6ac86861fe93a730693183a262b165fcc1ba1bc99cad",
              cert_index: 0,
              action: "registered"
            },
            %{
              tx_hash: "9c190bc1ac88b2ab0c05a82d7de8b71b67a9316377e865748a89d4426c0d3005",
              cert_index: 0,
              action: "deregistered"
            },
            %{
              tx_hash: "e14a75b0eb2625de7055f1f580d70426311b78e0d36dd695a6bdc96c7b3d80e0",
              cert_index: 1,
              action: "registered"
            }
          ]
        )
      end)

      assert {:ok,
              [
                %StakePoolUpdatesResponse.StakePoolUpdate{
                  tx_hash: "6804edf9712d2b619edb6ac86861fe93a730693183a262b165fcc1ba1bc99cad",
                  cert_index: 0,
                  action: "registered"
                },
                %StakePoolUpdatesResponse.StakePoolUpdate{
                  tx_hash: "9c190bc1ac88b2ab0c05a82d7de8b71b67a9316377e865748a89d4426c0d3005",
                  cert_index: 0,
                  action: "deregistered"
                },
                %StakePoolUpdatesResponse.StakePoolUpdate{
                  tx_hash: "e14a75b0eb2625de7055f1f580d70426311b78e0d36dd695a6bdc96c7b3d80e0",
                  cert_index: 1,
                  action: "registered"
                }
              ]} ==
               Pools.stake_pool_updates(
                 Blockfrost,
                 "pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy"
               )
    end
  end
end
