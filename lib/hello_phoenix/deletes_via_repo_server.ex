defmodule HelloPhoenix.DeletesViaRepoServer do
  defmacro __using__(_) do
    quote do
      defp delete_via_repo_server(module, id) do
        {:ok, pid} = GenServer.start_link(HelloPhoenix.RepoServer, [module, id])
        GenServer.call(pid, :delete!)
      end
    end
  end
end
