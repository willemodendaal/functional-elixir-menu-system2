defmodule MyMenuTest do
  use ExUnit.Case

  @home_text "CLI Menu v1"
  @home_choices [{"1", "Process the data"}, {"q", "Quit"}]

  @process_handler_text "Process data. Would you like to do so now, or later?"
  @process_handler_choices [
    {"1", "Process now"},
    {"2", "Process a custom value"},
    {"3", "Cancel"}
  ]

  @quit_text "Thanks, see you next time :)"

  @process_now_text "Processed OK(111).\n\n" <> @home_text

  @cancelled_process_text "Fine. Taking you back to the start.\n\n" <> @home_text

  test "Start returns home text and root menu" do
    menu_state = MyMenu.start()

    assert menu_state.text == @home_text
    assert menu_state.choices == @home_choices
  end

  test "It can quit" do
    menu_state = MyMenu.start()
    menu_state = MyMenu.input(menu_state, "q")

    assert menu_state.text == @quit_text

    # No handling of messages after quitting.
    menu_state = MyMenu.input(menu_state, "123")
    assert menu_state.text == "I've got nothing more to say to you."
  end

  test "It handles invalid input" do
    menu_state = MyMenu.start()

    %MenuState{text: invalid_input_text, choices: invalid_input_choices} =
      menu_state = MyMenu.input(menu_state, "bananas")

    %MenuState{text: quit_text} = MyMenu.input(menu_state, "q")

    assert invalid_input_text ==
             "Sorry, I don't recognize that option. Choose from these please:"

    assert invalid_input_choices == @home_choices

    assert quit_text == @quit_text
  end

  test "It loads the 'process data' menu" do
    menu_state = MyMenu.start()

    %MenuState{text: process_handler_text, choices: process_handler_choices} =
      MyMenu.input(menu_state, "1")

    assert process_handler_text == @process_handler_text
    assert process_handler_choices == @process_handler_choices
  end

  test "It loads the 'process data' menu and processes 'now'" do
    process_data_menu_state = start_and_launch_process_menu()
    process_now_menu_state = MyMenu.input(process_data_menu_state, "1")

    assert process_now_menu_state.text == @process_now_text
    assert process_now_menu_state.choices == @home_choices
  end

  test "It allows cancelling of the 'process' menu." do
    cancelled_process_menu_state =
      start_and_launch_process_menu()
      |> MyMenu.input("3")

    assert cancelled_process_menu_state.text == @cancelled_process_text
    assert cancelled_process_menu_state.choices == @home_choices
  end

  test "It allows number entry on 2nd 'process data' option." do
    process_data_menu_state = start_and_launch_process_menu()

    custom_data_menu_state = MyMenu.input(process_data_menu_state, "2")
  end

  defp start_and_launch_process_menu() do
    process_data_menu_state =
      MyMenu.start()
      |> MyMenu.input("1")

    assert process_data_menu_state.text == @process_handler_text
    assert process_data_menu_state.choices == @process_handler_choices

    process_data_menu_state
  end
end
