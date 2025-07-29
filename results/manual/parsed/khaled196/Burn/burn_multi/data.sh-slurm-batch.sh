#!/bin/bash
#SBATCH --job-name=extract_images
#SBATCH --account=43299_sp0039
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:2
#SBATCH --mem=16000
#SBATCH --time=2-00:00:00
#SBATCH --partition=Nvidia

module purge
module load tensorflow-gpu
RUNDIR=/storage02/43299_sp0039/burn_multi
INDIR=/storage02/43299_sp0039/burn_multi/Burn_mod
python ${RUNDIR}/Data.py $INDIR $RUNDIR
