FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx 
COPY package.json .
RUN apt-get update && apt-get install -y npm
COPY --from=builder /app/build /usr/share/nginx/html