class List < ActiveRecord::Base
  belongs_to :user, counter_cache: true, inverse_of: :lists
  
  has_many :items, inverse_of: :list
end
