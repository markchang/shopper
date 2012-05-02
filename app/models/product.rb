class Product < ActiveRecord::Base
	attr_accessible :name, :price, :description
	belongs_to :user

	default_scope order: 'products.updated_at DESC'

	validates :name, :price, :description, :user_id, :presence => true
	validates :price, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
end
