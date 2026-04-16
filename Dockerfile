# base Image
FROM node:20-alpine

# set working directory
WORKDIR /app

#copy package.json and package-lock.json
COPY package*.json ./

# install dependencies
RUN npm install

# copy the rest of the application code
COPY . .   

# expose the port the app runs on
EXPOSE 3000

# start the application
CMD ["node", "app.js"]

