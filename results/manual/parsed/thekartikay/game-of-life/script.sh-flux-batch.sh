#!/bin/bash
#FLUX: --job-name=hanky-destiny-7907
#FLUX: --priority=16

module load mpi4py
mpirun -n 28 singularity exec --bind /groups --bind /lustre /groups/dats6402_10/images/python-3.7.0+ompi.simg python3 code.py
