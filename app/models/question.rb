class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :text, :user, presence: true

end
