class ExpensesController < ApplicationController

layout :choose_layout  

def choose_layout    
  if [ 'show' ].include? action_name
    'print'
  else
    'expense'
  end
end

before_filter :authorize_access

  def index
    #@expenses = Expense.search(params[:search], [@current_user.id])
    @expenses = Expense.search(params[:search], params[:page], [@current_user.id] )
  end
  
  def search_list
    #@expenses = Expense.search_list(params[:search])
     @expenses = Expense.search_list(params[:search], params[:page])
  end
  	
  def show
    @expense = Expense.find(params[:id])
    @total_amount = @expense.total_amount
	@total_amount_marketing = @expense.total_amount_marketing
	@total_amount_euro = @expense.total_amount_euro
	@total_amount_marketing_euro = @expense.total_amount_marketing_euro

  end

  def new
    @expense = Expense.new
    @total_amount = 0
    @total_amount_euro = 0
    @total_amount_marketing = 0
    @total_amount_marketing_euro = 0
   

  end

  def create
    @expense = @current_user.expenses.build params[:expense] 
    if @expense.save
      flash[:notice] = "Successfully created expense."
      redirect_to edit_expense_path(@expense)
    else
      render :action => 'new'
    end
  end


  def edit
    @expense = Expense.find(params[:id])
    
    @total_amount = @expense.total_amount
	@total_amount_marketing = @expense.total_amount_marketing
	@total_amount_euro = @expense.total_amount_euro
	@total_amount_marketing_euro = @expense.total_amount_marketing_euro
        @marketing_array = User.all.collect(&:ptslmarketing).join(",") 
        @users_array = User.all.collect(&:id).join(",")
  end

  def status_change
    @expense = Expense.find(params[:id])
    
    @total_amount = @expense.total_amount
	@total_amount_marketing = @expense.total_amount_marketing
	@total_amount_euro = @expense.total_amount_euro
	@total_amount_marketing_euro = @expense.total_amount_marketing_euro
  end

  def update
    @expense = Expense.find(params[:id])
    
    if @expense.update_attributes(params[:expense])
      flash[:notice] = "Successfully updated expense."
      if request.referer.include?('status_change')
      	render :action => 'status_change'
      else
        redirect_to edit_expense_path(@expense)
      end
    else
    	  render :action => 'edit'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:notice] = "Successfully destroyed expense."
    redirect_to expenses_url
  end
  
  
end
