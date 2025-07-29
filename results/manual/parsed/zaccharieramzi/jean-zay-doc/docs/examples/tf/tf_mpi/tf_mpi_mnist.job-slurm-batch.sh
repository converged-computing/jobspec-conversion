#!/bin/bash
#FLUX: --job-name=mnist_tf_mpi
#FLUX: -n=32
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: --queue=gpu_p1
#FLUX: -t=60
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
module load cudnn/10.1-v7.5.1.10
module load nccl/2.4.2-1+cuda10.1
module load tensorflow-gpu/py3/1.14-openmpi
set -x
srun --mpi=pmix python tf_mpi_mnist.py --mnist $PWD/mnist.npz
