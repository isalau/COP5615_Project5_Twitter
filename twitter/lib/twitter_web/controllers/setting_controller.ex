defmodule TwitterWeb.SettingController do
  use TwitterWeb, :controller

  alias Twitter.Settings
  alias Twitter.Settings.Setting

  def index(conn, _params) do
    setting = Settings.list_setting()
    render(conn, "index.html", setting: setting)
  end

  def delete(conn, params) do
    user_name = get_in(params, ["user_name"])
    pid_sender = :"#{user_name}"
    IO.inspect(pid_sender, label: "To Delete")
    Delete.deleteUser(pid_sender)

    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  # def new(conn, _params) do
  #   changeset = Settings.change_setting(%Setting{})
  #   render(conn, "new.html", changeset: changeset)
  # end
  #
  # def create(conn, %{"setting" => setting_params}) do
  #   case Settings.create_setting(setting_params) do
  #     {:ok, setting} ->
  #       conn
  #       |> put_flash(:info, "Setting created successfully.")
  #       |> redirect(to: Routes.setting_path(conn, :show, setting))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end
  #
  # def show(conn, %{"id" => id}) do
  #   setting = Settings.get_setting!(id)
  #   render(conn, "show.html", setting: setting)
  # end
  #
  # def edit(conn, %{"id" => id}) do
  #   setting = Settings.get_setting!(id)
  #   changeset = Settings.change_setting(setting)
  #   render(conn, "edit.html", setting: setting, changeset: changeset)
  # end
  #
  # def update(conn, %{"id" => id, "setting" => setting_params}) do
  #   setting = Settings.get_setting!(id)
  #
  #   case Settings.update_setting(setting, setting_params) do
  #     {:ok, setting} ->
  #       conn
  #       |> put_flash(:info, "Setting updated successfully.")
  #       |> redirect(to: Routes.setting_path(conn, :show, setting))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", setting: setting, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   setting = Settings.get_setting!(id)
  #   {:ok, _setting} = Settings.delete_setting(setting)
  #
  #   conn
  #   |> put_flash(:info, "Setting deleted successfully.")
  #   |> redirect(to: Routes.setting_path(conn, :index))
  # end
end
