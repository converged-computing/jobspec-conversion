#!/bin/bash
#FLUX: --job-name=astute-chip-7455
#FLUX: -t=240
#FLUX: --urgency=16

PMIX_MCA_psec=native srun -n 1 --mpi=pmix_v3 singularity run simsopt_v0.13.0.sif /venv/bin/python set_x0.py 
