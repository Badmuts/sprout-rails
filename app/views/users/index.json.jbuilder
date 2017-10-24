json.partial! 'metadata'
json.results @users, partial: 'users/user', as: :user
