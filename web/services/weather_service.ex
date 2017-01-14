defmodule Jupiter.WeatherService do
  @moduledoc """
    Provides functions for getting weather info from openweathermap
  """
  alias Jupiter.RandomCoords

  def random_place do
    RandomCoords.fetch
      |> service_params()
      |> fetch_weather_info()
  end

  defp fetch_weather_info(params) do
    case HTTPoison.get(service_url(), [], [{:params, params}]) do
      {:ok, %HTTPoison.Response{body: body}} ->
        prepare_response(body)
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp prepare_response(body) do
    case Poison.decode(body) do
      {:ok, res} ->
        if res["cod"] == 200 do
          try do
            {:ok, parse(res)}
          rescue
            _ in MatchError ->
              {:error, "JSON parse failed"}
          end
        else
          {:error, res["message"]}
        end
      _ ->
        {:error, "JSON is malformed"}
    end
  end

  defp service_url do
    "http://api.openweathermap.org/data/2.5/weather"
  end

  defp service_params(query_params) do
    query_params
      |> Map.put("appid", api_key())
      |> Map.put("units", "metric")
      |> Map.to_list
  end

  defp api_key do
    Application.fetch_env!(
      :jupiter, Jupiter.Endpoint
    )[:openweathermap_api_key]
  end

  defp parse(json) do
    # transform map to my format
    %{
      "coord" => %{
        "lat" => lat,
        "lon" => lon
      },
      "name" => name,
      "main" => %{
        "temp" => temperature,
        "pressure" => pressure,
      },
      "wind" => %{
        "speed" => wind_speed
      },
      "weather" => [
        %{
          "main" => category,
          "description" => description
        } | _
      ]
    } = json
    %{
      "name" => name,
      "lat" => lat,
      "lon" => lon,
      "temperature" => temperature,
      "pressure" => pressure,
      "wind_speed" => wind_speed,
      "category" => category,
      "description" => description
    }
  end
end
