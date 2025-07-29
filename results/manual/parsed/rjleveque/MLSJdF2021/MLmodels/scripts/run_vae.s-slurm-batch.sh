#!/bin/bash
#SBATCH --output=_slurm_%j.out
#SBATCH --error=_slurm_%j.err
#SBATCH --mail-user=john.doe@example.org
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=00:30:00

module purge
RUNDIR="$REPOPATH/MLmodels/scripts"
cd $RUNDIR
module load anaconda3/2020.07
conda create -n pytorch python=3.6
source activate pytorch
pip install torch==1.7.1+cu110 -f https://download.pytorch.org/whl/torch_stable.html
pip install requests 
pip install matplotlib 
pip install sklearn 
python vae_train.py &&
python vae_test.py &&
python vae_test_nKL.py &&
python vae_plot.py
