#!/bin/bash
#SBATCH --job-name=lensing_mock_challenge
#SBATCH --account=leauthaud
#SBATCH --output=log/compute_%a.out
#SBATCH --mail-user=jolange@ucsc.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=leauthaud

cd /data/groups/leauthaud/jolange/Zebu/lux
source init.sh
cd ../stacks/
python compute.py $SLURM_ARRAY_TASK_ID
