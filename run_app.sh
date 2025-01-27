# Pull the latest changes from the GitHub repository
git pull origin master

# Remove all running and stopped containers
docker container rm -f $(docker container ls -a -q)

# Remove all unused Docker images
docker image rm -f $(docker image ls -a -q)

# Stop and remove the current Docker Compose stack for SSL creation (if running)
docker-compose -f docker-compose-create-ssl.yml down

# Stop and remove the current Docker Compose stack for production (if running)
docker-compose -f docker-compose-prod-ssl.yml down

# Build and start the production Docker Compose stack
# Removes unused Docker volumes.
# Removes all unused build cache data.
# Removes all dangling and unused Docker images.
# Removes all stopped containers.
# Removes all unused Docker networks.
docker-compose -f docker-compose-prod-ssl.yml up --build -d && docker volume prune -f && docker builder prune -a -f && docker image prune -a -f && docker container prune -f && docker network prune -f