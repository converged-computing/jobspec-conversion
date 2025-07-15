#!/bin/bash
#FLUX: --job-name=outstanding-caramel-4943
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/monailabel/ docker://projectmonai/monailabel:latest
