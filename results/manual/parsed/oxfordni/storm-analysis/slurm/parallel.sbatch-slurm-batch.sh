#!/bin/bash
#SBATCH --output=log_sa_parallel_%A_%a.out
#SBATCH --error=log_sa_parallel_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1500
#SBATCH --time=02:00:00
#SBATCH --partition=serial_requeue

module load python gcc/5.2.0-fasrc01 openmpi/2.0.1-fasrc01 fftw/3.3.5-fasrc01
source activate storm_analysis
cd /n/regal/zhuang_lab/hbabcock/2017_08_24/01_u2os_mc_cell1
MOVIE_ID="11"
rm ./m${MOVIE_ID}_analysis/p_${SLURM_ARRAY_TASK_ID}_mlist.bin
python -u /n/home12/hbabcock/code/storm-analysis/storm_analysis/multi_plane/multi_plane.py --basename movie_00${MOVIE_ID}_ --bin ./m${MOVIE_ID}_analysis/p_${SLURM_ARRAY_TASK_ID}_mlist.bin --xml ./m${MOVIE_ID}_analysis/job_${SLURM_ARRAY_TASK_ID}.xml
