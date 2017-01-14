defmodule Jupiter.Router do
  use Jupiter.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Jupiter do
    pipe_through :api

    scope "/weather" do
      get "/random", WeatherController, :random
      # get "/search", WeatherController, :search
    end
  end

  scope "/", Jupiter do
    pipe_through :browser # Use the default browser stack

    # handle all other requests through PageController
    # they will be handled by react-router
    get "/*path", PageController, :index
  end
end
