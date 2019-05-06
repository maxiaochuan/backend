module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: true do
      description "Find User by ID"
      argument :id, ID, required: true
    end

    field :users, [UserType], null: true do
      description "All Users"
    end

    field :microposts, [MicropostType], null: true do
      description "All Microposts"
      argument :id, ID, required: false
      argument :user_id, ID, required: false
    end

    def user id:
      User.find(id)
    end

    def users
      User.all()
    end

    def microposts options = {}
      Micropost.where options
    end
  end
end
