#!/bin/bash
#FLUX: --job-name=gloopy-fork-5171
#FLUX: --urgency=16

module load python gcc/5.2.0-fasrc01 openmpi/2.0.1-fasrc01 fftw/3.3.5-fasrc01
source activate storm_analysis
cd /n/regal/zhuang_lab/hbabcock/2017_08_24/01_u2os_mc_cell1
MOVIE_ID="11"
rm ./m${MOVIE_ID}_analysis/p_${SLURM_ARRAY_TASK_ID}_mlist.bin
python -u /n/home12/hbabcock/code/storm-analysis/storm_analysis/multi_plane/multi_plane.py --basename movie_00${MOVIE_ID}_ --bin ./m${MOVIE_ID}_analysis/p_${SLURM_ARRAY_TASK_ID}_mlist.bin --xml ./m${MOVIE_ID}_analysis/job_${SLURM_ARRAY_TASK_ID}.xml
