#!/bin/bash
#FLUX: --job-name=ntm_battery
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load intel/19.1.2
module load openmpi/intel/4.1.1
cd ../
cd $SLURM_ARRAY_TASK_ID
srun /scratch/mk8347/newlammps/src/lmp_mpi -in run_MD.lmp -screen screen.log
