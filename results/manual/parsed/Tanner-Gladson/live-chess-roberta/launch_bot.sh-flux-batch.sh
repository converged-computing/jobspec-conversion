#!/bin/bash
#FLUX: --job-name="live-chess-roberta"
#FLUX: -c=4
#FLUX: --queue=shared
#FLUX: -t=86400
#FLUX: --priority=16

ENV_NAME="lichess-bot"
PYTHON_VERSION="3.9.18"
echo "node list: "$SLURM_JOB_NODELIST
echo "master address: "$MASTER_ADDR
module load anaconda
if [[ $(conda env list | grep -w $ENV_NAME) ]]; then
    echo "Conda environment '$ENV_NAME' already exists, continueing"
else
    conda create --name $ENV_NAME python=$PYTHON_VERSION
fi
conda activate $ENV_NAME
pip install -r requirements.txt
srun python -u ./lichess-bot.py
