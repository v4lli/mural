#!/bin/sh

# https://github.com/mapbox/mapbox-studio-classic/issues/1024

set -x

mkdir -p final/

#whole
#wget "http://localhost:3000/static/16/11.535,48.078,11.6716,48.2191@2x.png?id=tmstyle:///mural_gh.tm2" -O final/2.png

rm -f final/top.png final/bottom.png || true

#bottom
wget "http://localhost:3000/static/16/11.535,48.078,11.6716,48.1482@3x.png?id=tmstyle:///mural_gh.tm2" -O final/bottom.png

#top
wget "http://localhost:3000/static/16/11.535,48.1482,11.6716,48.2191@3x.png?id=tmstyle:///mural_gh.tm2" -O final/top.png

mv final/final.png "final/$(date).png"
convert final/top.png final/bottom.png -append final/final.png
rm -f final/top.png final/bottom.png
