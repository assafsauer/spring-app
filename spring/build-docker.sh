#!/bin/sh

script_path=$(dirname "$0")
docker build -t index.docker.io/beenotice/spring:0.0.1-SNAPSHOT $script_path/
