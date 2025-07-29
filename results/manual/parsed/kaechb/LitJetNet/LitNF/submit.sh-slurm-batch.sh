#!/bin/bash
#SBATCH --job-name=hostname
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --mail-user=max.muster@desy.de
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=P100|V100|A100
#SBATCH --chdir=/home/kaechben/slurm

unset LD_PRELOAD
source /etc/profile.d/modules.sh
module purge
module load maxwell gcc/9.3
module load anaconda3/5.2
. conda-init
conda activate jetnet
path=JetNet_NF
python -u /home/$USER/$path/LitJetNet/LitNF/main.py
