defmodule Steps.StartStep do
  @spec create() :: %MenuState{}
  def create() do
    create(nil)
  end

  @spec create(any) :: %MenuState{}
  def create(prefix_text) do
    MenuState.new(:start, "#{prefix_text}CLI Menu v1", start_menu_choices(), &handle_input/2)
  end

  @spec handle_input(String.t(), %MenuState{}) :: {:handled, %MenuState{}} | {:unhandled}
  def handle_input(input, state = %MenuState{}) do
    case handle(input, state) do
      nil -> {:unhandled}
      state -> {:handled, state}
    end
  end

  @spec handle(String.t(), %MenuState{}) :: %MenuState{} | nil
  defp handle(input, _state = %MenuState{}) do
    case input do
      "q" ->
        MenuState.quit("Thanks, see you next time :)")

      "1" ->
        Steps.ProcessDataStep.create()

      _str ->
        nil
    end
  end

  defp start_menu_choices() do
    [{"1", "Process the data"}, {"q", "Quit"}]
  end
end
