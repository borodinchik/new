FROM nginx:latest

COPY devops/nginx-dev/config/default.conf.tpl /etc/nginx/conf.d/default.conf.tpl
COPY devops/nginx-dev/boot.sh /usr/local/bin/nginx_boot

CMD ["sh", "/usr/local/bin/nginx_boot"]