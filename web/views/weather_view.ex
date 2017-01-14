defmodule Jupiter.WeatherView do
  @moduledoc """
    views for WeatherController
  """

  def render("weather.json", %{weather: weather}) do
    weather
  end
end
