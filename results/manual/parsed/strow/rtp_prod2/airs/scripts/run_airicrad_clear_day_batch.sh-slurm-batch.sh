#!/bin/bash
#SBATCH --job-name=RUN_CREATE_AIRS_CLEAR_DAY_RTP
#SBATCH --account=pi_strow
#SBATCH --output=/home/sbuczko1/LOGS/sbatch/run_create_airs_clear_day-%A_%a.out
#SBATCH --error=/home/sbuczko1/LOGS/sbatch/run_create_airs_clear_day-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=03:59:00
#SBATCH --partition=high_mem
#SBATCH --qos=medium+

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_cris_batch"
$MATLAB $MATOPT -r "disp('>>Starting script');\
                    airs_rtpaddpaths;\
                    cfg=ini2struct('$1');\
                    run_airicrad_clear_day_batch(cfg);\
                    exit"
echo "Finished with run_airs_batch"
