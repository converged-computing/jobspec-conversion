#!/bin/bash
#FLUX: --job-name=JDAHFpEF
#FLUX: -n=10
#FLUX: --queue=cpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load mpi/openmpi-x86_64
mpirun singularity exec /home/s4657117/HCM-project/SingularitY/hcm-project.img python Python_filename.py
