defmodule MyMenuTest do
  use ExUnit.Case

  @home_text "CLI Menu v1"
  @home_choices [{"1", "Process the data"}, {"q", "Quit"}]

  @process_handler_text "Process data. Would you like to process the default value, or a custom value?"
  @process_handler_choices [
    {"1", "Process now"},
    {"2", "Process a custom value"},
    {"3", "Cancel"}
  ]

  @quit_text "Thanks, see you next time :)"

  @cancelled_process_text "Fine. Taking you back to the start.\n\n" <> @home_text

  @custom_data_prompt_text "Please type the custom data that you would like to process:"

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

    assert process_now_menu_state.text == expected_process_now_text(111, @home_text)
    assert process_now_menu_state.choices == @home_choices
  end

  test "It allows cancelling of the 'process' menu." do
    cancelled_process_menu_state =
      start_and_launch_process_menu()
      |> MyMenu.input("3")

    assert cancelled_process_menu_state.text == @cancelled_process_text
    assert cancelled_process_menu_state.choices == @home_choices
  end

  test "It allows arbitrary data entry on 2nd 'process data' option." do
    custom_data_menu_state =
      start_and_launch_process_menu()
      |> MyMenu.input("2")
      |> assert_menu_prompt(@custom_data_prompt_text)
      |> MyMenu.input("some custom user-entered data")
      |> assert_menu_prompt(
        expected_process_now_text("some custom user-entered data", @process_handler_text)
      )
      |> MyMenu.input("3")
      |> assert_menu_prompt(@cancelled_process_text)
      |> assert_menu_choices(@home_choices)
  end

  defp start_and_launch_process_menu() do
    process_data_menu_state =
      MyMenu.start()
      |> MyMenu.input("1")

    assert process_data_menu_state.text == @process_handler_text
    assert process_data_menu_state.choices == @process_handler_choices

    process_data_menu_state
  end

  defp assert_menu_prompt(state = %MenuState{}, expected_prompt) do
    assert state.text == expected_prompt

    state
  end

  defp assert_menu_choices(state = %MenuState{}, expected_choices) do
    assert state.choices == expected_choices

    state
  end

  defp expected_process_now_text(data, suffix_text) do
    "Processed OK(#{data}).\n\n" <> suffix_text
  end
end
