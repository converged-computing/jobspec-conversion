#!/bin/bash
#FLUX --job-name=adorable-gato-8703
#FLUX -c=40
#FLUX --queue=gputest
#FLUX -t=900
#FLUX --urgency=16

module purge
module load pytorch
srun singularity_wrapper exec deepspeed mnist_deepspeed.py --epochs=100 \
     --deepspeed --deepspeed_config ds_config.json
