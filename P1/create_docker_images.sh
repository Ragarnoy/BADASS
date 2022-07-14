#!/bin/bash

docker build . -t host_1 -f host_fbenneto.dockerfile
docker build router -t router_1 -f router/router_fbenneto.dockerfile
