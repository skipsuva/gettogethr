class ActivityCategoriesController < ApplicationController
  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_category_params
    params.require(:activity_category).permit(:label)
  end
end
