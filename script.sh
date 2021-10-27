
# Instalasi server rocketchat
sudo snap install rocketchat-server

# Konfigurasi open port http dan https
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 443 -j ACCEPT


# Instalasi Nginx untuk Forward Public

sudo apt-get install nginx -y

# Setup nginx
sudo nano /etc/nginx/conf.d/rocketchat.conf


###################################### copy file berikut
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


