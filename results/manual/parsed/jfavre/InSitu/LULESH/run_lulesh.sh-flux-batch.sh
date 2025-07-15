#!/bin/bash
#FLUX: --job-name="lulesh"
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS='1'

module load daint-mc ParaView
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS=1
cp script.py buildCatalyst/bin/lulesh2.0 $SCRATCH
pushd $SCRATCH
srun ./lulesh2.0 -x script.py -s 30 -p
