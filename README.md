# rails-app
Practice dockerized rails app with postgresql, redis, nginx, sidekiq, unicorn

# SOURCE:
https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application

# INITIAL SETUP:
1) Build rails toolbox: `docker build -t rails-toolbox -f Dockerfile.rails .`
2) Build environment: `docker compose up --build`

# START CONTAINERS:
 `docker compose up`

# STOP CONTAINERS:
`docker compose stop` or `CTRL+C` if containers started as daemon

# SSH IN CONTAINERS to run rails commands:
`docker exec -it "container_hash" bash`

# RUN COMMANDS outside containers:
`docker compose run "container_tag" rails ...`