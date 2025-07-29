#!/bin/bash
#SBATCH --job-name=siam_co
#SBATCH --output=/home/ubelix/artorg/lejeune/runs/logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

export OMP_NUM_THREADS='1'

dir=$HOME/Documents/software/siamese_sp/siamese_sp
simg=$HOME/ksptrack-ubelix.simg
pyversion=my-3.7
exec=python
script=train.py
args="--cuda --in-root $HOME/data/medical-labeling --out-dir $HOME/runs/siamese --train-dir 10 --train-frames 51 --test-dirs 10 11 12 13 --sp-pooling-max --exp-name maxpool"
export OMP_NUM_THREADS=1
singularity exec --nv $simg /bin/bash -c "source $HOME/.bashrc && pyenv activate $pyversion && cd $dir && $exec $script $args"
