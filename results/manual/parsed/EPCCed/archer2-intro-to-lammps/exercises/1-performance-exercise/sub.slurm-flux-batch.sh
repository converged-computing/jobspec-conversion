#!/bin/bash
#FLUX: --job-name=lmp_ex1
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load lammps/23_Jun_2022
export OMP_NUM_THREADS=1
srun lmp -i in.ethanol -l ${SLURM_NPROCS}_cpus.log.${SLURM_JOB_ID}
