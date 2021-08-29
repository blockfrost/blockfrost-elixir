defmodule Blockfrost.IPFS.Add do
  alias Blockfrost.HTTP
  alias Blockfrost.Response
  alias Blockfrost.Response.AddFileResponse

  @doc """
  Adds a file to IPFS

  Supports both a file path or a stream

  Remember that you need to pin an object to avoid it being garbage collected. 
  For more information about pinning, see `Blockfrost.IPFS.Pins`

  This usage is being counted in your user account quota.
  """
  @spec add_file(atom(), path_or_stream :: String.t() | Stream.t(), Keyword.t()) ::
          {:ok, IPFSAddFileResponse.t()}
  def add_file(name, file_stream, opts \\ [])

  def add_file(name, file_path, opts) when is_binary(file_path) do
    file_stream = File.stream!(file_path)

    opts = Keyword.put_new(opts, :filename, Path.basename(file_path))

    add_file(name, file_stream, opts)
  end

  def add_file(name, file_stream, opts) do
    part_headers =
      if filename = opts[:filename] do
        [{"Content-Disposition", "form-data; name=file; filename=#{inspect(filename)}"}]
      else
        [{"Content-Disposition", "form-data; name=file"}]
      end

    multipart =
      Multipart.new()
      |> Multipart.add_part(Multipart.Part.stream_body(file_stream, part_headers))

    opts =
      opts
      |> Keyword.put(:body, {:stream, Multipart.body_stream(multipart)})
      |> Keyword.put(:content_type, Multipart.content_type(multipart, "multipart/form-data"))

    name
    |> HTTP.build_and_send(:post, "/ipfs/add", %{}, %{}, opts)
    |> Response.deserialize(AddFileResponse)
  end
end
