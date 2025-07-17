#!/bin/bash
#FLUX: --job-name=EEG_2_CoordsV
#FLUX: -N=14
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=prod
#FLUX: -t=86400
#FLUX: --urgency=16

spack env activate bluerecording-dev
source ~/bluerecording-dev/bin/activate
mkdir ../sscxSimulation/pkls
srun -n 420 python geteeg.py
