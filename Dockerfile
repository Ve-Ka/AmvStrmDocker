FROM node:19-alpine AS BUILDER
ARG HostIp 127.0.0.1
ENV API_URL=$HostIp
ENV WEB_ROOT=/app/AmvStrmV1
RUN apk add --no-cache git curl
RUN curl -sf https://gobinaries.com/tj/node-prune | sh
WORKDIR /app
RUN git clone https://github.com/Ve-Ka/AmvStrmV1
WORKDIR $WEB_ROOT
RUN cp .env.example .env
RUN find .  -type f -exec sed -i 's/\r$//' {} +
RUN npm install -g nuxt
RUN npm install --verbose
RUN npm run build
RUN rm -rf .git .github .gitignore .vscode LICENSE README.md
RUN node-prune node_modules
RUN chmod -R 777 .

FROM node:19-alpine
ENV WEB_ROOT=/app/AmvStrmV1
COPY entry.sh /entry.sh
RUN chmod u+x /entry.sh
RUN mkdir /app
RUN mkdir $WEB_ROOT
WORKDIR $WEB_ROOT
COPY --from=BUILDER $WEB_ROOT .
EXPOSE 80
CMD /entry.sh
