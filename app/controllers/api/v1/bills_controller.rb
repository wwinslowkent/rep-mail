class Api::V1::BillsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def index
    @bills = Bill.all
    @user = current_user
    render json: { user: @user }
  end

  def show
    @bill = Bill.find(params[:id])
    @reviews = @bill.reviews.order(:created_at).reverse
    @user = current_user
    @messageUsers = []
    @isAdmin = admin_signed_in?
    @reviews.each do |review|
      user = User.find(review.user_id)
      @messageUsers << user
    end
    render json: { user: @user, reviews: @reviews, messageUsers: @messageUsers, isAdmin: @isAdmin }
    # passing in user and review through ajax call in react
    # http://localhost:3000/api/v1/bills/3.json to see the object
  end
end
