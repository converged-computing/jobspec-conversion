#!/bin/bash
#FLUX: --job-name=eccentric-malarkey-4081
#FLUX: --queue=lycium
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:${SLURM_SUBMIT_DIR}/src/'

echo "Starting Job"
module load python/3.6.4
source venv/bin/activate
export PYTHONPATH="${PYTHONPATH}:${SLURM_SUBMIT_DIR}/src/"
python src/main.py tune --trainfile datasets/comp3208-train.csv --testfile datasets/comp3208-test.csv --outputfile predictions.csv
echo "Finishing job"
