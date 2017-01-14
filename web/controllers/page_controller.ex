defmodule Jupiter.PageController do
  use Jupiter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
