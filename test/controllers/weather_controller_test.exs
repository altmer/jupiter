defmodule Jupiter.WeatherControllerTest do
  @moduledoc """
    Test for WeatherController
  """
  use Jupiter.ConnCase
  alias Jupiter.WeatherService
  import Mock

  defmacro with_random_weather(fn_mock, block) do
    quote do
      with_mock(WeatherService, [], [random_place: unquote(fn_mock)]) do
        unquote(block)
      end
    end
  end
  defmacro with_queried_weather(fn_mock, block) do
    quote do
      with_mock(WeatherService, [], [query: unquote(fn_mock)]) do
        unquote(block)
      end
    end
  end

  test "GET /weather/random on success", %{conn: conn} do
    weather_json = %{"name" => "Berlin"}
    with_random_weather(fn -> {:ok, weather_json} end) do
      conn = get conn, "/api/weather/random"
      assert called(WeatherService.random_place)
      assert json_response(conn, 200) == weather_json
    end
  end

  test "GET /weather/random on error", %{conn: conn} do
    reason = "City not found"
    with_random_weather(fn -> {:error, reason} end) do
      conn = get conn, "/api/weather/random"
      assert called(WeatherService.random_place)
      assert json_response(conn, 500) == %{"error" => true, "message" => reason}
    end
  end

  test "GET /weather/query on success", %{conn: conn} do
    weather_json = %{"name" => "Berlin"}
    with_queried_weather(fn(_, _) -> {:ok, weather_json} end) do
      conn = get conn, "/api/weather/query", %{city: "Berlin", country: "DE"}
      assert called(WeatherService.query("Berlin", "DE"))
      assert json_response(conn, 200) == weather_json
    end
  end

  test "GET /weather/query on error", %{conn: conn} do
    reason = "City not found"
    with_queried_weather(fn(_, _) -> {:error, reason} end) do
      conn = get conn, "/api/weather/query", %{city: "Moscov", country: "RU"}
      assert called(WeatherService.query("Moscov", "RU"))
      assert json_response(conn, 500) == %{"error" => true, "message" => reason}
    end
  end
end
