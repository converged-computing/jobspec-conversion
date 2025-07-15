#!/bin/bash
#FLUX: --job-name=doopy-avocado-3601
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'

module load anaconda3 intel intel-mkl
export OMP_NUM_THREADS=20
cd /home/zequnl/jia/gp_lens/
python -u run_gp.py -o /tigress/zequnl/gp_chains/Peaks_8_low_${SLURM_JOB_ID}.dat \
  -d Peaks -binmin -0.8 -binmax 1 -cn KN -s 2.00 --bin_center_row 1
