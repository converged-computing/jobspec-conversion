#!/bin/bash
#SBATCH --job-name=run_ad
#SBATCH --output=output/run_ad/%j-%a.out
#SBATCH --mail-user=alonshp@post.bgu.ac.il
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --qos=normal
#SBATCH --array=0-3

echo `date`
echo -e "\nSLURM_JOBID:\t\t" $SLURM_JOBID
echo -e "SLURM_ARRAYTASKID:\t" $SLURM_ARRAY_TASK_ID
echo -e "SLURM_JOB_NODELIST:\t" $SLURM_JOB_NODELIST "\n\n"
module load anaconda				### load anaconda module (must present when working with conda environments)
source activate pytorch_ads				### activating environment, environment must be configured before running the job
echo -e $CONDA_DEFAULT_ENV
echo -e $CONDA_PREFIX
python --version
python /sise/home/alonshp/AnomalyDetectionScreening/ads/scripts/main.py --run_parallel True --tune_hyperparams True --calc_l1k True  --plate_normalized False --exp_name 2852_fsdmso --slice_id $SLURM_ARRAY_TASK_ID  --tune_l1 False  
