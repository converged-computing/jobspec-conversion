#!/bin/bash
#FLUX: --job-name=run_ad
#FLUX: -c=4
#FLUX: --queue=main
#FLUX: -t=259200
#FLUX: --urgency=16

echo `date`
echo -e "\nSLURM_JOBID:\t\t" $SLURM_JOBID
echo -e "SLURM_ARRAYTASKID:\t" $SLURM_ARRAY_TASK_ID
echo -e "SLURM_JOB_NODELIST:\t" $SLURM_JOB_NODELIST "\n\n"
module load anaconda				### load anaconda module (must present when working with conda environments)
source activate pytorch_ads				### activating environment, environment must be configured before running the job
echo -e $CONDA_DEFAULT_ENV
echo -e $CONDA_PREFIX
python --version
python /sise/home/alonshp/AnomalyDetectionScreening/ads/scripts/run_anomaly_shap.py --slice_id $SLURM_ARRAY_TASK_ID --exp_name 2703_t 
