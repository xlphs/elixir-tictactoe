defmodule Tictactoe do
	# Just HTTP server boilerplate

	use Application
	require Logger

	use Plug.Router
	plug :match
	plug :dispatch

	def start(_type, _args) do
		Logger.info "Listening at port " <> to_string Application.get_env(:tictactoe, :http_port)
		Plug.Adapters.Cowboy.http(
			Tictactoe, [], port: Application.get_env(:tictactoe, :http_port))
	end

	match "/" do
		conn
		|> send_file(200, "public/index.html")
	end

	match "/js/:file" do
		Logger.info file
		conn
		|> send_file(200, "public/js/" <> file)
	end

	match "/assets/:file" do
		Logger.info file
		conn
		|> send_file(200, "public/assets/" <> file)
	end

	match "/api/get_game" do
		conn
		|> send_resp(200, Poison.encode!(Game.initial_state))
		|> halt
	end

	match "/api/update_game" do
		case Plug.Conn.read_body conn do
			{:ok, body, conn} ->
				state = Game.find_winner Poison.decode!(body)
				conn
				|> send_resp(200, Poison.encode!(state))
				|> halt
			_ ->
				conn
				|> send_resp(400, "bad request")
				|> halt
		end
	end

	match _ do
		conn
		|> send_resp(404, "not found")
		|> halt
	end
end
