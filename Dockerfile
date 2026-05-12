# base Image
FROM node:20-alpine As build

# set working directory
WORKDIR /app

#copy package.json and package-lock.json
COPY package*.json ./

# install dependencies
RUN npm install

# copy the rest of the application code
COPY . .   
Run npm run build 

#Runtime stage
From nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

# expose the port the app runs on
EXPOSE 80

# start the application
CMD ["nginx","-g", "daemon off;"]

