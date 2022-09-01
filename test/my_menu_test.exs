defmodule MyMenuTest do
  use ExUnit.Case

  # Expected text and choices to test against
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
    MyMenu.start()
    |> assert_menu_prompt(@home_text)
    |> assert_menu_choices(@home_choices)
  end

  test "It can quit" do
    MyMenu.start()
    |> MyMenu.input("q")
    |> assert_menu_prompt(@quit_text)
    |> MyMenu.input("this should not be handled")
    |> assert_menu_prompt("I've got nothing more to say to you.")
  end

  test "It handles invalid input" do
    MyMenu.start()
    |> MyMenu.input("bananas")
    |> assert_menu_prompt("Sorry, I don't recognize that option. Choose from these please:")
    |> MyMenu.input("q")
    |> assert_menu_prompt(@quit_text)
  end

  test "It loads the 'process data' menu" do
    MyMenu.start()
    |> MyMenu.input("1")
    |> assert_menu_prompt(@process_handler_text)
    |> assert_menu_choices(@process_handler_choices)
  end

  test "It loads the 'process data' menu and processes 'now'" do
    start_and_launch_process_menu()
    |> MyMenu.input("1")
    |> assert_menu_prompt(expected_process_now_text(111, @home_text))
    |> assert_menu_choices(@home_choices)
  end

  test "It allows cancelling of the 'process' menu." do
    start_and_launch_process_menu()
    |> MyMenu.input("3")
    |> assert_menu_prompt(@cancelled_process_text)
    |> assert_menu_choices(@home_choices)
  end

  test "It allows arbitrary data entry on 2nd 'process data' option." do
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
    MyMenu.start()
    |> MyMenu.input("1")
    |> assert_menu_prompt(@process_handler_text)
    |> assert_menu_choices(@process_handler_choices)
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
