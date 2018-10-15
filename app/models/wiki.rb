class Wiki < ApplicationRecord
  belongs_to :user
  
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :user,  presence: true
  validates :title, presence: true
  validates :body,  presence: true
  
  #scope :visible_to, -> (user) { user && user.standard? ? where( wikis: {private: nil}) : all }

end
