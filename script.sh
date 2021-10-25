sudo snap install rocketchat-server


sudo snap set rocketchat-server caddy-url=https://<your-domain-name>
sudo snap set rocketchat-server caddy=enable
sudo snap set rocketchat-server https=enable
sudo snap run rocketchat-server.initcaddy

sudo systemctl restart snap.rocketchat-server.rocketchat-server.service
sudo systemctl restart snap.rocketchat-server.rocketchat-caddy.service



sudo apt-get install nginx -y

######################################
upstream rocketchat {
server 127.0.0.1:3000;
}

server {
listen 80;
server_name test.example.com;
access_log /var/log/nginx/test.example.com-access.log;
error_log /var/log/nginx/test.example.com-error.log;

location / {
    proxy_pass http://rocketchat/;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $http_host;

    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forward-Proto http;
    proxy_set_header X-Nginx-Proxy true;

    proxy_redirect off;
}
}
###############################################


sudo nginx -t

sudo systemctl restart nginx


