class Team < ActiveRecord::Base
  belongs_to :event
  attr_accessible :name
end
