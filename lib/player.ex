defmodule ExMon.Player do
  @requires_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @requires_keys
  defstruct @requires_keys

  def build(name, move_rdn, move_avg, move_heal ) do
      %ExMon.Player{
        life: @max_life,
        moves: %{
          move_avg: move_avg,
          move_heal: move_heal,
          move_rdn: move_rdn,
        },
        name: name
      }
  end
end
