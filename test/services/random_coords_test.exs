defmodule Jupiter.RandomCoordsTest do
  @moduledoc """
    Test for RandomCoords
  """
  use ExUnit.Case, async: true

  alias Jupiter.RandomCoords

  test "it returns valid coordinates" do
    %{lat: lat, lon: lon} = RandomCoords.fetch
    assert lat >= -90 && lat <= 90
    assert lon >= -180 && lon <= 180
  end
end
