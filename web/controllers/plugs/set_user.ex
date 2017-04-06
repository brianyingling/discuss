defmodule Discuss.Plugs.SetUser do 
    import Plug.Conn
    import Phoenix.Controller

    alias Discuss.Repo
    alias Discuss.User
    
    # no setup needed
    def init(_params) do 
    end
    
    # if a user id exists, fetch the user from the deb
    # _params is the return value of whatever returns from the
    # init fn
    def call(conn, _params) do
        assign_user_if_exists conn
    end

    defp assign_user_if_exists(conn) do
        user_id = get_session conn, :user_id
        cond do
            user = user_id && Repo.get(User, user_id) -> 
                assign(conn, :user, user)
            true -> 
                assign(conn, :user, nil)
        end
    end
end
