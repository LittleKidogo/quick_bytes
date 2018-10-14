# Start with a standard node
FROM node:8

# lets export port 80 from the container
expose 9090

# lets setup the enviroment variables
ENV REPLACE_OS_VARS=true \
    SHELL=/bin/bash


# copy files to use
COPY . .

# Install deps
RUN npm install --production 

# Run express and serve the app
CMD ["node", "server.js"]
