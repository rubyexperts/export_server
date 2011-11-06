class Item < ActiveRecord::Base
  belongs_to :expense
  belongs_to :account
  belongs_to :project
  belongs_to :user
    
  validates_presence_of :item_description, :message=>"Line Description cannot be blank"
  validates_presence_of :account_id, :message=>"Expense Type cannot be blank"
  validates_presence_of :linecost, :message=>"Amount in USD cannot be blank"
  validates_numericality_of :linecost, :message=>"Amount must be a valid number"
  validates_numericality_of :linecost_euro, :allow_nil => true, :message=>"Euro Amount must be a valid number"
  validates_numericality_of :exchangerate, :allow_nil => true, :greater_than => 0, :message=>"if not blank, must be greater than 0"

  def validate
  	unless self.project_id.to_s.empty? or self.user_id.to_s.empty?
  		errors.add('Both','Project and "Filing for Others" cannot be entered, one has to be blank')
  	end

  end	

end

