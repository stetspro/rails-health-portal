# CanPulse

![CanPulse Logo](./app/assets/images/favsymbol.png)

CanPulse is a personal health portal, built with Ruby on Rails, designed to facilitate better patient-doctor interactions and management in small hospitals or family doctor settings. The project integrates front-end technologies such as ERB for HTML templating, Sass for styling, and JavaScript for dynamic client-side behavior, with back-end Ruby on Rails MVC framework. PostgreSQL is used as the database with ActiveRecord acting as the ORM layer.

## Features

### For Patients:

- View medical data, appointment times, and past diagnoses on the dashboard.
- Schedule new appointments, select preferred doctor, and view detailed information about medications.
- See the new appointment, medication, and diagnosis details updated in real time on the dashboard.
- Book a follow-up appointment suggested by the AI after a chronic diagnosis.

### For Doctors:

- Access daily patients' details, create a diagnosis form, see expired and current medications, and manage chronic disease data.
- Interact with OpenAI's API, providing a suggested date for the next appointment based on the diagnosis data.
- Manage daily patient appointments with a view of all scheduled appointments for the day.

## Technologies

- Ruby on Rails (Version: 6.1.5)
- Ruby (Version: 3.1.1)
- PostgreSQL
- ERB (Embedded Ruby)
- Sass
- JavaScript
- jsCalendar API
- OpenAI API

And JavaScript packages:

- @rails/actioncable (Version: 6.0.0)
- @rails/activestorage (Version: 6.0.0)
- @rails/ujs (Version: 6.0.0)
- simple-jscalendar (Version: 1.4.4)
- turbolinks (Version: 5.2.0)
- webpack (Version: 4.46.0)
- webpack-cli (Version: 3.3.12)

## Setup

System dependencies:

- Ruby (Version: 3.1.1)
- Rails (Version: 6.1.5)
- PostgreSQL
- Node.js
- Yarn

Before running the project, create a `.env` file in the project's root directory based on the `.env.example` file. Fill in your OpenAI access token and organization ID:

OPENAI_ACCESS_TOKEN=
OPENAI_ORGANIZATION_ID=


## Setup

To run this project, install it locally using bundle and yarn:

First, navigate to the project directory:

```shell
$ cd ../canpulse
```
Next, install the necessary Ruby gems:

```shell

$ bundle install
```
Then, install the necessary JavaScript packages:

```shell

$ yarn install
```
Now, create the PostgreSQL database:

```shell

$ rails db:create
```

After creating the database, migrate the database schema:

```shell

$ rails db:migrate
```
Finally, start the Rails server:

```shell

$ rails s -b 0.0.0.0
```

Then open your web browser and navigate to http://localhost:3000 to see the app in action.

## Configuration

Configuration settings can be found in the config folder of the Rails application.

## Database creation

This application uses PostgreSQL for data storage. After setting up the application, you can create the database with the `rails db:create` command, then migrate the database schema with `rails db:migrate`.

## Database initialization

No additional steps needed for database initialization as `rails db:migrate` takes care of it.

## Deployment instructions

Deployment is beyond the scope of this README. Please consult the official Rails guide on deployment or relevant documentation of your hosting provider for details on how to deploy a Rails application.

## Challenges

Staying within the chosen tech stack and avoiding easy solutions that would have necessitated a change in the tech stack was one of the biggest challenges. Some features, like managing appointment dates and times with the jsCalendar API, were particularly challenging due to confusing documentation and issues with data types. However, with perseverance and problem-solving, all features were successfully implemented.

## Acknowledgements

I would like to thank my mentor, [@WarrenUhrich](https://github.com/WarrenUhrich), for his invaluable help and guidance throughout the project. The experience of developing CanPulse has been a significant learning curve, further cementing understanding of MVC, Ruby, and Ruby on Rails.

