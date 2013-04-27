class Vote < ActiveRecord::Base
  attr_accessible :message, :ts, :voted_by, :voted_id, :voted_time
end
