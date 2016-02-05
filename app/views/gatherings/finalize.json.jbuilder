json.moment @plan.moment.time.strftime('%_m/%-d/%y at %l:%M %P')
json.activity @plan.activity.description
json.activity_category @plan.activity.activity_category.label
json.place @plan.place.name
