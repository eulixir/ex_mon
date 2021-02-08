defmodule ExMonWeb.WelcomeController do
  use ExMonWeb, :controller

  def index(conn, __params) do
    text(conn, "Welcome to the ExMon API!")
  end
end
