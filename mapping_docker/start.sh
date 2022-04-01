docker run -it  \
    --add-host=fetch37:192.168.88.11 \
    --add-host=localPC:192.168.88.10 \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --gpus all \
    dockerv1 \
    bash
