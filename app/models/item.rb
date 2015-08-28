class Item < ActiveRecord::Base
  belongs_to :list, counter_cache: true, inverse_of: :items
end
