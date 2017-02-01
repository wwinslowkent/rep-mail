class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    render json: @user
  end

  def new
    @bill = Bill.find(params[:id])
    @message = Message.new
  end

  def destroy
    data = JSON.parse(request.body.read)
    message = Message.find(data["id"])
    @messageUsers = []
    @bill = Bill.find(params[:bill_id])
    if message.delete
      @messages = @bill.messages.order(:created_at).reverse
      @messages.each do |message|
        user = User.find(message.user_id)
        @messageUsers << user
      end
      render json: {messages: @messages, users: @messageUsers }
    end
  end

  def update
    #data is the fetch request
    data = JSON.parse(request.body.read)
    message = Message.find(data["id"])
    @bill = message.bill
    @messageUsers = []
    if (data["type"] == "update")
      message.title = data["title"]
      message.body = data["message"]
      message.procon = data["procon"]
      message.save
      @messages = @bill.messages.order(:created_at).reverse
      @messages.each do |message|
        user = User.find(message.user_id)
        @messageUsers << user
      end
    end
    if (data["type"] == "upvote")
      binding.pry
      if ( Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"]).empty?)
        Vote.create(vote: "1", message_id: data["id"], user_id: data["userId"])
        message.up_votes += 1
      else
        @vote = Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"])[0]
        if (@vote.vote == "1")
          @vote.vote = "0"
          message.up_votes -= 1
        elsif (@vote.vote = "-1")
          @vote.vote = "1"
          message.up_votes += 2
          message.down_votes -= 1
        else
          @vote.vote = "1"
          message.up_votes += 1
        end
      end
      message.save
      @messages = @bill.messages.order(:created_at).reverse
      @messages.each do |message|
        user = User.find(message.user_id)
        @messageUsers << user
      end
    end
    if (data["type"] == "downvote")
      if ( Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"]).empty?)
        Vote.create(vote: "-1", message_id: data["id"], user_id: data["userId"])
        message.down_votes += 1
      else
        @vote = Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"])[0]
        if (@vote.vote == "-1")
          @vote.vote = "0"
          message.down_votes -= 1
        elsif (@vote.vote = "1")
          @vote.vote = "-1"
          message.down_votes += 2
          message.up_votes -= 1
        else
          @vote.vote = "-1"
          message.down_votes += 1
        end
      end
      message.save
      @messages = @bill.messages.order(:created_at).reverse
      @messages.each do |message|
        user = User.find(message.user_id)
        @messageUsers << user
      end
    end
    render json: {messages: @messages, users: @messageUsers }
  end

  def create
    @bill = Bill.find(params[:bill_id])
    #this is how you read fetch body data
    data = JSON.parse(request.body.read)
    @user = User.find(data["userId"])
    @message = Message.new(message: data["message"], title: data["title"], procon: data["procon"])
    @message.user = @user
    @message.bill = @bill
    @messageUsers = []

    if @message.save!
      @messages = @bill.messages.order(:created_at).reverse
      @messages.each do |message|
        user = User.find(message.user_id)
        @messageUsers << user
      end
      render json: {messages: @messages, users: @messageUsers }
    else
      render json: {message: "Did not work"}, status: 404
    end
  end
end
