#!/bin/bash
#FLUX --job-name=expensive-lemon-7540
#FLUX --queue=gpu
#FLUX -t=60
#FLUX --urgency=16

module load nvidia/nvhpc
./a.out
