defmodule OpenweathermapMock do
  @moduledoc """
    Mock for openweathermap API
  """
  def get_malformed_json do
    {
      :ok,
      response("nope, this is not json, just plain text")
    }
  end
  def get_server_error do
    {
      :error,
      error("Connection refused")
    }
  end
  def get_api_error do
    {
      :ok,
      response(
      """
      {
        "cod": 503,
        "message" : "City not found"
      }
      """
      )
    }
  end
  def get_unexpected() do
    {
      :ok,
      response(
      """
      {
        "cod": 200,
        "some_custom_tag": "some_custom_value"
      }
      """
      )
    }
  end
  def get_success() do
    # IO.puts params
    {
      :ok,
      response(
      """
      {
        "coord": {
            "lon": 37.56,
            "lat": 55.5
         },
         "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04n"
          },
          {
            "id": 804,
            "main": "Sun",
            "description": "no desc",
            "icon": "04n"
          }
        ],
        "base": "stations",
        "main": {
          "temp": -1.25,
          "pressure": 1010,
          "humidity": 80,
          "temp_min": -2,
          "temp_max": -1
        },
        "visibility": 10000,
        "wind": {
          "speed": 6,
          "deg": 160
        },
        "clouds": {
          "all": 75
        },
        "dt": 1484409600,
        "sys": {
          "type": 1,
          "id": 7325,
          "message": 0.0163,
          "country": "RU",
          "sunrise": 1484372904,
          "sunset": 1484400616
        },
        "id": 495260,
        "name": "Shcherbinka",
        "cod": 200
        }
      """
      )
    }
  end

  defp response(body) do
    %HTTPoison.Response{
      body: body,
      headers: [{"Server", "nginx"}, {"Content-Type", "application/json"}],
      status_code: 200
    }
  end

  defp error(reason) do
    %HTTPoison.Error{
      reason: reason
    }
  end
end
