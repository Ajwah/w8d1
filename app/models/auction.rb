class Auction < ApplicationRecord
  validates_presence_of :title, :description, :start_date, :end_date
end
