defmodule Steps.StartStep do
  def create(state) do
    MenuState.new(:start, "CLI Menu v1", start_menu_choices(), state)
  end

  defp start_menu_choices() do
    [{"1", "Process the data"}, {"q", "Quit"}]
  end
end
