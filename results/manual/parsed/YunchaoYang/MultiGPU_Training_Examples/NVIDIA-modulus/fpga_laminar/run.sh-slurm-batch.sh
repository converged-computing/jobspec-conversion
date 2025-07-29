#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:8
#SBATCH --mem-per-cpu=1000GB
#SBATCH --time=3-00:00:00

ml load singularity/3.7.4 cuda/11.4.3
CONTAINER=/apps/nvidia/containers/modulus/modulus_v22.03.sif
srun --unbuffered --mpi=none -n8 --ntasks-per-node 8 singularity exec --nv --bind .:/mnt $CONTAINER python /mnt/fpga_flow.py
