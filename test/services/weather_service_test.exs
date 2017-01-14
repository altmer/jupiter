defmodule Jupiter.WeatherServiceTest do
  @moduledoc """
    Test for WeatherService
  """
  use ExUnit.Case, async: false

  alias Jupiter.{WeatherService, RandomCoords}

  import Mock

  def expected_response do
    %{
      "name" => "Shcherbinka",
      "lat" => 55.5,
      "lon" => 37.56,
      "temperature" => -1.25,
      "pressure" => 1010,
      "wind_speed" => 6,
      "category" => "Clouds",
      "description" => "broken clouds"
    }
  end

  defmacro with_mocked_api_coords(get_mock, block) do
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

  defmacro with_mocked_api_query(get_mock, block) do
    quote do
      with_mocks([
          {HTTPoison, [], [get: unquote(get_mock)]},
          {Application, [], [fetch_env!: fn(:jupiter, Jupiter.Endpoint) -> %{openweathermap_api_key: "test_key"} end]}
        ]) do
          unquote(block)
          # check that API was called with right params
          assert called(HTTPoison.get("http://api.openweathermap.org/data/2.5/weather", [],
                        [params: [{"appid", "test_key"}, {"q", "Berlin,DE"}, {"units", "metric"}]]))
      end
    end
  end

  test "random_place returns weather report on success" do
    with_mocked_api_coords(fn(_, _, _) -> OpenweathermapMock.get_success() end) do
      assert WeatherService.random_place == {:ok, expected_response()}
    end
  end

  test "random_place returns correct error when JSON has unexpected form" do
    with_mocked_api_coords(fn(_, _, _) -> OpenweathermapMock.get_unexpected() end) do
      assert WeatherService.random_place == {:error, "JSON parse failed"}
    end
  end

  test "random_place returns API error when API returned error code" do
    with_mocked_api_coords(fn(_, _, _) -> OpenweathermapMock.get_api_error() end) do
      assert WeatherService.random_place == {:error, "City not found"}
    end
  end

  test "random_place returns server error reason when API does not answer" do
    with_mocked_api_coords(fn(_, _, _) -> OpenweathermapMock.get_server_error() end) do
      assert WeatherService.random_place == {:error, "Connection refused"}
    end
  end

  test "random_place returns parse error when JSON is malformed" do
    with_mocked_api_coords(fn(_, _, _) -> OpenweathermapMock.get_malformed_json() end) do
      assert WeatherService.random_place == {:error, "JSON is malformed"}
    end
  end

  test "query returns weather report on success" do
    with_mocked_api_query(fn(_, _, _) -> OpenweathermapMock.get_success() end) do
      assert WeatherService.query("Berlin", "DE") == {:ok, expected_response()}
    end
  end

  # error handling already tested before
end
