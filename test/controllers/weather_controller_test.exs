defmodule Jupiter.WeatherControllerTest do
  @moduledoc """
    Test for WeatherController
  """
  use Jupiter.ConnCase
  alias Jupiter.WeatherService
  import Mock

  defmacro with_mocked_weather_service_random(get_mock, block) do
    quote do
      with_mocks([
          {WeatherService, [], [random_place: unquote(get_mock)]},
        ]) do
          unquote(block)
          # check that API was called with right params
          assert called(WeatherService.random_place)
      end
    end
  end

  test "GET /weather/random on success", %{conn: conn} do
    weather_json = %{"name" => "Berlin"}
    with_mocked_weather_service_random(fn -> {:ok, weather_json} end) do
      conn = get conn, "/api/weather/random"
      assert json_response(conn, 200) == weather_json
    end
  end

  test "GET /weather/random on error", %{conn: conn} do
    reason = "City not found"
    with_mocked_weather_service_random(fn -> {:error, reason} end) do
      conn = get conn, "/api/weather/random"
      assert json_response(conn, 500) == %{"error" => true, "message" => reason}
    end
  end
end
