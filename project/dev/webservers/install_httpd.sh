#!/bin/bash
yum -y update
yum -y install httpd
sudo aws s3 cp s3://dev-acsproject/project.jpg /var/www/html/
sudo aws s3 cp s3://dev-acsproject/project2.jpg /var/www/html/
echo '<img src=project.jpg><div class="row">\n  <div class="column">\n    <img src="project.jpg">\n  </div>\n  <div class="column">\n    <img src="project2.jpg">\n  </div>\n</div>'   >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
