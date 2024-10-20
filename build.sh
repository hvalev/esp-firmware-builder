#!/bin/bash
git submodule update --init --recursive --progress ./libs
git submodule update --init --recursive --progress ./micropython 
docker run --rm -v $HOME:$HOME -u $UID -w $PWD/micropython hvalev/esp-open-sdk make -C mpy-cross
cp ./libs/micropython-mqtt/mqtt_as/mqtt_as.py "./micropython/ports/esp8266/modules/mqtt_as.py"
cp ./libs/MicroPython_Statistics/statistics.py "./micropython/ports/esp8266/modules/statistics.py"
docker run --rm -v $HOME:$HOME -u $UID -w $PWD/micropython/ports/esp8266 hvalev/esp-open-sdk make -j BOARD=ESP8266_GENERIC
