class RequestsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_request, except: [:new, :list, :index, :create]
  before_action :is_authorised, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :list]

  def index
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build(request_params)

    if @request.save
        flash[:success] = "Request created succesfully"
        redirect_to requests_path
    
    else

        flash[:alert] = @request.errors.full_messages.join(', ')
        redirect_to request.referrer
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  def list
  end

  private
  
  def set_categories
    @categories = Category.all
  end

  def set_request
    @request = Request.find(params[:id])
  end
  
  def is_authorised
    redirect_to root_path, alert: " You dont have permission to execute this action. Verify you are logged in." unless current_user.id == @request.user.id
  end
  def request_params
    params.require(:request).permit(:category_id, :description, :delivery, :budget, :attachment_file, :title)
  end
end
