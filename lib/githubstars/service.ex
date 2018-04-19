defmodule Githubstars.Service do
  @moduledoc """
  Service behaviour
  """

  @callback run(map) ::
              {:ok, struct | map | list}
              | {:error, any()}

  defmacro __using__(_) do
    quote do
      @behaviour Githubstars.Service
      import Githubstars.Repo, only: [transaction: 1, rollback: 1]

      def call(params) do
        transaction(fn ->
          with {:ok, response} <- run(params) do
            response
          else
            {:error, reason} -> rollback(reason)
          end
        end)
      end
    end
  end
end
