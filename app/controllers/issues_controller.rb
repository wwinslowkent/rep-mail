class IssuesController < ApplicationController

  def index
    @issues = Issue.all.order(created_at: :asc)
    if params[:search]
      @search = params[:search]
      @issues = Issue.where('title  ~* ?', "#{@search}")
    else
      @issues = Issue.all.order(created_at: :asc)
    end
  end

  def show
    @issue = Issue.find(params[:id])
    @messages = @issue.messages
    @message = Message.new
  end

  def new
    if user_signed_in?
      @issue = Issue.new
    else
      flash[:alert] = "Please sign in to add a issue"
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @issue = Issue.create(issue_params)

      if @issue.save && user_signed_in?
        flash[:notice] = "Thank you for adding this issue to our database!"
        redirect_to issue_path(@issue)
      else
        flash[:notice] = @issue.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "Please sign in to add a issue"
      redirect_to new_user_session_path
    end
  end

  def edit
    if current_user.admin
      @issue = Issue.find(params[:id])
    else
      flash[:alert] = "UNAUTHORIZED"
      redirect_to new_admin_session_path
    end
  end

  def update
    if current_user.admin
      @issue = Issue.find(params[:id])
      @issue.update_attributes(issue_params)

      if @issue.save
        flash[:notice] = "Thank you for editing this issue!"
        redirect_to issue_path(@issue)
      else
        flash[:notice] = @issue.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "UNAUTHORIZED"
      redirect_to new_admin_session_path
    end
  end

  def destroy
    if current_user.admin
      @issue = Issue.find(params[:id])
      @issue.destroy
      flash[:alert] = "You have deleted this issue successfully"
      redirect_to issues_path
    else
      flash[:alert] = 'UNAUTHORIZED'
      redirect_to new_admin_session_path
    end
  end

  private

  def issue_params
    params.require(:issue).permit(
      :title
    )
  end
end
