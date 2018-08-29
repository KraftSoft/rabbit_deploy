#!/bin/sh
PROJECT=$1
VERSION=$2

PRJ_ROOT="main/usr/share/${PROJECT}-${VERSION}"
PRJ_LOCATION=""

find main/usr/share -type d -name "${PROJECT}*" -exec rm -rf {} +

mkdir -p $PRJ_ROOT

pip install -r requirements.txt
python ../manage.py migrate

if [ $? -eq 0 ]; then
    echo "OK"
else
    echo "Check your tests."
    exit 1
fi

python ../manage.py collectstatic --noinput

rsync -av ../.meta/ "$PWD/main"
rsync -av ../* $PRJ_ROOT --exclude=.git/ --exclude=.idea/ --exclude='*.pyc' --exclude='*.pyo' --exclude='__pycache__' --exclude=uploads/ --exclude=.meta/ --exclude=deploy_tools --exclude 'env*' 
#--exclude 'core/migrations/*' --exclude 'chat/migrations/*' --exclude 'location/migrations/*' --exclude 'tags/migrations/*'

rsync -av ../env $PRJ_ROOT

echo "/tmp/${PROJECT}-${VERSION}.deb"
fakeroot dpkg-deb --build "$PWD/main" /tmp/${PROJECT}-${VERSION}.deb

scp /tmp/${PROJECT}-${VERSION}.deb  deployer@80.87.201.72:/home/deployer/builds/
