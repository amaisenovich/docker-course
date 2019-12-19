FROM node:alpine AS builder

WORKDIR /builder

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine

WORKDIR /app
EXPOSE 80
COPY --from=builder /builder/build /usr/share/nginx/html
