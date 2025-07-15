#!/bin/bash
#FLUX: --job-name=corner_plotter
#FLUX: -t=1200
#FLUX: --priority=16

source ~/.bash_profile
conda activate parallel_bilby
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
FNAME=$(printf "/fred/oz117/avajpeyi/projects/phase-marginalisation-test/jobs/out_hundred_injections_gstar/out_injection_${SLURM_ARRAY_TASK_ID}/result/injection_${SLURM_ARRAY_TASK_ID}_0_posterior_samples_with_kicks.dat")
echo "Plotting " "$FNAME"
python plot_corner_weighted_with_kick.py --samples-csv $FNAME --true-file datafiles/injections.csv --true-idx $SLURM_ARRAY_TASK_ID
