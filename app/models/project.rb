class Project < ActiveRecord::Base
  has_many :items
  attr_accessible :wbscode, :costcenter, :site, :description
  
  
  def self.search(search,page)
 	if search and search != ""
 		   # find(:all, :conditions => ['description like ?', "%#{search}%"])
 		   paginate :per_page => 13, :page => page,
 		   :conditions => ['description like ?', "%#{search}%"]

    else 
 		  # find(:all,page)
 		  paginate :per_page => 13, :page => page,
 		  :conditions => ["#{search}"]

 	end
  end
  
  
end
