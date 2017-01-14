defmodule Jupiter.RandomCoords do
  @moduledoc """
    Returns random geographical coordinates. Intended to be used
    in WeatherService to fetch weather at random place
  """
  def fetch do
    %{lat: random_lat(), lon: random_lon()}
  end

  defp random_lat do
    :rand.uniform * 180.0 - 90.0
  end
  defp random_lon do
    :rand.uniform * 360.0 - 180.0
  end
end
