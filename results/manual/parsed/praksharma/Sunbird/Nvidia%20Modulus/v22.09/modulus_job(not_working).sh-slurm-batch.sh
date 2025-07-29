#!/bin/bash
#SBATCH --job-name=jupyter-lab
#SBATCH --account=scw1901
#SBATCH --output=$(pwd)/output.txt
#SBATCH --error=$(pwd)/error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --time=05:00:00

port=8888
node=$(hostname -s)
user=$(whoami)
module load apptainer/1.0.3 
apptainer exec --contain --nv --cleanenv --bind "/home/s.1915438/":/data,/tmp:/tmp --env CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES --home /data  "/home/scratch/s.1915438/modulus22.09_apptainer/modulus_22.09.img" jupyter-lab --no-browser --port=${port} --ip=${node}
