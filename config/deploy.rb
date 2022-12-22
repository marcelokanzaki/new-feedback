set :application, 'feedback'
set :repo_url, 'git@github.com:marcelokanzaki/new-feedback.git'
set :deploy_to, '/var/www/newfeedback'
set :keep_releases, 1
set :yarn_flags, '--production --silent --no-progress --ignore-engines'
set :branch, :main
append :linked_dirs, '.bundle'

append :linked_files, '.env'

namespace :deploy do
  namespace :symlink do
    after :linked_dirs, :symlink_uploads do
      on roles(:web) do
        execute :ln, '-s', '/home/sicoob/uploads', "#{release_path}/public/uploads"
      end
    end
  end
end
