defmodule Discuss.Topic do 
    use Discuss.Web, :model
    
    schema "topics" do
        has_many :comments, Dicuss.Comment 
        belongs_to :user, Discuss.User
        field :title, :string
    end

    def changeset(struct, params \\ %{}) do 
        struct 
        |> cast(params, [:title])
        |> validate_required([:title])
    end
end
