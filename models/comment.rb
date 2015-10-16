class Comment < ActiveRecord::Base
  validates :comment, presence: true
  belongs_to :contact

end
