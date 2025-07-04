# Build frontend
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Start backend
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY --from=build /app/dist /app/dist
EXPOSE 8080
CMD ["node", "src/server/index.js"]