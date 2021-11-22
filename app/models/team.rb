class Team < ApplicationRecord
  belongs_to :created_by, foreign_key: :user_id, class_name: 'User', optional: true
end
