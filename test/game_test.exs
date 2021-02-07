defmodule ExMon.GameTest do
    use ExUnit.Case

    alias ExMon. {Game, Player}


    describe "start/2" do
      test "starts the game state" do
        player = Player.build("Godzilla", :raio_plasma, :raio_atomico, :radiacao)
        computer = Player.build("King Kong", :soco, :machadada, :banana)

        assert {:ok, _pid} = Game.start(computer, player)
     end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Godzilla", :raio_plasma, :raio_atomico, :radiacao)
      computer = Player.build("King Kong", :soco, :machadada, :banana)

      Game.start(computer, player)

      expected_response =  %{
        computer: %Player{
          life: 100, moves: %{move_avg: :machadada, move_heal: :banana, move_rnd: :soco},
          name: "King Kong"
        },
        player: % Player{
         life: 100,
         moves: %{move_avg: :raio_atomico, move_heal: :radiacao, move_rnd: :raio_plasma},
        name: "Godzilla"},
        status: :started,
        turn: :player
        }
      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
      test "returns the game state updated" do

      player = Player.build("Godzilla", :raio_plasma, :raio_atomico, :radiacao)
      computer = Player.build("King Kong", :soco, :machadada, :banana)

      Game.start(computer, player)

      expected_response =  %{
        computer: %Player{
          life: 100, moves: %{move_avg: :machadada, move_heal: :banana, move_rnd: :soco},
          name: "King Kong"
        },
        player: % Player{
         life: 100,
         moves: %{move_avg: :raio_atomico, move_heal: :radiacao, move_rnd: :raio_plasma},
         name: "Godzilla"
        },
        status: :started,
        turn: :player
        }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :machadada, move_heal: :banana, move_rnd: :soco},
          name: "King Kong"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :raio_atomico, move_heal: :radiacao, move_rnd: :raio_plasma},
          name: "Godzilla"
        },
        status: :started,
        turn: :player
        }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "game_over/1" do
    test "returns the game state finalize" do

      player = Player.build("Godzilla", :raio_plasma, :raio_atomico, :radiacao)
      computer = Player.build("King Kong", :soco, :machadada, :banana)

      Game.start(computer, player)

      expected_response =  %{
        computer: %Player{
          life: 100, moves: %{move_avg: :machadada, move_heal: :banana, move_rnd: :soco},
          name: "King Kong"
        },
        player: %Player{
        life: 100,
        moves: %{move_avg: :raio_atomico, move_heal: :radiacao, move_rnd: :raio_plasma},
        name: "Godzilla"
        },
        status: :started,
        turn: :player
        }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 0,
          moves: %{move_avg: :machadada, move_heal: :banana, move_rnd: :soco},
          name: "King Kong"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :raio_atomico, move_heal: :radiacao, move_rnd: :raio_plasma},
          name: "Godzilla"
        },
        status: :game_over,
        turn: :player
        }

      Game.update(new_state)

      expected_response = %{new_state | turn: :player, status: :game_over}

      assert expected_response == Game.info()
    end
  end
end
