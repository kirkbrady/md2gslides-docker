if [ -z $1 ]; then
    SLIDEFILE=slides.md
    echo "slidefile is ${SLIDEFILE}"
else
    SLIDEFILE=$1
    echo "slidefile is ${SLIDEFILE}"
fi

docker build . -t md2gslides -t ${SLIDEFILE} --build-arg SLIDEFILE=${SLIDEFILE}