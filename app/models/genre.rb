class Genre < ApplicationRecord

  belongs_to :post, optional: true
end
