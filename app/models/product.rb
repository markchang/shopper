class Product < ActiveRecord::Base
	attr_accessible :title, :price, :description
	belongs_to :user

	default_scope order: 'products.updated_at DESC'

	validates :title, :price, :description, :user_id, :presence => true
	validates :price, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
end
