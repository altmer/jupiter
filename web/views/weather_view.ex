defmodule Jupiter.WeatherView do
  @moduledoc """
    views for WeatherController
  """

  def render("weather.json", %{weather: weather}) do
    weather
  end

  def render("error.json", %{error: error}) do
    %{error: true, message: error}
  end
end
