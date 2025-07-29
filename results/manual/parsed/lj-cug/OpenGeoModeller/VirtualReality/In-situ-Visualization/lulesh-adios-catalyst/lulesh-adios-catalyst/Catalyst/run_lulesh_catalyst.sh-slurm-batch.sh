#!/bin/bash
#FLUX: --job-name=lulesh+catalyst
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS='1'

module load daint-gpu ParaView
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS=1
cp catalyst.py ../buildCatalyst/bin/lulesh2.0 $SCRATCH
pushd $SCRATCH
srun ./lulesh2.0 -x catalyst.py -s 30 -p
