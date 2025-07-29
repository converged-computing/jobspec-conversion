#!/bin/bash
#SBATCH --job-name=ep_vs_mhcn
#SBATCH --output=ep_vs_mhcn.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=10-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module load R Python/3.8.2-GCCcore-9.3.0 binutils ImageMagick X11 libX11 xprop
make
