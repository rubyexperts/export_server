class Account < ActiveRecord::Base
  has_many :items
  attr_accessible :account, :sapglaccount
  accepts_nested_attributes_for :items 
  
  
   def self.search(search,page)
 	if search and search != ""
 		   # find(:all, :conditions => ['account like ?', "%#{search}%"])
 		   paginate :per_page => 13, :page => page,
 		   :conditions => ['account like ?', "%#{search}%"]

    else 
 		  # find(:all,page)
 		  paginate :per_page => 13, :page => page,
 		  :conditions => ["#{search}"]

 	end
 end

  
end
