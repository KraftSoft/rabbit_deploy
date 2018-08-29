Package: {{ project_name }}
Version: {{ project_version }}
Maintainer: Ilia Kravtsov <kravcov2512@gmail.com>
Architecture: all
Section: web
Description: API web server
 API web server for learn rabbit client applications.
Build-Depends: debhelper (>= 7)
Depends: nginx,postgresql-10.5,postgresql-client-10.5,postgresql-client-common,postgresql-common,postgresql-contrib-10.5,python-psycopg2,libpq-dev,uwsgi,uwsgi-core,uwsgi-plugin-python3
Replaces: nginx
