#!/bin/bash
#FLUX: --job-name=PROJECT_2
#FLUX: --queue=c1exp
#FLUX: -t=5400
#FLUX: --urgency=16

module load mpi4py
mpirun -n 28 singularity exec --bind /groups --bind /lustre /groups/dats6402_10/images/python-3.7.0+ompi.simg python3 code.py
