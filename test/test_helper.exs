# Setting mocks
Application.put_env(:blockfrost, :__http_client__, Blockfrost.HTTPClientMock)

ExUnit.start()
