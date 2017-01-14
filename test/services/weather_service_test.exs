defmodule Jupiter.WeatherServiceTest do
  @moduledoc """
    Test for WeatherService
  """
  use ExUnit.Case, async: false

  alias Jupiter.{WeatherService, RandomCoords}

  import Mock

  defmacro with_mocked_call_by_coords(get_mock, block) do
    quote do
      with_mocks([
          {HTTPoison, [], [get: unquote(get_mock)]},
          {RandomCoords, [], [fetch: fn() -> %{lat: 10, lon: 12} end]},
          {Application, [], [fetch_env!: fn(:jupiter, Jupiter.Endpoint) -> %{openweathermap_api_key: "test_key"} end]}
        ]) do
          unquote(block)
          # check that API was called with right params
          assert called(HTTPoison.get("http://api.openweathermap.org/data/2.5/weather", [],
                        [params: [{:lat, 10}, {:lon, 12}, {"appid", "test_key"}, {"units", "metric"}]]))
      end
    end
  end

  test "random_place returns weather report on success" do
    with_mocked_call_by_coords(fn(_, _, _) -> OpenweathermapMock.get_success() end) do
      assert WeatherService.random_place == {:ok, %{
          "name" => "Shcherbinka",
          "country" => "RU",
          "lat" => 55.5,
          "lon" => 37.56,
          "temperature" => -1.25,
          "pressure" => 1010,
          "wind_speed" => 6,
          "category" => "Clouds",
          "description" => "broken clouds"
        }
      }
    end
  end

  test "random_place returns correct error when JSON has unexpected form" do
    with_mocked_call_by_coords(fn(_, _, _) -> OpenweathermapMock.get_unexpected() end) do
      assert WeatherService.random_place == {:error, "JSON parse failed"}
    end
  end
end
