#!/bin/bash
#FLUX: --job-name=mesh_nbody_benchmark
#FLUX: -n=4
#FLUX: -c=10
#FLUX: -t=900
#FLUX: --urgency=16

export TMPDIR='$JOBSCRATCH'

module purge
module load tensorflow-gpu/py3/2.4.1+cuda-11.2 nvidia-nsight-systems/2021.1.1
set -x
export TMPDIR=$JOBSCRATCH
ln -s $JOBSCRATCH /tmp/nvidia
srun --unbuffered --mpi=pmi2 -o mesh_nbody_%t.log /gpfslocalsup/pub/idrtools/bind_gpu.sh nsys profile --stats=true -t nvtx,cuda,mpi -o result-%q{SLURM_TASK_PID} python -u mesh_nbody_benchmark.py  --nc=128 --batch_size=1 --nx=2 --ny=2 --hsize=32 --nsteps=3
