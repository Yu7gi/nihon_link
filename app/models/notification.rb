class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc)}
    belongs_to :comment, optional: true
    belongs_to :permit, optional: true
    belongs_to :message, optional: true

    belongs_to :visitor, class_name: 'User'
    belongs_to :visited, class_name: 'User'
    
end
