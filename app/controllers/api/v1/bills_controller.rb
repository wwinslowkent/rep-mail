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
    @userzip = @user.zip
    @representatives = Representative.includes(:zipcodes).where("zipcodes.zip = '#{@userzip}'").references(:zipcodes)
    @messageUsers = []
    if @representatives.size == 3
      @repname = @representatives[0].name
      @repemail = @representatives[0].website
      @sen1name = @representatives[1].name
      @sen1email = @representatives[1].website
      @sen2name = @representatives[2].name
      @sen2email = @representatives[2].website
    end
    @isAdmin = @user.admin
    @messages.each do |message|
      user = User.find(message.user_id)
      @messageUsers << user
    end
    render json: { user: @user,
      messages: @messages,
      messageUsers: @messageUsers,
      isAdmin: @isAdmin,
      repname: @repname,
      repemail: @repemail,
      sen1name: @sen1name,
      sen1email: @sen1email,
      sen2name: @sen2name,
      sen2email: @sen2email

    }
    # passing in user and message through ajax call in react
    # http://localhost:3000/api/v1/bills/3.json to see the object
  end
end
