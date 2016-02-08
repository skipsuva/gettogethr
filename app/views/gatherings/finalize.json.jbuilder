json.moment @gathering.finalized_plan.moment.time.strftime('%_m/%-d/%y at %l:%M %P') if @gathering.finalized_plan.moment
json.activity @gathering.finalized_plan.activity.try(:description)
json.activity_category @gathering.finalized_plan.activity.try(:activity_category) if @gathering.finalized_plan.activity
json.place @gathering.finalized_plan.place.try(:name)
