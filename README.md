# rails-app
Practice dockerized rails app with postgresql, redis, nginx, sidekiq, unicorn

# SOURCE:
https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application

# PREREQUISITE:
for windows OS:
    a) WSL2 installed
    b) docker desktop installed

for UNIX systems:
    a) docker installed

# INITIAL SETUP:
1) Create .env file: `cp env-example .env`
2) Build environment: `docker compose up --build`
3) Create schema 
    a) `docker compose run drkiq rake db:reset`
    b) `docker compose run drkiq rake db:migrate`

# START CONTAINERS:
 `docker compose up`

# LIST ACTIVE CONTAINERS
`docker ps`

# STOP CONTAINERS:
`docker compose stop` or `CTRL+C` if containers started as daemon

# SSH IN CONTAINERS to run rails commands:
`docker exec -it "container_hash" bash` or use `make ssh` to

# RUNNING RAILS SPECIFIC COMMANDS:
`docker compose run "container_tag" rails ...` or use `make ssh` to bash into app container and run commands from there
[still having some issues here, generated files are owned by `root` user, must be owned by current user `chown $USER:$USER <filename>` or `chown -R $USER:$USER <dirname>]