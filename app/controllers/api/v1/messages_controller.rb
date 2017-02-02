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
    @bmessage = Bmessage.find_by(message_id: data["id"])
    if message.delete
      @bmessage.delete
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
    @bill = Bill.find(data["billId"])
    @messageUsers = []
    if (data["type"] == "update")
      message.title = data["title"]
      message.body = data["body"]
      message.procon = data["procon"]
      message.save
      @messages = @bill.messages.order(:created_at).reverse
      @messages.each do |message|
        user = User.find(message.user_id)
        @messageUsers << user
      end
    end
    if (data["type"] == "upvote")
      if ( Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"]).empty?)
        Vote.create(vote: "1", message_id: data["id"], user_id: data["userId"])
        message.vote += 1
      else
        @vote = Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"])[0]
        if (@vote.vote == "1")
          @vote.vote = "0"
          message.vote -= 1
        elsif (@vote.vote = "-1")
          @vote.vote = "1"
          message.vote += 2
        else
          @vote.vote = "1"
          message.vote += 1
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
        message.vote -= 1
      else
        @vote = Vote.where("message_id = ? AND user_id = ?", data["id"], data["userId"])[0]
        if (@vote.vote == "-1")
          @vote.vote = "0"
          message.vote += 1
        elsif (@vote.vote = "1")
          @vote.vote = "-1"
          message.vote -= 2
        else
          @vote.vote = "-1"
          message.vote -= 1
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
    @message = Message.new(body: data["body"], title: data["title"], procon: data["procon"], vote: 0)
    @message.user_id = @user.id
    Bmessage.create(bill: @bill, message: @message)
    @messageUsers = []

    if @message.save!
      @messages = @bill.messages.order(:created_at)
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
