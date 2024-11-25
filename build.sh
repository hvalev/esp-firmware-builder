#!/bin/bash
git submodule update --init --recursive --progress ./libs
git submodule update --init --recursive --progress ./micropython 
docker run --rm -v $HOME:$HOME -u $UID -w $PWD/micropython hvalev/esp-open-sdk make -C mpy-cross
cp ./libs/micropython-mqtt/mqtt_as/mqtt_as.py "./micropython/ports/esp8266/modules/mqtt_as.py"
cp ./libs/MicroPython_Statistics/statistics.py "./micropython/ports/esp8266/modules/statistics.py"
cp ./libs/hamqa/hamqa/hamqa_mpy.py "./micropython/ports/esp8266/modules/hamqa.py"
cp ./libs/hx711/hx711_gpio.py "./micropython/ports/esp8266/modules/hx711.py"
docker run --rm -v $HOME:$HOME -u $UID -w $PWD/micropython/ports/esp8266 hvalev/esp-open-sdk make -j BOARD=ESP8266_GENERIC
cp ./micropython/ports/esp8266/build-ESP8266_GENERIC/firmware.* ./
