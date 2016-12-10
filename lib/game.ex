defmodule Game do
	@doc """
	Returns the initial state of the game.
	0 means empty slot.
	Each player is represented by a non-zero number, e.g. player 1 is 1,
	player 2 is 2, and so on.
	"""
	def initial_state do
		[0, 0, 0, 0, 0, 0, 0, 0, 0]
	end

	@doc """
	Returns [winner] from game state, a player is represented by
	a non-zero number, so 0 means no winner.
	"""
	def find_winner(state) do
		case search(state) do
			{:ok, player} ->
				[player]
			_ ->
				[0]
		end
	end

	@doc ~S"""
	Returns {:ok, player_number} or {:error}

    iex> Game.search([1,2,2, 2,2,0, 1,1,1])
    {:ok, 1}
    iex> Game.search([1,2,2, 2,2,0, 1,1,0])
    {:error}

	"""
	def search([n1,n2,n3, _,_,_, _,_,_])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([_,_,_, n1,n2,n3, _,_,_])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([_,_,_, _,_,_, n1,n2,n3])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([n1,_,_, n2,_,_, n3,_,_])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([_,n1,_, _,n2,_, _,n3,_])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([_,_,n1, _,_,n2, _,_,n3])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([n1,_,_, _,n2,_, _,_,n3])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search([_,_,n1, _,n2,_, n3,_,_])
	when (n1 > 0 and n1 == n2 and n2 == n3)
	do
		{:ok, n1}
	end
	def search(_) do
		{:error}
	end
end
