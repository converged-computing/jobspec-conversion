#!/bin/bash
#SBATCH --job-name=tim_run_tf2_script
#SBATCH --output=tensor_out.txt
#SBATCH --error=tensor_error.txt
#SBATCH --nodes=3
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=50000
#SBATCH --partition=gpu

module load gnu7
module load cuda/11.1.1
module load anaconda
module load mvapich2
module load pmix/2.2.2
srun -n2 --mpi=pmi2 python3.6 benchmarks/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --num_gpus=2 --model resnet50 --batch_size 128
