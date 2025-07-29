#!/bin/bash
#SBATCH --job-name=threads_filter_data
#SBATCH --output=logs/%x_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=56gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=cpu_devel
#SBATCH --constraint=amd

module purge
module load cmake
source /home/$USER/.bashrc
conda activate halvesting
mkdir logs
./scripts/filter_data.sh
