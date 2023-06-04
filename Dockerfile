FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the built application with Nginx
FROM node:16-alpine as runner
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/build .

#hi
FROM nginx 
COPY --from=runner /usr/share/nginx/html /usr/share/nginx/html