#!/bin/bash
#FLUX: --job-name=wobbly-onion-7229
#FLUX: --urgency=16

module load tacc-singularity
singularity run $SCRATCH/COVIRT19/singularity_cache/amazon.sif s3 sync s3://bucket_youwant/file $PWD --exclude "*human*" --endpoint-url=the_aws_region --profile your_profile
