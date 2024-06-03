#!/bin/bash
sleep 1m

sudo dnf install httpd -y

sudo systemctl enable httpd

sudo systemctl restart httpd

sudo firewall-cmd --add-service=http --permanent

sudo firewall-cmd --add-service=https --permanent

sudo firewall-cmd --reload

echo '<h1 style="font-size: 48px;">'$(hostname)'</h1>' | sudo tee -a /usr/share/httpd/noindex/index.html


