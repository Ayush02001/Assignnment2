# Use the node:19.7.0-alpine base image
FROM node:19.7.0-alpine

# Set the environment variable NODE_ENV with a value of production
ENV NODE_ENV=production

# Create a new directory in root called labone
RUN mkdir /labone && chown node:node /labone

# Set the new folder as the working directory
WORKDIR /labone

# Set the user to node
USER node

# Copy package.json and package-lock.json separately to take advantage of caching
COPY --chown=node:node package.json .
COPY --chown=node:node package-lock.json .

# Install node.js packages
RUN npm install

# Copy all source files and change the file ownership to the node user and node group
COPY --chown=node:node . .

# Expose port 3000
EXPOSE 3000

# Set the default execution command to node src/app.js
CMD ["node", "src/app.js"]