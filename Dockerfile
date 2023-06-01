FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx 
WORKDIR '/app'
COPY package.json .
npm i -g npm 
rm -rf node_modules/ && npm cache clean
npm install
COPY --from=builder /app/build /usr/share/nginx/html