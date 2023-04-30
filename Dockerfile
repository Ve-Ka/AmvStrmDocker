FROM node:alpine
RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/amvstrm/amvstrm.git
WORKDIR /app/amvstrm
RUN echo 'API_URL=https://api.amvstr.ml/' > .env
RUN npm install -g nuxt
RUN npm install --omit=dev
RUN npm run build
EXPOSE 80
CMD npm start
