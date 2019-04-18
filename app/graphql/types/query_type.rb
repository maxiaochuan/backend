module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: true do
      description "Find user by ID"
      argument :id, ID, required: true
    end

    field :users, [UserType], null: true do
      description "All Users"
    end

    def user id:
      User.find(id)
    end

    def users
      User.all()
    end
  end
end
