# Chuck Norris Facts

## Challenge
- Work in pairs
- Choose something you can collect that you like
- Create ERDs for the models (model names and attributes)
- Create a new Rails app
- Add Rspec and Bootstrap
- Create the model with spec and validations
- Use Bootstrap to style the app

## ERD
![erd database](/docs/images/erd.png)


## Model
### Fact
- id - integer
- fact - text
- image_data - string

### Vote
- id - integer
- fact_id - Fact