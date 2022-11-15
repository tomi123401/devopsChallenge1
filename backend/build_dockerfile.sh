docker build . -t npm-backend
docker tag npm-backend:latest tomi12340/npm-backend:latest
docker push tomi12340/npm-backend:latest