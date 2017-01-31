class RepresentativesController < ApplicationController

  def index
    @representatives = Representative.all.order(created_at: :asc)
    if params[:search]
      @search = params[:search]

      @representatives = Representative.includes(:zipcodes).where("zipcodes.zip = '#{@search}'").references(:zipcodes)
    else
      @representatives = Representative.all.order(created_at: :asc)
    end
  end

  def show
    @representative = Representative.find(params[:id])
  end

  def new
    if user_signed_in?
      @representative = Representative.new
    else
      flash[:alert] = "Please sign in to add a representative"
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @representative = Representative.create(rep_params)

      if @representative.save && user_signed_in?
        flash[:notice] = "Thank you for adding this representative to our database!"
        redirect_to representative_path(@representative)
      else
        flash[:notice] = @representative.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "Please sign in to add a representative"
      redirect_to new_user_session_path
    end
  end

  def edit
    if current_user.admin
      @representative = Representative.find(params[:id])
    else
      flash[:alert] = "UNAUTHORIZED"
      redirect_to new_admin_session_path
    end
  end

  def update
    if current_user.admin
      @representative = Representative.find(params[:id])
      @representative.update_attributes(representative_params)

      if @representative.save
        flash[:notice] = "Thank you for editing this representative!"
        redirect_to representative_path(@representative)
      else
        flash[:notice] = @representative.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "UNAUTHORIZED"
      redirect_to new_admin_session_path
    end
  end

  def destroy
    if current_user.admin
      @representative = Representative.find(params[:id])
      @representative.destroy
      flash[:alert] = "You have deleted this representative successfully"
      redirect_to representatives_path
    else
      flash[:alert] = 'UNAUTHORIZED'
      redirect_to new_admin_session_path
    end
  end

  private

  def rep_params
    params.require(:representative).permit(
      :name,
      :state,
      :party,
      :address,
      :email,
      :image,
      :phone,
      :webiste
    )
  end
end
