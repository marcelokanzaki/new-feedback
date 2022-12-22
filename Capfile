require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
require "capistrano/asdf"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano/passenger"
require "capistrano/dotenv/tasks"
require "capistrano/yarn"

install_plugin Capistrano::SCM::Git

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
