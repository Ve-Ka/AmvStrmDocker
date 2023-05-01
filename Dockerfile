FROM node:alpine AS BUILD_IMAGE
RUN apk add --no-cache git curl
RUN curl -sf https://gobinaries.com/tj/node-prune | sh
WORKDIR /app
RUN git clone https://github.com/amvstrm/amvstrm.git
WORKDIR /app/amvstrm
RUN echo 'API_URL=https://api.amvstr.ml/' > .env
RUN find .  -type f -exec sed -i 's/\r$//' {} +
RUN npm install -g nuxt
RUN npm install --verbose
RUN npm run build
RUN rm -rf .git .github .gitignore .vscode LICENSE README.md
RUN node-prune node_modules

FROM node:alpine
RUN mkdir /app
RUN mkdir /app/amvstrm
WORKDIR /app/amvstrm
COPY --from=BUILD_IMAGE /app/amvstrm .
RUN chmod -R 777 .
EXPOSE 80
CMD npm start
