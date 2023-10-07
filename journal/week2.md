# Terraform Beginner Bootcamp 2023 - Week 2

## Working with ruby 

### Bundler

Bundler is a package manager for ruby . It is the primary way to install ruby packages (Known as GEMS) for ruby.

#### Install Gems

you need to create a GemFIle and define your gems in the file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'

```

Then you need to run the `bundle install` command 

This will install the gems on the system globally (unlike nodejs which install packages in a folder called node_modules)

A GemFile.lock will be created to lock down the gem version used in this project.

#### Executing Ruby Script In the Context of. ABundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed . This is the way we set Context.

#### Sinatra

Sinatra is a micro web framework for ruby to build we-apps.

Its great for mock or development servers or for very simple project.

You can create a web-server in a single file.

()[https://sinatrarb.com/]


## Teratowns Mock Web Server

### Running the web Server

we can run the we server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.



