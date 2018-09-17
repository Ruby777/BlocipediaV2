class Wiki < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true
  validates :body, presence: true
  
  scope :visible_to, -> (user) { user && user.standard? ? where( wikis: {private: nil}) : all }

end
