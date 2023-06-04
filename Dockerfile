FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#hi
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=builder /usr/local/bin/npm /usr/local/bin/npm
COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
