#!/bin/bash
#FLUX: --job-name=672
#FLUX: -n=16
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module purge
module load intel/2019.1.144
module load openmpi/4.0.1
srun --mpi=pmix_v3 /home/joshuapaul/vasp_10-23-19_5.4.4/bin/vasp_stand > job.log
echo Done
