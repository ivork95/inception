FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install nginx -y

COPY ./src/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
