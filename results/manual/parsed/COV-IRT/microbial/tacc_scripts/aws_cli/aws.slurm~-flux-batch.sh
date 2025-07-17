#!/bin/bash
#FLUX: --job-name=COVIRT-aws_microbe
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

module load tacc-singularity
singularity run ../../singularity_cache/amazon.sif s3 sync s3://nasa-covid $PWD --exclude "*human*" --endpoint-url=https://s3.wasabisys.com --profile wasabi
