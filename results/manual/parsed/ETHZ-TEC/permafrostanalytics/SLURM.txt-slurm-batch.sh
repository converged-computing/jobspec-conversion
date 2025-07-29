#!/bin/bash
#SBATCH --account=tik
#SBATCH --output=/itet-stor/matthmey/net_scratch/logs/log%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G

source activate permafrost
echo Running on host: `hostname`
echo In directory: `pwd`
echo Starting on: `date`
echo SLURM_JOB_ID: $SLURM_JOB_ID
cd /home/matthmey/data/projects/stuett/frontends/permafrostanalytics/
python -u ideas/machine_learning/classification.py -p /home/perma/permasense_vault/datasets/permafrost_hackathon/ -l --classifier seismic
echo finished at: `date`
exit 0;
