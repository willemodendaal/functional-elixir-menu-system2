defmodule MyMenu do
  @moduledoc """
  The goal with this module is to keep it purely functional.
  But with state-machine-like logic (except the state always gets passed in and out)
  """

  def start() do
    MenuState.new("CLI Menu v1", start_menu_choices(), nil)
  end

  # User input.
  def input(str, state = %MenuState{}) do
    case str do
      "q" ->
        MenuState.quit("Thanks, see you next time :)")

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
