#!/bin/bash
#FLUX: --job-name=vae
#FLUX: -c=3
#FLUX: -t=144000
#FLUX: --urgency=16

module load cuda80/toolkit prun
module load opencl-nvidia/8.0
for PRIOR in 'mog'
do
    srun python -u /home/igatopou/projects/vae/main.py --prior $PRIOR
done
