#!/bin/bash
#FLUX: --job-name=rainbow-poodle-1043
#FLUX: --urgency=16

source activate permafrost
echo Running on host: `hostname`
echo In directory: `pwd`
echo Starting on: `date`
echo SLURM_JOB_ID: $SLURM_JOB_ID
cd /home/matthmey/data/projects/stuett/frontends/permafrostanalytics/
python -u ideas/machine_learning/classification.py -p /home/perma/permasense_vault/datasets/permafrost_hackathon/ -l --classifier seismic
echo finished at: `date`
exit 0;
