class Question < ActiveRecord::Base
  belongs_to :user

  validates :text, :user, presence: true

end
