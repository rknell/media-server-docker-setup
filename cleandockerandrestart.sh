docker kill $(docker ps -q)
docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -q)
docker volume ls -qf dangling=true | xargs -r docker volume rm
docker-compose up &