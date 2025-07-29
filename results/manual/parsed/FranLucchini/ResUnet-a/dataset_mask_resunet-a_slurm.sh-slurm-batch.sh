#!/bin/bash
#SBATCH --job-name=build_dataset_resunet-a
#SBATCH --output=slurm_output/array_%A-%a.log
#SBATCH --error=slurm_output/array_%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=7
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:05:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --array=1-7

list=('' 'AT' 'ES' 'FR' 'LU' 'NL' 'SE' 'SI')
python /home/chocobo/Cenia-ODEPA/ResUnet-a_original/maskimg.py --country ${list[SLURM_ARRAY_TASK_ID]}
