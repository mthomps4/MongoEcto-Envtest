defmodule Envtest.Web.PageController do
  use Envtest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
