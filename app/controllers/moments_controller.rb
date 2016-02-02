class MomentsController < ApplicationController
  before_action -> { check_gathering_access(params['gathering_id'])}


  def create
    @moment = Moment.new(moment_params.merge({
      gathering_id: params['gathering_id'] }))
    @gathering = Gathering.find(params['gathering_id'])
    respond_to do |format|
      if @moment.save
        format.html { redirect_to @gathering, notice: 'Moment was successfully created.' }
        format.json { render :show, status: :created, location: @gathering }
        format.js { }
      else
        format.html {
          flash.now[:error] = 'Time ' + @moment.errors.messages[:time].join(", ")
          render 'gatherings/show'
        }
        format.json { render json: @gathering.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # TODO: need to add any contingencies for destroying associated votes as well?  Not a concern?
    binding.pry
    @gathering = Gathering.find(params[:gathering_id])
    @moment_id = Moment.find(params[:id]).id
    Moment.find(params[:id]).destroy
    respond_to do |format|
      format.html {redirect_to @gathering}
      format.js { }
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def moment_params
    params.require(:moment).permit(:time)
  end
end
