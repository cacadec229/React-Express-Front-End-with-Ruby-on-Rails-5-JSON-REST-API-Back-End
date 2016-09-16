# React Express Front-End with Ruby on Rails 5 JSON REST API Back-End

This project consist of two separate applications that communicates through
a JSON REST API with each other.
The back-end application that serves the JSON REST API is based on Ruby on
Rails 5 with Puma as web server.
The front-end application that displays and adds comments is built with React
and uses Express as web server.

## Install and start Ruby on Rails 5 JSON REST API Back-End server

First you need to install Ruby, Rails 5 as well as Postgresql as database.
Follow the steps on: https://gorails.com/setup/ubuntu/16.04 but when choosing
Rails version manually choose Rails 5.0.0.1 or later. Install Git too if you
plan to build the applications from scratch.

Install dependencies
```sh
cd ./backend
bundle install
```

Set up the database
```sh
rails db:migrate:reset
```

Start Puma web server
```sh
rails s
```

The back-end Rails 5 JSON REST API server should now run on port 3000 and you
can find the empty comments array on http://localhost:3000/comments

## Install and start React Express Front-End server
Install dependencies
```sh
cd ./frontend
npm install
```

Start Express web server
```sh
npm start
```

You can now access the Express server on http://localhost:3001/ that serves
all the comments from the Rails back-end. Start adding comments and you can
find them both on the front-end http://localhost:3001/ and back-end
http://localhost:3000/comments

## Building the Rails 5 Back-End from scratch
Start a new Rails 5 project
```sh
rails new backend -d postgresql --api
cd backend
```

Enable CORS in ./Gemfile by uncommenting
```sh
gem 'rack-cors'
```

In ./config/initializers/cors.rb add
```sh
Rails.application.config.middleware.insert_before 0, "Rack::Cors" do
  allow do
    origins 'localhost:3000'
    resource '*',
      headers: :any,
      methods: %i(get post put patch delete options head)
  end
end
```

Install dependencies
```sh
bundle install
```

Add Comment model and controller with fields author and text
```sh
rails g scaffold Comment author:string text:text
```

Set up the database
```sh
rails db:migrate:reset
```

In ./app/controllers/comments_controller.rb remove require
```sh
def comment_params
  params.permit(:author, :text)
end
```

Start Puma web server
```sh
rails s
```

Congratulations you just set up a JSON REST API!

## Building React Express Front-End from scratch, kind of :)

We are using Facebook's React tutorial
```sh
git clone https://github.com/reactjs/react-tutorial frontend
cd frontend
```

Install dependencies
```sh
npm install
```

Change the Express server's port to 3001 in ./server.js
```sh
app.set('port', (process.env.PORT || 3001));
```

Change the API url in ./public/scripts/example.js
```sh
<CommentBox url="http://localhost:3000/comments" pollInterval={2000} />,
```

You can also comment out the following line as ID is set by Rails
```sh
//comment.id = Date.now();
```

Start Express web server and start adding comments
```sh
npm start
```

Congratulations you now have a separate back and front-end that are talking
to each other!
