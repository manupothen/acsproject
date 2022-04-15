#!/bin/bash
yum -y update
yum -y install httpd
sudo aws s3 cp s3://staging-acsproject-group25/project.jpg /var/www/html/
sudo aws s3 cp s3://staging-acsproject-group25/project2.jpg /var/www/html/
echo '<h1>Group 25. Group members: Manu Pothen, Rosemary Sebastian, Bibin Mekkattukunnil Biju</h1> <img src=project.jpg> <img src=project2.jpg>'   >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
