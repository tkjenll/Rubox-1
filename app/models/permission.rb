class Permission < ActiveRecord::Base
  attr_accessible :path

  belongs_to :type
  belongs_to :user
  belongs_to :project
end
