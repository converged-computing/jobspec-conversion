#!/bin/bash
#SBATCH --output=/home/mjyothi/scratch/one4all/run5/%x-%j-log.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=1-00:00:00

module load gcc/9.3.0 arrow cuda/11 python/3.8
source /home/mjyothi/home/mjyothi/bart/bin/activate
python -m experiment.one4all.exp01 -o /home/mjyothi/scratch/one4all/run5 --cache_dir /home/mjyothi/home/mjyothi/cache --initial_wts_dir /home/mjyothi/home/mjyothi/initial_wts &> /home/mjyothi/scratch/one4all/run5/run.log
