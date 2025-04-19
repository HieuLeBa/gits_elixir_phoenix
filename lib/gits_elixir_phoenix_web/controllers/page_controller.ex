defmodule GitsElixirPhoenixWeb.PageController do
  use GitsElixirPhoenixWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/create")
  end
end
