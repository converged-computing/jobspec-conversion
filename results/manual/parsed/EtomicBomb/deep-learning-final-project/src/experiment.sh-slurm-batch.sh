#!/bin/bash
#SBATCH --mail-user=ethan_williams@brown.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=05:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

module purge
unset LD_LIBRARY_PATH
srun apptainer exec --nv /oscar/runtime/software/external/ngc-containers/tensorflow.d/x86_64.d/tensorflow-24.03-tf2-py3.simg python3 src/main.py "$@"
