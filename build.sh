#!/bin/bash

# Move to the folder where the script is located, so as to avoid issues with missing files
cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)

Help() {
    # Display Help
    echo "Builds the image kaylebor/eclipse.jdt.ls"
    echo
    echo "Syntax: ./build.sh [OPTIONS] TAG_VERSION"
    echo "options:"
    echo "-h | --help     Prints this help message."
    echo "--no-cache      Builds without cache"
    echo "--latest        Tags resulting image as latest"
    echo
}

IMAGE_NAME=kaylebor/eclipse.jdt.ls
while (( "$#" )); do
    case "$1" in
        -h|--help)
            # Display Help
            Help
            exit 0
            ;;
        --latest)
            TAG_LATEST="-t $IMAGE_NAME:latest"
            shift
            ;;
        --no-cache)
            NO_CACHE="--no-cache"
            shift
            ;;
        *)
            [[ -z $TAG_VERSION ]] && TAG_VERSION="-t $IMAGE_NAME:$1"
            shift
            ;;
    esac
done

if [[ -z $TAG_VERSION ]]; then
    echo "Missing TAG_VERSION argument"
    Help
    exit -1
fi

docker build $NO_CACHE $TAG_VERSION $TAG_LATEST .