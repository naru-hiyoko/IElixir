defmodule IElixir.Dummy do
  @moduledoc """
  """

  use GenServer
  require Logger

  @doc false
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: Dummy)
  end

  def init(opts) do
    {:ok, opts}
  end
end
