#!/bin/bash

echo 'Set permissions'
chown w3data:w3data -R /usr/share/{{ project_name }}-{{ project_version }}
chown w3data:w3data -R /var/www/rabbit

chmod 755 /usr/share/{{ project_name }}-{{ project_version }}
chmod 755 /var/www/rabbit

#set new symlink
ln -sfnd /usr/share/{{ project_name }}-{{ project_version }}/* /var/www/rabbit

touch /var/log/uwsgi.log
touch /var/log/uwsgi-rabbit.log

chown w3data:w3data /etc/uwsgi/rabbit.yaml
chown w3data:w3data /var/log/uwsgi.log
chown w3data:w3data /var/log/uwsgi-rabbit.log

echo 'Start migrations new'
su w3data -c "/var/www/rabbit/env/bin/python /var/www/rabbit/manage.py migrate"

echo 'Restart services'
service nginx restart
su w3data -c "touch /etc/uwsgi/rabbit.yaml"
echo 'uwsgi conf file was touched'
