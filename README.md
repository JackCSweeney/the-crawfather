# The Crawfather

### What even is this?
To put it frankly, a kind of stupid idea, but one that has let me play around and learn some different tools and concepts in a fun environment! The Crawfather is, for now, a simple chat bot utilizing OpenAI's ChatGPT that will give you pretty bad fantasy football advice, with a shrimpy, criminal twist. The idea for this came from a chat bot, called "Crow Daddy", from a dynasty fantasy football league I'm a part of and a very strange dream in which "Crow Daddy" was replaced with a mobster, powered by shrimp-based AI. I have yet to figure out what that means exactly, but I guess this is my way of figuring that out. Regardless, it's been a fun little process of pulling this together and learning some new skills I haven't had the chance to utilize in other projects/work. Who knew it would so hard to make ChatGPT respond as shrimpy as I wanted?

### How do I make it work?
Here's what you'll need to do to run this locally:
- Fork and clone this repository (or just clone it) to your local machine
- Open it in the IDE of your choosing
- Run `bundle install` to install all necessary gems
- Create a `.env` file in the root directory
- Visit OpenAI to get an API key that works with ChatGPT
- In the `.env` file add the line `OPEN_AI_API_KEY=<your_api_key_here>` with your personal API key
- Make sure you have postgreSQL installed on your computer
- Run `rails db:{create,migrate}` to create the database and run the migrations
- Run `rails s` to boot up your locally hosted version of the web app
- Visit `http://127.0.0.1:3000` in your browser and start playing around

### Versioning
- Ruby 3.1.4
- Rails 7.1.3.4

### Database Schema
- Users Table
  - id
  - name
  - email
  - password_digest
  - credits (default value of 5)
  - roundup_status (enumerable to tell if someone has opted in or out of roundup emails of their recent questions)

- Questions Table
  - id
  - question
  - response
  - user_id (foreign key to the user that asked the question)