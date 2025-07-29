#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=cheme_gpu
#SBATCH --output=fw_vasp-%j.out
#SBATCH --error=fw_vasp-%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2G
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=TOP
#SBATCH --constraint=ntasks-per-node=8

module purge; 
ulimit -Sn 4096; 
module load NAMD cuda
namd2 +p8 +isomalloc_sync fixed_mos2_solvate.namd
