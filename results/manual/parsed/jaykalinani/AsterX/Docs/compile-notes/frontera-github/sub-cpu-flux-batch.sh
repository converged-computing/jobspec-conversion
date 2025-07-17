#!/bin/bash
#FLUX: --job-name=qc0_X_N4
#FLUX: -N=4
#FLUX: -n=8
#FLUX: --queue=development
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='28'

export OMP_NUM_THREADS=28
ml
source /.../spack/share/spack/setup-env.sh
spack load gcc@11.2.0
ppn=${SLURM_TASKS_PER_NODE%(*}
ranks=$SLURM_NTASKS
nodes=$((ranks / ppn))
echo "PPN   = $ppn"
echo "Ranks = $ranks"
ibrun ../../cactus_CarpetX-gcc qc0.par
