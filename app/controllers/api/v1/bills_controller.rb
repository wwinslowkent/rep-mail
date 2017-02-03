class Api::V1::BillsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def index
    @bills = Bill.all
    @user = current_user
    render json: { user: @user }
  end

  def show
    @bill = Bill.find(params[:id])
    @messages = @bill.messages.order(:vote).reverse
    @user = current_user
    @messageUsers = []
    @isAdmin = @user.admin
    @messages.each do |message|
      user = User.find(message.user_id)
      @messageUsers << user
    end
    render json: { user: @user, messages: @messages, messageUsers: @messageUsers, isAdmin: @isAdmin }
    # passing in user and message through ajax call in react
    # http://localhost:3000/api/v1/bills/3.json to see the object
  end
end
