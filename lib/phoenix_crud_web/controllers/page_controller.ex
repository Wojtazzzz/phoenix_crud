defmodule PhoenixCrudWeb.PageController do
  use PhoenixCrudWeb, :controller

  def home(conn, _params) do
    render(conn, :test, layout: false)
  end
end
