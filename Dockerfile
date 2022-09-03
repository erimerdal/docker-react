FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build needs to be copied over
FROM nginx:1.23.1 as runner
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html