#!/bin/bash
#FLUX --job-name=grated-kerfuffle-7470
#FLUX --queue=gpu
#FLUX -t=60
#FLUX --urgency=16

module load nvidia/nvhpc
./a.out
