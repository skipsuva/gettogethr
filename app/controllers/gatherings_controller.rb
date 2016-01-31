class GatheringsController < ApplicationController
  before_action :set_gathering, only: [:edit, :update, :destroy]

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
    @gathering = Gathering.includes(:moments).find(params[:id])

    @collaborators = @gathering.users
  #  @users = []
  #  User.all.each do |user|
  #    if !@collaborators.include?(user)
  #      @users << user
  #    end
  #  end
    @users = User.all - @collaborators
  end

  def add_users
    @gathering = Gathering.find(params[:id])
    @user = User.find_by(name: params[:user][:name])
    @gathering.users << @user
    redirect_to @gathering
  end

  def remove_users
    user = User.find(params[:user])
    @gathering = Gathering.find(params[:id])
    if user == current_user
      @gathering.users.delete(user)
      redirect_to gatherings_path
    else
      @gathering.users.delete(user)
      redirect_to @gathering
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
    # binding.pry
    respond_to do |format|
      if @gathering.update(gathering_params)
        format.html { redirect_to @gathering, notice: 'Gathering was successfully updated.' }
        format.json { render :show, status: :ok, location: @gathering }
      else
        format.html { render :edit }
        format.json { render json: @gathering.errors, status: :unprocessable_entity }
      end
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
end
