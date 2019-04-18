module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :user, UserType, null: true do
      description "Find user by ID"
      argument :id, ID, required: true
    end

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    def user id:
      User.find(id)
    end
  end
end
