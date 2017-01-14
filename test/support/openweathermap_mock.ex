defmodule OpenweathermapMock do
  @moduledoc """
    Mock for openweathermap API
  """
  def get_success() do
    # IO.puts params
    {
      :ok,
      %HTTPoison.Response{
        body: """
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
        """,
        headers: [{"Server", "nginx"}, {"Content-Type", "application/json"}],
        status_code: 200
      }
    }
  end
end
