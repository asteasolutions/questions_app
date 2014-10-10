class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :text, :question, :user, presence: true

end
