defmodule PhoenixCrud.Services.UserService do
  alias PhoenixCrud.User;
  alias PhoenixCrud.Repo;

  def create_user(attrs \\ %{}) do
    %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
  end

  def delete_user(id) do
    User
    |> Repo.get(id)
    |> case do
      nil ->
        {:error, :not_found}
      user ->
        Repo.delete(user)
    end
  end
end
