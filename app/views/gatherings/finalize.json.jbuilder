json.moment @gathering.finalized_plan.moment.time.strftime('%_m/%-d/%y at %l:%M %P')
json.activity @gathering.finalized_plan.activity.description
json.activity_category @gathering.finalized_plan.activity.activity_category.label
json.place @gathering.finalized_plan.place.name
