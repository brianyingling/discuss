defmodule Discuss.User do 
    use Discuss.Web, :model

    schema "users" do
        has_many :topics, Discuss.Topic
        has_many :comments, Discuss.Comment 
        field :email, :string 
        field :provider, :string
        field :token, :string
        timestamps()
    end

    def changeset(struct, params \\ %{}) do 
        struct 
        |> cast(params, [:email, :provider, :token])
        |> validate_required([:email, :provider, :token])
    end

end
