#!/bin/bash
#SBATCH --job-name=gpunb
#SBATCH --output=gpunb.info
#SBATCH --error=gpunb.info
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2GB
#SBATCH --time=12:30:00

module load Singularity
module load CUDA/10.2.89
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
cluster=$(hostname -f | awk -F"." '{print $2}')
echo "Paste this command in your terminal."
echo "ssh -N -L ${port}:${node}:${port} -L 6006:${node}:6006 ${user}@${cluster}phoenix-login1.adelaide.edu.au"
singularity exec --nv main.simg jupyter notebook --port=${port} --ip=${node}
