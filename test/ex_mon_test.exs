defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

    describe "create_player/4"do
      test "returns a player" do
        expected_response = %Player{
          life: 100,
          moves: %{move_avg: :raio_plasma, move_heal: :radiacao, move_rnd: :raio_atomico},
          name: "Godzilla"
        }

        assert expected_response == ExMon.create_player("Godzilla", :raio_atomico, :raio_plasma, :radiacao)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Godzilla", :raio_plasma, :raio_atomico, :radiacao)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) === :ok
        end)

      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do

      player = Player.build("Godzilla", :raio_plasma, :raio_atomico, :radiacao)
      capture_io(fn ->
          ExMon.start_game(player)
        end)

        :ok
      end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:raio_plasma)
        end)

      assert messages =~ "Player attacked the computer"
      assert messages =~ "computer's turn"
      assert messages =~ "player's turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:wrong)
        end)

      assert messages =~ "You don't know the move wrong!"
    end
  end
end
