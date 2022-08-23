defmodule MyMenu do
  def start() do
    "CLI Menu v1\n" <> start_menu()
  end

  defp start_menu() do
    """
    1. Process the data.
    q. Quit
    """
  end
end
