FROM node:18-alpine as BUILD_IMAGE

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine as PRODUCTION_IMAGE

WORKDIR /app/react-app

COPY --from=BUILD_IMAGE /app/dist/ /app/react-app/dist/

EXPOSE 8765 
COPY package.json .
COPY vite.config.js .

# RUN npm install typescript
RUN npm install vite -D

EXPOSE 8765 

CMD ["npm", "run", "preview"]

# docker compose up -d --no-deps --build

# docker build -t vite-react-portfolio:latest .

# docker run -p 8765:8765 vite-react-portfolio:latest