#!/bin/bash
#SBATCH --job-name=live-chess-roberta
#SBATCH --output=./slurm_output/preprocess-%A.out
#SBATCH --mail-user=tannergladson@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

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
