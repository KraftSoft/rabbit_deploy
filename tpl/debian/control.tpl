Package: {{ project_name }}
Version: {{ project_version }}
Maintainer: Ilia Kravtsov <kravcov2512@gmail.com>
Architecture: all
Section: web
Description: API web server
 API web server for letsgo client applications.
Build-Depends: debhelper (>= 7)
Depends: nginx,postgresql-9.4,postgresql-9.4-postgis-2.1,postgis-doc,postgresql-9.4-postgis-scripts,postgresql-client-9.4,postgresql-client-common,postgresql-common,postgresql-contrib-9.4,uwsgi,uwsgi-core,uwsgi-plugin-python3,redis-server
Replaces: nginx
