#!/bin/bash
#SBATCH --output=hpp-%j.out
#SBATCH --error=hpp-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --partition=unkillable

SRC_DIR=$HOME/proj/hiporank_plusplus
module load python/3.7
module load python/3.7/cuda/10.1/cudnn/8.0/pytorch/1.6.0
virtualenv $SLURM_TMPDIR/env/
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip
pip install -r $SRC_DIR/requirements.txt
pyrouge_set_rouge_path $SRC_DIR/ROUGE-1.5.5/
python $SRC_DIR/hpp_test.py
