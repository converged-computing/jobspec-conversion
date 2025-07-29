#!/bin/bash
#SBATCH --job-name=RUN_CREATE_CRIS_HR_DCC_RTP
#SBATCH --account=pi_strow
#SBATCH --output=/home/sbuczko1/LOGS/sbatch/run_cris_hr_dcc_batch-%A_%a.out
#SBATCH --error=/home/sbuczko1/LOGS/sbatch/run_cris_hr_dcc_batch-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --time=02:59:00
#SBATCH --partition=high_mem
#SBATCH --qos=normal+

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_cris_batch"
$MATLAB $MATOPT -r "disp('>>Starting script');rtp_addpaths;cfg=ini2struct('$1');run_cris_hires_dcc_batch(cfg); exit"
echo "Finished with run_cris_batch"
