#!/bin/bash
#SBATCH --account=def-simontse
#SBATCH --output=%x.o%A-%a
#SBATCH --error=%x.e%A-%a
#SBATCH --mail-user=simon.tse@twu.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1G
#SBATCH --time=00:00:20
#SBATCH --array=1-231

module load matlab
cd ~/project/pattern-formation/zebrafish
matlab -batch "run2($SLURM_ARRAY_TASK_ID)"
