defmodule Steps.StartStep do
  def create() do
    MenuState.new(:start, "CLI Menu v1", start_menu_choices(), __MODULE__)
  end

  @spec handle_input(String.t(), %MenuState{}) :: %MenuState{}
  def handle_input(input, state = %MenuState{}) do
    case input do
      "q" ->
        MenuState.quit("Thanks, see you next time :)")

      "1" ->
        MenuState.new(
          :process_data,
          "Process data. Would you like to do so now, or later?",
          [{"1", "Process now"}, {"2", "Process later"}, {"3", "Cancel"}],
          Steps.ProcessDataStep
        )

      _str ->
        MenuState.reprompt_on_invalid_input(
          "Sorry, I don't recognize that option. Choose from these please:",
          state
        )
    end
  end

  defp start_menu_choices() do
    [{"1", "Process the data"}, {"q", "Quit"}]
  end
end
