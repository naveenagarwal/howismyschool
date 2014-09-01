class Comment < ActiveRecord::Base
  belongs_to :comentator, polymorphic: true
  belongs_to :comment_for, polymorphic: true
end
