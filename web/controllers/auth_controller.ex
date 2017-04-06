defmodule Discuss.AuthController do 
    use Discuss.Web, :controller
    plug Ueberauth
    alias Discuss.User
    
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do 
        user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
        changeset = User.changeset(%User{}, user_params)
        signin conn, changeset
    end

    def signout(conn, _params) do 
        conn
        |> configure_session(drop: true)
        |> redirect(to: topic_path(conn, :index))
    end

    defp signin(conn, changeset) do 
        case insert_or_update_user(changeset) do
            {:ok, user }        -> handle_signin_success(conn, user.id)
            {:error, _reason}   -> handle_signin_error(conn)
        end
    end

    defp handle_signin_success(conn, user_id) do
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user_id) 
        |> redirect(to: topic_path(conn, :index)) 
    end

    defp handle_signin_error(conn) do 
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :index))
    end

    defp insert_or_update_user(changeset) do 
        case Repo.get_by User, email: changeset.changes.email do 
            nil     -> Repo.insert changeset
            user    -> {:ok, user}
        end
    end
end
