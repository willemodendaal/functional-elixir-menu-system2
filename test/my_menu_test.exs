defmodule MyMenuTest do
  use ExUnit.Case

  @quit_text "Thanks, see you next time :)"
  @home_choices [{"1", "Process the data"}, {"q", "Quit"}]

  test "Start returns home text and root menu" do
    %MenuState{text: home_text, choices: home_choices, state: _} = MyMenu.start()

    assert home_text == "CLI Menu v1"
    assert home_choices == @home_choices
  end

  test "It can quit" do
    %MenuState{text: _home_text, state: state} = MyMenu.start()
    %MenuState{text: quit_text, state: nil} = MyMenu.input("q", state)

    assert quit_text == @quit_text
  end

  test "It handles invalid input" do
    %MenuState{text: _home_text, state: state} = MyMenu.start()

    %MenuState{text: invalid_input_text, choices: invalid_input_choices, state: nil} =
      MyMenu.input("bananas", state)

    %MenuState{text: quit_text, state: nil} = MyMenu.input("q", state)

    assert invalid_input_text ==
             "\nSorry, I don't recognize that option. Choose from these please:"

    assert invalid_input_choices == @home_choices

    assert(quit_text == @quit_text)
  end

  test "It loads the 'process data' menu" do
    raise "todo test"
  end
end
