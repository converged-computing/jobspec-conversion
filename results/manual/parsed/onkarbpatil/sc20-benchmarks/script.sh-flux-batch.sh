#!/bin/bash
#FLUX: --job-name=fat-egg-3392
#FLUX: -N=4
#FLUX: --queue=skylake-gold
#FLUX: -t=172800
#FLUX: --urgency=16

echo ${SLURM_JOB_NODELIST}
module unload
module load gcc/7.3.0 cmake openmpi/3.1.3-gcc_7.3.0 likwid
srun -w ${SLURM_JOB_NODELIST} -n 4 hostname
