class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params.merge({
      gathering_id: params['gathering_id'], user_id: current_user.id }))
    gathering = Gathering.find(params['gathering_id'])

    respond_to do |format|
      if comment.save
        format.html { redirect_to gathering, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: gathering }
      else
        format.html {
          # TODO: move this multiple-error logic to the layout
          flash.now[:error] = comment.errors.messages.map { |msg| "<li>#{msg}</li>"}.join('')
          render 'gatherings/show'
        }
        format.json { render json: gathering.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
