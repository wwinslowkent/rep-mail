class BillsController < ApplicationController

  def index
    @bills = Bill.all.order(created_at: :asc)
    if params[:search]
      @search = params[:search]
      @bills = Bill.where('name  ~* ?', "#{@search}").order(name: :asc)
    else
      @bills = Bill.all.order(created_at: :asc)
    end
  end

  def show
    @bill = Bill.find(params[:id])
    binding.pry
    @messages = @bill.messages
    @message = Message.new
  end

  def new
    if user_signed_in?
      @bill = Bill.new
    else
      flash[:alert] = "Please sign in to add a bill"
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @bill = Bill.create(bill_params)

      if @bill.save && user_signed_in?
        flash[:notice] = "Thank you for adding this bill to our database!"
        redirect_to bill_path(@bill)
      else
        flash[:notice] = @bill.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "Please sign in to add a bill"
      redirect_to new_user_session_path
    end
  end

  def edit
    if current_user.admin
      @bill = Bill.find(params[:id])
    else
      flash[:alert] = "UNAUTHORIZED"
      redirect_to new_admin_session_path
    end
  end

  def update
    if current_user.admin
      @bill = Bill.find(params[:id])
      @bill.update_attributes(bill_params)

      if @bill.save
        flash[:notice] = "Thank you for editing this bill!"
        redirect_to bill_path(@bill)
      else
        flash[:notice] = @bill.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "UNAUTHORIZED"
      redirect_to new_admin_session_path
    end
  end

  def destroy
    if current_user.admin
      @bill = Bill.find(params[:id])
      @bill.destroy
      flash[:alert] = "You have deleted this bill successfully"
      redirect_to bills_path
    else
      flash[:alert] = 'UNAUTHORIZED'
      redirect_to new_admin_session_path
    end
  end

  private

  def bill_params
    params.require(:bill).permit(
      :title,
      :description,
      :location
    )
  end
end
