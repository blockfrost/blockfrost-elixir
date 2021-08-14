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
  def specific_account_address(name \\ Blockfrost, stake_address, opts \\ [])
      when is_binary(stake_address) do
    req = HTTP.build(name, :get, "/accounts/#{stake_address}")

    name
    |> HTTP.request(req, opts)
    |> Response.deserialize(SpecificAccountAddressResponse)
  end

  @doc """
  """
  def account_reward_history(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/rewards", pagination, %{}, nil, opts)
    |> Response.deserialize(AccountRewardHistoryResponse)
  end

  @doc """
  """
  def account_history(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/history", pagination, %{}, nil, opts)
    |> Response.deserialize(AccountHistoryResponse)
  end

  @doc """
  """
  def account_delegation_history(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/delegations",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(AccountDelegationHistoryResponse)
  end

  @doc """
  """
  def account_registration_history(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/registrations",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(AccountRegistrationHistoryResponse)
  end

  @doc """
  """
  def account_withdrawal_history(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/withdrawals",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(AccountWithdrawalHistoryResponse)
  end

  @doc """
  """
  def account_mir_history(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(:get, "/accounts/#{stake_address}/mirs", pagination, %{}, nil, opts)
    |> Response.deserialize(AccountMIRHistoryResponse)
  end

  @doc """
  """
  def account_associated_addresses(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/addresses",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(AccountAssociatedAdressesResponse)
  end

  @doc """
  """
  def assets_associated_with_account_address(name \\ Blockfrost, stake_address, opts \\ []) do
    pagination = Utils.extract_pagination(opts)

    name
    |> HTTP.build_and_send(
      :get,
      "/accounts/#{stake_address}/addresses/assets",
      pagination,
      %{},
      nil,
      opts
    )
    |> Response.deserialize(AssetsAssociatedWithAccountAddressResponse)
  end
end
