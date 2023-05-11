#!/bin/sh

# npm run build only if the API_URL is changed
if [ -n "$API_URL" ] && ! (cat $WEB_ROOT/.env | sed 's/API_URL=//' | grep -xq $API_URL); then
    sed -i "s@API_URL.*.@API_URL=$API_URL@" $WEB_ROOT/.env
    npm run build -- $WEB_ROOT
fi

exec npm start
