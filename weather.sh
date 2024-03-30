#!/bin/bash
# View weather report/forecast for a specified location

PROGRAM_NAME=weather
VERSION=1.0
YEAR=2022
DEVELOPER=Lilian

case $1 in
    -h | --help)
        echo "$PROGRAM_NAME $VERSION"
        echo "Copyright $YEAR $DEVELOPER. All rights reserved."
        echo
        echo "Usage: weather [options]"
        echo "Option    Long Option     Description"
        echo "-h        --help          Display this help message"
        echo "-l        --location      Display the current weather for given location"
        ;;
        -l | --location)
        curl https://wttr.in/$2
        ;;
        *)
esac
