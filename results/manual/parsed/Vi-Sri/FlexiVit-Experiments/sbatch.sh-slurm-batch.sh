#!/bin/bash
#SBATCH --job-name=cal_face
#SBATCH --output=outputs/cal_face.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --partition=gpu
#SBATCH --constraint=gmem32

nvidia-smi
nvidia-smi -q |grep -i serial
source ~/.bashrc
CONDA_BASE=$(conda info --base) ; 
source $CONDA_BASE/etc/profile.d/conda.sh
cd /home/sriniana/projects/flexivit/
conda activate vit
echo -e '\n\n' + "*"{,,,,,,,,,,,,,,,,}
echo $SLURM_JOB_ID $SLURM_JOB_NODELIST
echo $CONDA_DEFAULT_ENV
echo -e "*"{,,,,,,,,,,,,,,,,}
python3 -u flexivit.py
