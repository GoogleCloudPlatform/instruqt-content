FROM node:alpine
ADD package.json package.json
RUN npm install
ADD index.js index.js
EXPOSE 3000
CMD npm start