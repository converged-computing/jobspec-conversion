#!/bin/bash
#FLUX: --job-name=tim_run_tf2_script
#FLUX: -N=3
#FLUX: -n=3
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load gnu7
module load cuda/11.1.1
module load anaconda
module load mvapich2
module load pmix/2.2.2
srun -n2 --mpi=pmi2 python3.6 benchmarks/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --num_gpus=2 --model resnet50 --batch_size 128
