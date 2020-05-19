defmodule IElixir do
  @moduledoc """
  This is documentation for IElixir project.
  """

  use Application
  require Logger
  alias IElixir.Utils

  @doc false
  def start(_type, _args) do
    use_ielixir? =
      case Application.get_env(:ielixir, :use_ielixir) do
        true -> true
        _    -> System.get_env("USE_IELIXIR") == "true"
      end

    if use_ielixir? do
      conn_info =
        case Application.get_env(:ielixir, :connection_file) do
          nil             -> System.get_env("CONNECTION_FILE")
          connection_file -> connection_file
        end
        |> Utils.parse_connection_file()

      {:ok, ctx} = :erlzmq.context()
      ielixir_path  = File.cwd!()
      File.cd!(System.get_env("WORKING_DIRECTORY", File.cwd!()))
      IElixir.Supervisor.start_link(conn_info: conn_info, ctx: ctx, starting_path: ielixir_path)
    else
      IElixir.DummySupervisor.start_link([])
    end
  end
end
