#!/bin/bash
#SBATCH --job-name=simdata
#SBATCH --output=log/slurm.%j.%N.out
#SBATCH --error=log/slurm.%j.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=4-04:00:00

module load anaconda/mini/4.9.2
module load nvidia/cuda/11.3.1
bootstrap_conda
conda activate minienv
which python
hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
top -b -d1 -n1 | grep -i "%Cpu" #This will show cpu utilization at the start of the script
date
python -u create_data.py $1 $2
wait
