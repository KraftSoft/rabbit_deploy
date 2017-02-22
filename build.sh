
PROJECT=$1

if [[ $2 =~ ^[0-9]+\.[0-9]+\.[_.0-9a-z]+$ ]]; then
	VERSION=$2
else
	echo "Wrong version"
fi

PRJ_ROOT="usr/share/$PROJECT-$VERSION"

mkdir PRJ_ROOT

rsync -av --progress ../.meta/ "$PWD"
rsync -av --progress ../* $PRJ_ROOT --exclude=.git/ --exclude=.idea/ --exclude='*.pyc' --exclude='*.pyo' --exclude='__pycache__' --exclude=uploads/ --exclude=.meta/

