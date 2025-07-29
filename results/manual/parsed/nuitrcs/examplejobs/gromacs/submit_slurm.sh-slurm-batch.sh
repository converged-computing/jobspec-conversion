#!/bin/bash
#FLUX: --job-name=sample_job
#FLUX: -N=2
#FLUX: --queue=short
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export GMX_MAXBACKUP='-1'
export jobname='1us-apo-NMDA-4PE5_v1'

module purge
module load gromacs/2020.4-openmpi-4.0.5-gcc-10.2.0
export OMP_NUM_THREADS=1
export GMX_MAXBACKUP=-1
export jobname="1us-apo-NMDA-4PE5_v1"
mpirun -np ${SLURM_NTASKS} gmx_mpi mdrun -s ${jobname}.tpr -cpi ${jobname}.cpt -deffnm ${jobname} -maxh 2 -noappend
