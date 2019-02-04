#!/usr/bin/env Rscript

library(rredis)
# Set the host value to the service name for redis in the docker-compose file
redisConnect(host='redis')
redisSet('x',charToRaw('1'))
redisGet('x')
