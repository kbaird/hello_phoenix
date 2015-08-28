defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/",                 PageController,  :index
    get "/hello",            HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/post", PostController
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", HelloPhoenix do
    pipe_through :api

    resources "/zoidbergs", ZoidbergController
  end

  pipeline :review_checks do
    # TODO: would need to implement
    #plug :ensure_authenticated_user
    #plug :ensure_user_owns_review
  end

  scope "/reviews", HelloPhoenix do
    pipe_through :review_checks

    resources "/reviews", ReviewController
  end

  #scope "/admin", HelloPhoenix.Admin, as: :admin do
  #  pipe_through :browser # Use the default browser stack

  #  resources "/images",  ImageController
  #  resources "/reviews", ReviewController
  #  resources "/users",   UserController
  #end

  #scope "/api", HelloPhoenix.Api, as: :api do
  #  pipe_through :api

  #  scope "/v1", V1, as: :v1 do
  #    resources "/images",  ImageController
  #    resources "/reviews", ReviewController
  #    resources "/users",   UserController
  #  end
  #end
end
