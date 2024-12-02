defmodule PhoenixCrud.Services.UserService do
  alias PhoenixCrud.User;
  alias PhoenixCrud.Repo;

  def create_user(attrs \\ %{}) do
    %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
  end
end
