defmodule MyMenuTest do
  use ExUnit.Case

  test "Start returns home text and root menu" do
    home_text =
      MyMenu.start()
      |> IO.inspect(label: "Home text")

    assert home_text == "CLI Menu v1\n1. Process the data.\nq. Quit\n"
  end
end
