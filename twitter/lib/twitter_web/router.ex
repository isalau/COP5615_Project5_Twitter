defmodule TwitterWeb.Router do
  use TwitterWeb, :router

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

  scope "/", TwitterWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/register", RegisterController, :index
    post "/register", RegisterController, :register
    get "/signin", SigninController, :index
    post "/signin", SigninController, :signin
    resources "/events", EventController
    resources "/tweet", TweetController
    post "/tweet", TweetController, :create
    resources "/user", UserController
    get "/setting", SettingController, :index
    post "/setting", SettingController, :delete
    # resources "/setting", SettingController
    resources "/add", AddController

    # get "/*thing", PageController, :wildcard
  end

  # Other scopes may use custom stacks.
  # scope "/api", TwitterWeb do
  #   pipe_through :api
  # end
end
