class GigsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_gig, except: [:new, :create]
  before_action :is_authorised, only: [:edit, :update, :upload_photo, :delete_photo]
  before_action :set_step, only: [:edit, :update]

  def new
    @gig = current_user.gigs.build
    @categories = Category.all
  end

  def create
    @gig = current_user.gigs.build(gig_params)

    if @gig.save
      @gig.pricings.create(Pricing.pricing_types.values.map{|x|  {pricing_type: x}})
      redirect_to "#{edit_gig_path(@gig)}?step=1", notice: "Saving"
    else
      redirect_to request.referrer, flash: {error: @gig.errors.full_messages}
    end

  end

  def edit
    @categories = Category.all
<<<<<<< HEAD
  
  end

  def upload_photo
    @gig.photos.attach(params[:file])
    render json: {success: true}

=======
    @step = params[:step].to_i
>>>>>>> 7caf1715686047e874f92cf35e9e710a28b74d21
  end

  def delete_photo
    @image = ActiveStorage::Attachment.find(params[:photo_id])
    @image.purge
    redirect_to edit_gig_path(@gig, step: 4)

  end
  def update
    if @step ==2
      gig_params[:pricings_attributes].each do |index, pricing|
        if @gig.has_single_pricing && pricing[:pricing_type] != Pricing.pricing_types.key(0)
          next;
        else
          if pricing[:title].blank? || pricing[:description].blank? || pricing[:delivery_time].blank? || pricing[:price].blank?
            return redirect_to request.referrer, flash: {error: " Invalid Pricing"}
          end
        end

      end
    end

    if @step == 3 && gig_params[:description].blank?
      return redirect_to request.referrer, flash: {error: " The gig needs to have a description"}

    end
    if @step == 4 && @gig.photos.blank?
      return redirect_to request.referrer, flash: {error: " You dont have any photos."}

    end

    if @step == 5
      @gig.pricings.each do |pricing|
        if @gig.has_single_pricing && !pricing.basic?
          next;
        else
          if pricing[:title].blank? || pricing[:description].blank? || pricing[:delivery_time].blank? || pricing[:price].blank?
            return redirect_to edit_gig_path(@gig, step: 2), flash: {error: " Invalid pricing"}

          end
        end

      end
      if @gig.description.blank?
        return redirect_to edit_gig_path(@gig, step: 3), flash: {error: " Blank description not allowed"}
      elsif @gig.photos.blank?

        return redirect_to edit_gig_path(@gig, step: 4), flash: {error: " You must include at least 1 pic"}

      end

    end
    if @gig.update(gig_params)
      flash[:notice] = "Saved..."
    else
      return redirect_to request.referrer, flash: {error: @gig.errors.full_messages }
    end

    if @step < 5
      redirect_to edit_gig_path(@gig, step: @step+1)
    else
      redirect_to dashboard_path

    end
  end

  def show
  end

  private

  def set_step
    @step = params[:step].to_i > 0 ? params[:step].to_i : 1
    if @step > 5
      @step =5 
    end
  end

  def set_gig
    @gig = Gig.find(params[:id])
  end

  def is_authorised
    redirect_to root_path, alert: "You dont have permission" unless current_user.id == @gig.user_id
  end

  def gig_params
    params.require(:gig).permit(:title, :video, :description,:active, :category_id, :has_single_pricing, pricings_attributes: [:id, :title,                            :description, :delivery_time, :price,:pricing_type])
  end
end