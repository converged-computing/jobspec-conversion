#!/bin/bash
#FLUX: --job-name=muffled-mango-2250
#FLUX: --priority=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
module swap intel pgi
module load mpi/pgi_openmpi
mpirun -n $SLURM_NTASKS singularity exec -B /local $SINGULARITY_CONT \
	python /ocean/projects/phy210030p/akshay2/HPC_pulsar/executables/accelsearch_sift_fold.py \
       -i /ocean/projects/phy210030p/akshay2/HPC_pulsar/config/accel.cfg
