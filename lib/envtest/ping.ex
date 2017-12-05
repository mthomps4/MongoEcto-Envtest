defmodule Envtest.Ping do
  @moduledoc """
  Insert the database envtest_dev /envtest_prod into Mongo 
  Add a collection `pongs` 
  Create a document with count: ## 
  Run and Query 
  """
  use Ecto.Schema
  @primary_key {:_id, :binary_id, autogenerate: true}
  schema "pongs" do
    field :count, :integer
  end
end

