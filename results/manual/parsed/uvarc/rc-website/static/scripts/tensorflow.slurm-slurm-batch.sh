#!/bin/bash
#SBATCH --job-name=tftest
#SBATCH --account=mygroup
#SBATCH --output=tftest-%A.out
#SBATCH --error=tftest-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module purge
module load apptainer tensorflow/2.13.0
apptainer run --nv $CONTAINERDIR/tensorflow-2.13.0.sif tf_example.py
