#!/bin/bash
#SBATCH --job-name=gp-noisy-PS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=20

export OMP_NUM_THREADS='20'

module load anaconda3 intel intel-mkl
export OMP_NUM_THREADS=20
cd /home/zequnl/jia/gp_lens/
python -u run_gp.py -o /tigress/zequnl/gp_chains/Peaks_9_med_${SLURM_JOB_ID}.dat \
  -d Peaks -binmin 1 -binmax 3 -cn KN -s 2.00 --bin_center_row 1
