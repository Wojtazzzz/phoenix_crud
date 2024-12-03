defmodule PhoenixCrudWeb.UserController do
  use PhoenixCrudWeb, :controller

  alias PhoenixCrud.Repo
  alias PhoenixCrud.User
  alias PhoenixCrud.Services.UserService

  def index(conn, _params) do
    users = Repo.all(User);

    render(conn, :index, users: users);
  end

  def new(conn, _params) do
    render(conn, :new, errors: Map.new());
  end

  def create(conn, %{"user" => user_params}) do
    case UserService.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully!")
        |> redirect(to: "/users")
      {:error, changeset} ->
        render(conn, :new, errors: changeset.errors)
    end
  end

  def edit(conn, %{"id" => id}) do
    case UserService.get_by_id(String.to_integer(id)) do
        nil -> conn
          |> put_flash(:error, "User not found.")
          |> redirect(to: "/users")
        user ->
          render(conn, :edit, user: user, errors: Map.new())
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    case UserService.update_user(String.to_integer(id), user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated successfully!")
        |> redirect(to: "/users")
      {:error, :not_found} ->
        conn
          |> put_flash(:error, "User not found.")
          |> redirect(to: "/users")
      {:error, changeset} ->
        render(conn, :edit, user: UserService.get_by_id(id), errors: changeset.errors)
    end
  end

  def delete(conn, %{"id" => id}) do
    case UserService.delete_user(String.to_integer(id)) do
      {:ok, _user} ->
        conn
          |> put_flash(:info, "User deleted successfully!")
          |> redirect(to: "/users")
      {:error, _reason} ->
        conn
          |> put_flash(:error, "User not deleted successfully!")
          |> redirect(to: "/users")
    end
  end
end
