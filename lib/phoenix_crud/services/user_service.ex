defmodule PhoenixCrud.Services.UserService do
  alias PhoenixCrud.User;
  alias PhoenixCrud.Repo;

  def create_user(attrs \\ %{}) do
    %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
  end

  def update_user(id, attrs \\ %{}) do
    case Repo.get(User, id) do
      nil ->
        {:error, :not_found}
      user ->
        user
          |> User.changeset(attrs)
          |> Repo.update()
    end
  end

  def delete_user(id) do
    case Repo.get(User, id) do
      nil ->
        {:error, :not_found}
      user ->
        Repo.delete(user)
    end
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end
end
