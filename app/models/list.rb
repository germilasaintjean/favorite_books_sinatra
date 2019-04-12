class List < ActiveRecord::Base
    belongs_to :book
    validates_presence_of :title, :content
end