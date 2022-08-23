defmodule MyMenuTest do
  use ExUnit.Case

  test "Start returns home text and root menu" do
    %{prompt: home_text, state: _} = MyMenu.start()

    assert home_text == "CLI Menu v1\n1. Process the data.\nq. Quit\n"
  end

  test "It can quit" do
    %{prompt: _home_text, state: state} = MyMenu.start()
    %{prompt: quit_text, state: nil} = MyMenu.input("q", state)

    assert quit_text == "Thanks, see you next time :)"
  end
end
