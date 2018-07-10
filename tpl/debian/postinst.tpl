#!/bin/bash

echo 'Set permissions'
chown w3data:w3data -R /usr/share/{{ project_name }}-{{ project_version }}
chown w3data:w3data -R /var/www/letsgo

chmod 755 /usr/share/{{ project_name }}-{{ project_version }}
chmod 755 /var/www/letsgo

#set new symlink
ln -sfnd /usr/share/{{ project_name }}-{{ project_version }}/* /var/www/letsgo

touch /var/log/uwsgi.log
touch /var/log/uwsgi-letsgo.log
touch /var/log/tornado-letsgo.log

chown w3data:w3data /etc/uwsgi/letsgo.yaml
chown w3data:w3data /var/log/uwsgi.log
chown w3data:w3data /var/log/uwsgi-letsgo.log
chown w3data:w3data /var/log/tornado-letsgo.log

echo 'Start migrations new'
su w3data -c "/var/www/letsgo/env/bin/python /var/www/letsgo/manage.py migrate"

echo 'Restart services'
service nginx restart
su w3data -c "touch /etc/uwsgi/letsgo.yaml"
echo 'uwsgi conf file was touched'
