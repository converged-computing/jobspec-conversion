#!/bin/bash
#SBATCH --job-name=covstates
#SBATCH --mail-user=emarty@uga.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=3500M
#SBATCH --time=3-00:00:00
#SBATCH --array=1-50

cd $SLURM_SUBMIT_DIR
module load R/3.6.2-foss-2019b
mkdir ${SLURM_JOB_ID}
cd ${SLURM_JOB_ID}
R CMD BATCH "--args a=$SLURM_ARRAY_TASK_ID" ../code/00-RUN-CLUSTER-ARRAY.R
