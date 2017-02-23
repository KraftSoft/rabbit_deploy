
PROJECT=$1

if [[ $2 =~ ^[0-9]+\.[0-9]+\-[0-9]$ ]]; then
        VERSION=$2
else
	echo "Wrong version"
fi

PRJ_ROOT="main/usr/share/${PROJECT}-${VERSION}"

mkdir -p $PRJ_ROOT

rsync -av --progress ../.meta/ "$PWD/main"
rsync -av --progress ../* $PRJ_ROOT --exclude=.git/ --exclude=.idea/ --exclude='*.pyc' --exclude='*.pyo' --exclude='__pycache__' --exclude=uploads/ --exclude=.meta/ --exclude=deploy_tools

fakeroot dpkg-deb --build "$PWD/main" /tmp

