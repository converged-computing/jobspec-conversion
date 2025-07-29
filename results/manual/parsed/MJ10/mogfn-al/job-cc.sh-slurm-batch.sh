#!/bin/bash
#SBATCH --output=/scratch/mjain/logs/lambo-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=06:00:00

export PYTHONUNBUFFERED='1'

module load python/3.8 cuda/11.1
export PYTHONUNBUFFERED=1
module load python/3.8
cd $SLURM_TMPDIR/
virtualenv --no-download venv
source venv/bin/activate
cd ~/lambo
pip install --no-index --find-links=~/wheels/ -r requirements-cc.txt
pip install -e .
pkill -9 wandb
python scripts/black_box_opt.py "$@"
