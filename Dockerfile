FROM node:latest as build
WORKDIR /app
COPY  package.json ./
RUN npm install 
COPY . .
RUN npm run build


FROM nginx:latest as prod-stage
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]