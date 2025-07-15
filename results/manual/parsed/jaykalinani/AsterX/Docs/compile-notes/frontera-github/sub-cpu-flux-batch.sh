#!/bin/bash
#FLUX: --job-name=hello-fudge-3317
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
