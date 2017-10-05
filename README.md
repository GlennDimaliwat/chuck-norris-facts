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


## Features
- Create/Edit/Delete Chuck Norris Facts (with Shrine photo upload)
- View all Chuck Norris Facts
- Vote for a Chuck Norris Fact
- Show a Random Chuck Norris Fact
- View Top 10 Voted Chuck Norris Facts