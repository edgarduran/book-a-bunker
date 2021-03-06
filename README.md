[Project Outline](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/the_pivot.md)

# Book-A-Bunker
## Built with Ruby on Rails

### Authors
[Greg Armstrong](https://github.com/GregoryArmstrong), [Edgar Duran](https://github.com/edgarduran), [Penney Garrett](https://github.com/PenneyGadget)

![Denver Bunker](/app/assets/images/bunker-screenshot.png)


This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io) to complete the "Pivot" project.

The original version of this project, the legacy codebase it began with, can be found [here](https://github.com/brantwellman/Turing-zombie-survival-store).

### Overview

This application is a parody of Air BnB where a user can book a bunker and have a place to sleep in a post-apocalypse world. The user can choose a bunker by location or store, choose the number of nights they desire, and pay for their booking via Stripe payment.

### Live Version

Book-A-Bunker is hosted live on Heroku [here](https://book-a-bunker.herokuapp.com).

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `https://github.com/edgarduran/book-a-bunker.git`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with bunkers, stores, store admins, orders, and users.
    - If you would like to create your own bunkers, stores, orders, and users do not run `db:seed`
    - The seed file does not include any setup for a platform administrator, so those must be created manually by running `rails c` and adding a user to the database with the role name of "platform_admin"
  5. Run the application in the dev environment by running `rails s`

### Test Suite

The test suite tests the application on multiple levels. To run all of the tests, run `rake test` from the terminal in the main directory of the project.
The project also utilizes the [Simplecov gem](https://github.com/colszowka/simplecov) for quick statistics on code coverage.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
