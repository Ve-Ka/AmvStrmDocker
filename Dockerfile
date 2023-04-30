FROM node:alpine
RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/amvstrm/amvstrm.git
WORKDIR /app/amvstrm
#RUN echo 'API_URL=https://api.amvstr.ml/' > .env
RUN echo 'API_URL=http://10.104.0.3:1007/' > .env
RUN npm install -g nuxt
RUN npm install
RUN npm run build
EXPOSE 80
CMD npm start
