class User < ApplicationRecord
  has_many :wikis, dependent: :destroy
  
  has_many :collaborators

  after_initialize { self.role ||= :standard }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :admin, :premium, :collaborator]
end
