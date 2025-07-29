#!/bin/bash
#FLUX --job-name=joyous-nunchucks-5981
#FLUX -c=8
#FLUX --queue=gpu
#FLUX -t=3600
#FLUX --urgency=16

module purge
module load nvidia-hpc-sdk
./async
