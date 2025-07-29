#!/bin/bash
#SBATCH --job-name=bmmclainMPCY1W1Y2W2
#SBATCH --output=JobOutputDump/20231023/job_name.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3750mb
#SBATCH --time=1-01:00:00

module load python/3.9
cd /project/meisel/users/bmmclain/Y1W1Y2W2
python MultiProcessingCode_Y1W1Y2W2_v1.py $SLURM_JOB_ID 1000000 1000 48 random
