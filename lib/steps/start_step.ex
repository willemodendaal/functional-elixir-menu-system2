defmodule Steps.StartStep do
  @spec create() :: %MenuState{}
  def create() do
    create(nil)
  end

  @spec create(any) :: %MenuState{}
  def create(prefix_text) do
    MenuState.new(:start, "#{prefix_text}CLI Menu v1", start_menu_choices(), __MODULE__)
  end

  @spec handle_input(String.t(), %MenuState{}) :: %MenuState{}
  def handle_input(input, state = %MenuState{}) do
    case input do
      "q" ->
        MenuState.quit("Thanks, see you next time :)")

      "1" ->
        Steps.ProcessDataStep.create()

      _str ->
        # todo - Can we make this reusable somehow?
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
