class GatheringsController < ApplicationController
  before_action :set_gathering, only: [:edit, :update, :destroy, :finalize]
  before_action -> { check_gathering_access(params[:id])}, only: [:show, :update]


  # GET /gatherings
  # GET /gatherings.json
  def index
    @gatherings = current_user.gatherings
  end

  # GET /gatherings/1
  # GET /gatherings/1.json
  def show
    @moment = Moment.new
    @activity = Activity.new
    @comment = Comment.new
    @gathering = Gathering.includes(:moments, :comments).find(params[:id])
    @place = Place.new
    @collaborators = @gathering.users
    @users = User.all - @collaborators
  end

  def add_users
    binding.pry
    @gathering = Gathering.find(params[:id])
    @user = User.find(params[:user][:id])
    @gathering.users << @user
    respond_to do |format|
      format.html{redirect_to @gathering}
      format.js{}
    end
  end

  def remove_users
    # TODO: what if user is last user and removes themself? build in ability to destroy gathering?
    @user = User.find(params[:user])
    @gathering = Gathering.find(params[:id])
    if @user == current_user
      @gathering.users.delete(@user)
      redirect_to gatherings_path
    else
      @gathering.users.delete(@user)
      respond_to do |format|
        format.html {redirect_to @gathering}
        format.js { }
      end
    end
  end

  def stage
    @gathering = Gathering.includes(:moments, :activities, :places).find(params[:id])
    [:moment,:activity,:place].each do |class_name|
      suggestion = @gathering.find_best(class_name)
      @gathering.public_send(class_name.to_s.pluralize).each do |object|
        suggestion == object ? s = true : s = false
        object.instance_variable_set(:@suggested,s)
        def object.suggested?  #singleton methods generated dynamically
          @suggested
        end
      end
    end
  end

  # GET /gatherings/new
  def new
    @gathering = Gathering.new
  end

  # GET /gatherings/1/edit
  def edit
  end

  # POST /gatherings
  # POST /gatherings.json
  def create
    @gathering = Gathering.new(gathering_params)
    @gathering.owner = current_user
    @gathering.users << current_user

    respond_to do |format|
      if @gathering.save
        format.html { redirect_to @gathering, notice: 'Gathering was successfully created.' }
        format.json { render :show, status: :created, location: @gathering }
      else
        format.html { render :new }
        format.json { render json: @gathering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gatherings/1
  # PATCH/PUT /gatherings/1.json
  def update
    @gathering = Gathering.find(params[:id])
    respond_to do |format|
      if @gathering.update(gathering_params)
        format.html { redirect_to @gathering, notice: 'Gathering was successfully updated.' }
        format.json { render :show, status: :ok, location: @gathering }
        format.js { head 204 }
      else
        format.html { render :edit }
        format.json { render json: @gathering.errors, status: :unprocessable_entity }
      end
    end
  end

  def finalize
    # @gathering.finalize_with_args(
    #   moment: Moment.find(finalized_params[:moments]),
    #   activity: Activity.find(finalized_params[:activities]),
    #   place: Place.find(finalized_params[:places]))

    @plan = FinalizedPlan.create(
      moment_id: finalized_params[:moments],
      activity_id: finalized_params[:activities],
      place_id: finalized_params[:places],
      gathering_id: params[:id])

    if @plan
      @gathering.finalize
      @gathering.save
    end
  end

  # DELETE /gatherings/1
  # DELETE /gatherings/1.json
  def destroy
    @gathering.destroy
    respond_to do |format|
      format.html { redirect_to gatherings_url, notice: 'Gathering was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gathering
      @gathering = Gathering.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gathering_params
      params.require(:gathering).permit(:title)
    end

    def finalized_params
      params.permit(:moments, :activities, :places)
    end
end
