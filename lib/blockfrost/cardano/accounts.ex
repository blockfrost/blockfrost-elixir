defmodule Blockfrost.Cardano.Accounts do
  @moduledoc """

  """
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
  """
  def specific_account_address(name, stake_address, opts \\ [])
      when is_binary(stake_address) do
    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}", opts)
    |> Response.deserialize(SpecificAccountAddressResponse)
  end

  @doc """
  """
  def account_reward_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/rewards", opts)
    |> Response.deserialize(AccountRewardHistoryResponse)
  end

  @doc """
  """
  def account_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/history", opts)
    |> Response.deserialize(AccountHistoryResponse)
  end

  @doc """
  """
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
  """
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
  """
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
  """
  def account_mir_history(name, stake_address, opts \\ []) do
    opts = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/mirs", opts)
    |> Response.deserialize(AccountMIRHistoryResponse)
  end

  @doc """
  """
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
  """
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
