#!/bin/bash
#FLUX: --job-name=gpu
#FLUX: -t=900
#FLUX: --priority=16

export SLURM_EXPORT_ENV='ALL'
export SINGULARITYENV_LD_LIBRARY_PATH='${OLD_PATH}:${LD_LIBRARY_PATH}'

export SLURM_EXPORT_ENV=ALL
module load Singularity CUDA
SIF=${SIFPATH}/gromacs_2018.2.sif
SINGULARITY="$(which singularity) exec --nv -B ${PWD}:/host_pwd \
  -B /cm/local/apps/cuda -B ${EBROOTCUDA} --pwd /host_pwd ${SIF}"
OLD_PATH=$(${SINGULARITY} printenv | grep LD_LIBRARY_PATH | awk -F= '{print $2}')
export SINGULARITYENV_LD_LIBRARY_PATH="${OLD_PATH}:${LD_LIBRARY_PATH}"
srun ${SINGULARITY} \
    gmx grompp -f pme.mdp
srun ${SINGULARITY} \
    gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 1000 -s topol.tpr -ntomp 1
