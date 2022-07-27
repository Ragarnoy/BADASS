#!/bin/bash

docker build . -t host -f host_fbenneto.dockerfile
docker build router -t router -f router/router_fbenneto.dockerfile
