class Expense < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  belongs_to :user
  validates_presence_of :name, :message=>"Expense Report Description cannot be blank"
  validates_numericality_of :exchangerate, :allow_nil => true, :greater_than => 0, :message=>"if not blank, must be greater than 0"
  accepts_nested_attributes_for :items, :allow_destroy => true
   


 def self.search(search,page,userid)
 	if search and search != ""
 		   #find(:all, :conditions => ['id = ? AND user_id = ?', "#{search}", "#{userid}"])
 		   paginate :per_page => 13, :page => page,
 		   :conditions => ['id = ? AND user_id = ?', "#{search}","#{userid}"]
    else 
 		 #  find(:all, :conditions => ['user_id = ?', "#{userid}"])
 		   paginate :per_page => 13, :page => page,
 		   :conditions => ['user_id = ?', "#{userid}"]

 	end
 end

 def self.search_list(search,page)
 	if search and search != ""
 		   # find(:all, :conditions => ['id = ?', "#{search}"])
 		   paginate :per_page => 13, :page => page,
 		   :conditions => ['id = ?', "#{search}"]

    else 
 		  # find(:all,page)
 		  paginate :per_page => 13, :page => page,
 		  :conditions => ["#{search}"]

 	end
 end
 
  def total_amount
  	 @total_amount = self.items.sum(:linecost)
  end

  def total_amount_marketing
    @total_amount_marketing = self.items.sum(:linecost, :conditions => ['ptslmarketing = ?','t'])
    
  end
  def total_amount_marketing_euro
    @total_amount_marketing_euro = self.items.sum(:linecost_euro, :conditions => ['ptslmarketing = ?','t'])
  end
  def total_amount_euro
    @total_amount_euro = self.items.sum(:linecost_euro)
  end

  def get_date
  		@ndate = self.items.maximum(:expense_date)
  		return @ndate
  end



  def before_validation
  	 
  	 self.items.each do |lineitem|
  	 	 if !lineitem.linecost_euro.to_s.empty?
  	 	   if !lineitem.exchangerate.to_s.empty?
  	 	   	  lineitem.linecost =  lineitem.linecost_euro * lineitem.exchangerate.to_f
  	 	   else
  	 	      lineitem.linecost =  lineitem.linecost_euro * self.exchangerate.to_f
  	 	   end
  	 	 end
  	 	 
  	 	 if lineitem.project_id.to_s.empty? and lineitem.user_id.to_s.empty?
  	 	 	lineitem.cost_center = self.user.cost_center
  	 	 elsif !lineitem.project_id.to_s.empty? and lineitem.user_id.to_s.empty?
  	 	 	lineitem.cost_center = lineitem.project.wbscode
  	 	 elsif lineitem.project_id.to_s.empty? and !lineitem.user_id.to_s.empty?
  	 	 	lineitem.cost_center = lineitem.user.cost_center
  	 	 else
  	 	 	lineitem.cost_center = nil
  	 	 end	
  	  end 
  	  
  end

  def before_create
  	 self.status = 'UNPAID'
  end

 
 
end
