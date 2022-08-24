defmodule Steps.ProcessDataStep do
  def create(state) do
    # todo: we want to split imperative and functional logic.
    # can we do this better?
    result = do_process_now_logic()

    MenuState.new(
      :process_now,
      "Processed OK. Result: #{result}",
      [{"1", "Process now"}, {"2", "Process later"}, {"3", "Cancel"}],
      state.data
    )
  end

  defp do_process_now_logic() do
    111
  end
end
