defmodule Blockfrost.Cardano.Transactions do
  @moduledoc "Functions for to the /transactions namespace in the Blockfrost API"

  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Utils

  alias Blockfrost.Response.{
    SpecificTransactionResponse,
    TransactionUTXOsResponse,
    TransactionStakeAddressCertificatesResponse,
    TransactionDelegationCertificatesResponse,
    TransactionWithdrawalsResponse,
    TransactionMIRsResponse,
    TransactionStakePoolRegistrationAndUpdateCertificatesResponse,
    TransactionStakePoolRetirementCertificatesResponse,
    TransactionMetadataResponse,
    TransactionMetadataCBORResponse,
    TransactionRedeemersResponse,
    SubmitTransactionResponse
  }

  @doc """
  Return content of the requested transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}/get)
  """
  @spec specific_transaction(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, SpecificTransactionResponse.t()} | HTTP.error_response()
  def specific_transaction(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}", opts)
    |> Response.deserialize(SpecificTransactionResponse)
  end

  @doc """
  Return the inputs and UTXOs of the specific transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1utxos/get)
  """
  @spec utxos(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionUTXOsResponse.t()} | HTTP.error_response()
  def utxos(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/utxos", opts)
    |> Response.deserialize(TransactionUTXOsResponse)
  end

  @doc """
  Obtain information about (de)registration of stake addresses within a transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1stakes/get)
  """
  @spec stake_address_certificates(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionStakeAddressCertificatesResponse.t()} | HTTP.error_response()
  def stake_address_certificates(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/stakes", opts)
    |> Response.deserialize(TransactionStakeAddressCertificatesResponse)
  end

  @doc """
  Obtain information about delegation certificates of a specific transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1delegations/get)
  """
  @spec delegation_certificates(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionDelegationCertificatesResponse.t()} | HTTP.error_response()
  def delegation_certificates(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/delegations", opts)
    |> Response.deserialize(TransactionDelegationCertificatesResponse)
  end

  @doc """
  Obtain information about withdrawals of a specific transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1delegations/get)
  """
  @spec withdrawals(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionWithdrawalsResponse.t()} | HTTP.error_response()
  def withdrawals(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/withdrawals", opts)
    |> Response.deserialize(TransactionWithdrawalsResponse)
  end

  @doc """
  Obtain information about Move Instantaneous Rewards (MIRs) of a specific transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1withdrawals/get)
  """
  @spec mirs(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionMIRsResponse.t()} | HTTP.error_response()
  def mirs(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/mirs", opts)
    |> Response.deserialize(TransactionMIRsResponse)
  end

  @doc """
  Obtain information about stake pool registration and update certificates of a specific transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1pool_updates/get)
  """
  @spec stake_pool_registration_and_update_certificates(
          Blockfrost.t(),
          hash :: String.t(),
          Keyword.t()
        ) ::
          {:ok, TransactionMIRsResponse.t()} | HTTP.error_response()
  def stake_pool_registration_and_update_certificates(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/updates", opts)
    |> Response.deserialize(TransactionStakePoolRegistrationAndUpdateCertificatesResponse)
  end

  @doc """
  Obtain information about stake pool retirements within a specific transaction.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1pool_retires/get)
  """
  @spec stake_pool_retirement_certificates(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionStakePoolRetirementCertificatesResponse.t()} | HTTP.error_response()
  def stake_pool_retirement_certificates(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/pool_retires", opts)
    |> Response.deserialize(TransactionStakePoolRetirementCertificatesResponse)
  end

  @doc """
  Obtain the transaction metadata.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1metadata/get)
  """
  @spec metadata(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionMetadataResponse.t()} | HTTP.error_response()
  def metadata(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/metadata", opts)
    |> Response.deserialize(TransactionMetadataResponse)
  end

  @doc """
  Obtain the transaction metadata in CBOR

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1metadata~1cbor/get)
  """
  @spec metadata_cbor(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionMetadataCBORResponse.t()} | HTTP.error_response()
  def metadata_cbor(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/metadata_cbor", opts)
    |> Response.deserialize(TransactionMetadataCBORResponse)
  end

  @doc """
  Obtain the transaction redeemers.


  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1redeemers/get)
  """
  @spec redeemers(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, TransactionRedeemersResponse.t()} | HTTP.error_response()
  def redeemers(name, hash, opts \\ []) do
    Utils.validate_cardano!(name)

    name
    |> HTTP.build_and_send(:get, "/txs/#{hash}/redeemers", opts)
    |> Response.deserialize(TransactionRedeemersResponse)
  end

  @doc """
  Submit an already serialized transaction to the network.

  [API Docs](https://docs.blockfrost.io/#tag/Cardano-Transactions/paths/~1txs~1{hash}~1redeemers/get)
  """
  @spec submit(Blockfrost.t(), hash :: String.t(), Keyword.t()) ::
          {:ok, SubmitTransactionResponse.t()} | HTTP.error_response()
  def submit(name, cbor, opts \\ []) do
    Utils.validate_cardano!(name)

    opts =
      opts
      |> Keyword.put(:content_type, "application/cbor")
      |> Keyword.put(:body, cbor)

    name
    |> HTTP.build_and_send(:post, "/tx/submit", opts)
    |> Response.deserialize(SubmitTransactionResponse)
  end
end
