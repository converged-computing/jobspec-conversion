#!/bin/bash
#SBATCH --job-name=sample_job_\${SLURM_ARRAY_TASK_ID}
#SBATCH --account=w10001
#SBATCH --output=sample_job.%A_%a.out
#SBATCH --mail-user=email@u.northwestern.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-9

module purge all
module load python-anaconda3
source activate slurm-py37-test
IFS=$'\n' read -d '' -r -a lines < list_of_files.txt
python slurm_test.py --job-id $SLURM_ARRAY_TASK_ID --filename ${lines[$SLURM_ARRAY_TASK_ID]}
