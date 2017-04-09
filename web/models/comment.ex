defmodule Discuss.Comment do 
    use Discuss.Web, :model

    schema "comments" do 
        belongs_to :user, Discuss.User 
        belongs_to :topic, Discuss.Topic
        field :content, :string 
        timestamps()
    end
    
    def changeset(struct, params \\ %{}) do 
        struct 
        |> cast(params, [:content])
        |> validate_required([:content])
    end
    

end
