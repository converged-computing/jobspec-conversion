#!/bin/bash
#SBATCH --output=out/dynomitescript_output_%j.out
#SBATCH --mail-user=<temp@princeton.edu>
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:59:00
#SBATCH --exclude=redshirt-n[12-49]

module load matlab/R2018a
cd "/jukebox/buschman/Rodent Data/Wide Field Microscopy/Widefield_Imaging_Analysis/Spock/"
