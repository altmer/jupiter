defmodule Jupiter.WeatherController do
  @moduledoc """
    Controller, returning JSON with weather information
    Supports following queries:
    1. Show me weather at random coordinates
    2. Show weather in given city/country
  """
  use Jupiter.Web, :controller

  alias Jupiter.WeatherService

  def random(conn, _params) do
    conn |> weather_response(WeatherService.random_place)
  end

  def query(conn, %{"city" => city, "country" => country}) do
    conn |> weather_response(WeatherService.query(city, country))
  end

  defp weather_response(conn, resp) do
    case resp do
      {:ok, weather} ->
        conn
          |> put_status(:ok)
          |> render("weather.json", %{weather: weather})
      {:error, reason} ->
        conn
          |> put_status(:internal_server_error)
          |> render("error.json", %{error: reason})
    end
  end
end
