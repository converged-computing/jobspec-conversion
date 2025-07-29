#!/bin/bash
#SBATCH --job-name=train_dl_model
#SBATCH --account=def-glass
#SBATCH --output=stdout/job-%j.out
#SBATCH --mail-user=thomas.bury@mcgill.ca
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=03:00:00

echo Job $SLURM_JOB_ID released
echo Load modules
module load gcc/9.3.0 arrow python scipy-stack cuda cudnn
echo Create virtual environemnt
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
echo Install packages
pip install --no-index --upgrade pip
pip install tensorflow
pip install scikit-learn
pip install ewstools
pip install matplotlib
pip install kaleido
echo Begin python job
python -u dl_train.py --num_epochs 200 --model 2
