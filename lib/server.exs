defmodule GroupMessage.Server do
  use GenServer

  def start(), do: start(%{})
  def start(opts) do
    GenServer.start_link(GroupMessage.Server, { %{}, MapSet.new }, opts)
  end

  def init(args) do
    IO.puts(args)
    {:ok, args}
  end

  # Do not allow atoms for names or else that could cause memory to build up.
  def register(server, name) when is_bitstring(name) do
    GenServer.call(server, {:register, self(), name})
  end


  # Location can be a pid or any sort of identifier
  def handle_call({:register, location, name}, { lookup, inverse_lookup }) do
    cond do
      Map.has_key?(lookup, name) -> {:reply, :taken, { lookup, inverse_lookup }}
      Map.has_key?(inverse_lookup, location) -> {:reply, :location_used, { lookup, inverse_lookup }}
      true -> {:reply, :ok, { Map.put(lookup, name, location), Map.put(inverse_lookup, location, name) }}
    end
  end

  # Y'all can only send string messages
  def send_message(server, to, msg) when is_bitstring(msg) do
    GenServer.call(server, {:send_message, %{to: to, msg: msg, from: self() }})
  end

  def handle_call({:send_message, %{to: to, msg: msg, from: from }}, { lookup, inverse_lookup }) do
    cond do
      Map.has_key(lookup, to) -> (
        # we have the name
        location = lookup[to]

        )
      Map.has_key?(inverse_lookup, to) -> (
        # we have the location

        name = inverse_lookup[to]

        )
      true -> {:reply, :not_found, { lookup, inverse_lookup }}
    end
  end
end
