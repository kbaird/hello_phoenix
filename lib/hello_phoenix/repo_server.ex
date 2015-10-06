defmodule HelloPhoenix.RepoServer do
  use GenServer

  def handle_call(:delete!, _from, [module, id | tail]) do
    {:reply, delete_item(module, id), tail}
  end

  def handle_cast(:delete!, [module, id]) do
    {:noreply, delete_item(module, id)}
  end

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  ### NOT IMPLEMENTED YET

  def code_change(_old_vsn, _state, _extra), do: {:error, :not_implemented}

  def handle_info(_msg, state), do: {:noreply, state}

  def terminate(_reason, _state), do: :ok

  ### PRIVATE FUNCTIONS

  defp delete_item(module, id) do
    item = HelloPhoenix.Repo.get!(module, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    HelloPhoenix.Repo.delete!(item)
    :deleted
  end
end
