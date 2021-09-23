# blockfrost-elixir
## Installation
To install, add in your mix dependencies:

```elixir
{:blockfrost, "~> 0.2"}
```

Run `mix deps.get` and see the usage section on more information about how to
 start using it.

## Usage
<!-- MDOC -->
Blockfrost is an Elixir client for the Blockfrost API.

Each client is a supervision tree, and you can start more than one supervision
tree if you want to query more than a network or use more than one project.

For example, if you want to start a Cardano main net and an IPFS client:

```elixir
defmodule MyApp.Application do
  def start(_type, _args) do
    children = [
      {Blockfrost, [
        network: :cardano_mainnet,
        name: CardanoMainNet,
        api_key: System.get_env("CARDANO_API_KEY"),
        retry_enabled?: true,
        retry_max_attempts: 3
      ]},
      {Blockfrost, [
        network: :ipfs,
        name: IPFS,
        api_key: System.get_env("IPFS_API_KEY"),
        retry_enabled?: false
      ]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
  end
end
```

Then you're ready to use your clients:

```elixir
{:ok, pools} = Blockfrost.Cardano.Pools.list_of_stake_pools(CardanoMainNet)
```

## Shared Options

### Pagination Options

Unless specified otherwise, all Blockfrost functions that support pagination
support the following options:

* `:page` - The page to be fetched. If set to `:all`, will try to fetch all
    pages, with retries. If some of the pages fail, the first error is returned.
    Defaults to `1`.
* `:count` - The number of entries to be returned per page. Must be between
    1 and 100. Defaults to `100`.
* `:order` - The ordering of items from the point of view of the blockchain,
    not the page listing itself. By default, Blockfrost return oldest first, 
    newest last.
* `:max_concurrency` - If page was set to `:all`, sets how many concurrent
  requests will be made to the Blockfrost API. Defaults to `10`.

### HTTP Options

All Blockfrost API call functions support the following options:

* `:retry_enabled?` - whether it should retry failing requests. 
* `:retry_max_attempts` - max retry attempts
* `:retry_interval` - interval between attempts

If some of these options is not given, they default to the configured
values.
