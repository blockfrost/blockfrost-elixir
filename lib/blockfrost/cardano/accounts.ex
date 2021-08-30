defmodule Blockfrost.Cardano.Accounts do
  @moduledoc "Functions for to the /accounts namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    SpecificAccountAddressResponse,
    AccountRewardHistoryResponse,
    AccountHistoryResponse,
    AccountDelegationHistoryResponse,
    AccountRegistrationHistoryResponse,
    AccountWithdrawalHistoryResponse,
    AccountMIRHistoryResponse,
    AccountAssociatedAdressesResponse,
    AssetsAssociatedWithAccountAddressResponse
  }

  @doc """
  Obtains information about a specific account address

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}/get)
  """
  @spec specific_account_address(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, SpecificAccountAddressResponse.t()} | HTTP.error_response()
  def specific_account_address(name, stake_address, opts \\ [])
      when is_binary(stake_address) do
    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}", opts)
    |> Response.deserialize(SpecificAccountAddressResponse)
  end

  @doc """
  Obtains reward history of a specific account

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1rewards/get)
  """
  @spec account_reward_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountRewardHistoryResponse.t()} | HTTP.error_response()

  def account_reward_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/rewards", opts)
    |> Response.deserialize(AccountRewardHistoryResponse)
  end

  @doc """
  Obtains information about the history of a specific account

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1history/get)
  """
  @spec account_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountHistoryResponse.t()} | HTTP.error_response()
  def account_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/history", opts)
    |> Response.deserialize(AccountHistoryResponse)
  end

  @doc """
  Obtains information about the delegation history of a specific acc

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1delegations/get)
  """
  @spec account_delegation_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountDelegationHistoryResponse.t()} | HTTP.error_response()
  def account_delegation_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/delegations",
      opts
    )
    |> Response.deserialize(AccountDelegationHistoryResponse)
  end

  @doc """
  Obtains the registration history of a specific account

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1registrations/get)
  """
  @spec account_registration_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountRegistrationHistoryResponse.t()} | HTTP.error_response()
  def account_registration_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/registrations",
      opts
    )
    |> Response.deserialize(AccountRegistrationHistoryResponse)
  end

  @doc """
  Obtains the retrieval history of a specific account

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1withdrawals/get)
  """
  @spec account_withdrawal_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountWithdrawalHistoryResponse.t()} | HTTP.error_response()
  def account_withdrawal_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/withdrawals",
      opts
    )
    |> Response.deserialize(AccountWithdrawalHistoryResponse)
  end

  @doc """
  Obtains the MIR history of a specific account

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1mirs/get)
  """
  @spec account_mir_history(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountMIRHistoryResponse.t()} | HTTP.error_response()
  def account_mir_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/mirs", opts)
    |> Response.deserialize(AccountMIRHistoryResponse)
  end

  @doc """
  Obtains the addresses associated to a specific account

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1addresses/get)
  """
  @spec account_associated_addresses(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AccountAssociatedAdressesResponse.t()} | HTTP.error_response()
  def account_associated_addresses(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/addresses",
      opts
    )
    |> Response.deserialize(AccountAssociatedAdressesResponse)
  end

  @doc """
  Obtain information about assets associated with addresses of a specific account.

  Be careful, as an account could be part of a mangled address and does not necessarily mean the addresses are owned by user as the account.

  Supports pagination.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Accounts/paths/~1accounts~1{stake_address}~1addresses/get)
  """
  @spec assets_associated_with_account_address(Blockfrost.t(), String.t(), Keyword.t()) ::
          {:ok, AssetsAssociatedWithAccountAddressResponse.t()} | HTTP.error_response()
  def assets_associated_with_account_address(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/addresses/assets",
      opts
    )
    |> Response.deserialize(AssetsAssociatedWithAccountAddressResponse)
  end
end
