defmodule Discuss.Topic do 
    use Discuss.Web, :model
    
    schema "topics" do 
        belongs_to :user, Discuss.User
        field :title, :string
    end

    def changeset(struct, params \\ %{}) do 
        struct 
        |> cast(params, [:title])
        |> validate_required([:title])
    end
end
