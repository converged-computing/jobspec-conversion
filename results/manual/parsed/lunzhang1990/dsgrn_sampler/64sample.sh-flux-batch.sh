#!/bin/bash
#FLUX --job-name=astute-kerfuffle-5882
#FLUX --queue=main
#FLUX -t=604800
#FLUX --urgency=16

cd $PWD
module load py3-numpy/1.14.3 py3-scipy/1.1.0
srun python3 samplerun.py 64 64prec3.dat  
