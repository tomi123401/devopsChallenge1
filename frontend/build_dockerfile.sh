docker build . -t npm-frontend
docker tag npm-frontend:latest tomi12340/npm-frontend:latest
docker push tomi12340/npm-frontend:latest