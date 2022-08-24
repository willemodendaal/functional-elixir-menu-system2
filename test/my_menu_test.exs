defmodule MyMenuTest do
  use ExUnit.Case

  @quit_text "Thanks, see you next time :)"
  @home_choices [{"1", "Process the data"}, {"q", "Quit"}]

  @process_data_text "Process data. Would you like to do so now, or later?"
  @process_data_choices [{"1", "Process now"}, {"2", "Process later"}, {"3", "Cancel"}]

  test "Start returns home text and root menu" do
    %MenuState{text: home_text, choices: home_choices, data: _} = MyMenu.start()

    assert home_text == "CLI Menu v1"
    assert home_choices == @home_choices
  end

  test "It can quit" do
    %MenuState{text: _home_text, data: _data} = menu_state = MyMenu.start()
    %MenuState{text: quit_text, data: nil} = MyMenu.input("q", menu_state)

    assert quit_text == @quit_text
  end

  test "It handles invalid input" do
    %MenuState{text: _home_text, data: _data} = menu_state = MyMenu.start()

    %MenuState{text: invalid_input_text, choices: invalid_input_choices, data: nil} =
      menu_state = MyMenu.input("bananas", menu_state)

    %MenuState{text: quit_text, data: nil} = MyMenu.input("q", menu_state)

    assert invalid_input_text ==
             "Sorry, I don't recognize that option. Choose from these please:"

    assert invalid_input_choices == @home_choices

    assert quit_text == @quit_text
  end

  test "It loads the 'process data' menu" do
    %MenuState{text: _home_text, data: _data} = menu_state = MyMenu.start()

    %MenuState{text: process_data_text, choices: choices, data: nil} =
      MyMenu.input("1", menu_state)

    assert process_data_text == @process_data_text
    assert choices == @process_data_choices
  end
end
