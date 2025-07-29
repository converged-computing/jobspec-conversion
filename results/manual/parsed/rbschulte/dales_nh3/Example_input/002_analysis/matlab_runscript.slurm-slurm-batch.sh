#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24000MB
#SBATCH --time=2-00:00:00
#SBATCH --partition=thin

module load 2021
module load MATLAB/2021a-upd3
echo "mcc -m DALES_ProcessOutput002.m" | matlab -nodisplay
./DALES_ProcessOutput002
