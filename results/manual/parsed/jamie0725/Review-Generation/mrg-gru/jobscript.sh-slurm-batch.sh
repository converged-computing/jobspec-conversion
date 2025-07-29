#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:2
#SBATCH --mem=60000M
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load 2019
module load Python/3.6.6-foss-2018b
module load cuDNN/7.6.3-CUDA-10.0.130  
module load NCCL/2.4.7-CUDA-10.0.130
cp -r $HOME/mrg-gru $TMPDIR
cd $TMPDIR/mrg-gru
virtualenv env -p `which python3`
source env/bin/activate
pip install -r requirements.txt
python train.py
cp log.txt $HOME/mrg-gru
mkdir -p $HOME/mrg-gru/results
cp -r tmp/* $HOME/mrg-gru/results
