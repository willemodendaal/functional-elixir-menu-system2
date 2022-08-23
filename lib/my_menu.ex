defmodule MyMenu do
  def start() do
    MenuState.new("CLI Menu v1\n" <> start_menu_text(), nil)
  end

  # User input.
  def input(str, _state) do
    case str do
      "q" ->
        MenuState.new("Thanks, see you next time :)", nil)

      str ->
        raise "Menu does not know how to handle '#{str}'"
    end
  end

  defp start_menu_text() do
    """
    1. Process the data.
    q. Quit
    """
  end
end
