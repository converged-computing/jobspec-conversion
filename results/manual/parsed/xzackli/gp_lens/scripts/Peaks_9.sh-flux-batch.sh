#!/bin/bash
#FLUX: --job-name=gp-noisy-PS
#FLUX: -t=21600
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'

module load anaconda3 intel intel-mkl
export OMP_NUM_THREADS=20
cd /home/zequnl/jia/gp_lens/
python -u run_gp.py -o /tigress/zequnl/gp_chains/Peaks_9_med_${SLURM_JOB_ID}.dat \
  -d Peaks -binmin 1 -binmax 3 -cn KN -s 2.00 --bin_center_row 1
