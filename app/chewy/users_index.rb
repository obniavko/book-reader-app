class UsersIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope User
  field :first_name
  field :last_name
  field :email, analyzer: 'email'
end
