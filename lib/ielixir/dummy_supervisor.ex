defmodule IElixir.DummySupervisor do
  @moduledoc """
  """

  alias IElixir
  use Supervisor
  require Logger

  @doc false
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: DummySupervisor)
  end

  @doc false
  def init(_opts) do
    children = [
      worker(IElixir.Dummy, [[]]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
