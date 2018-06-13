defmodule GroupMessage.Person do
  use Agent # we need to store nods that the person can possibly ping

  def start_link(_opts) do
    Agent.start_link(fn -> %{people: [], groups: []} end)
  end

  def join_group(agent, group) do
    Agent.get_and_update(agent, fn state -> 
      ({state.groups, Map.update(state, :groups, [], fn groups -> (
          [group | groups]
        ) end)}
      ) end)
  end

  def list_groups(agent) do
    Agent.get(agent, fn state -> state.groups end)
  end

  def message_person(agent, someone, msg) do
    people = Agent.get(agent, fn state -> state.people end)
    cond do
      someone in people -> (
        send(someone, msg)
        )
      Node.ping(someone) == :pong -> (
        send(someone, msg)
        Agent.update(agent, fn state -> Map.update(state, :people, [], fn people -> [someone | people] end) end)
        )
      true -> false
    end
  end
end