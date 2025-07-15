#!/bin/bash
#FLUX: --job-name=siam_co
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

dir=$HOME/Documents/software/siamese_sp/siamese_sp
simg=$HOME/ksptrack-ubelix.simg
pyversion=my-3.7
exec=python
script=train.py
args="--cuda --in-root $HOME/data/medical-labeling --out-dir $HOME/runs/siamese --train-dir 10 --train-frames 51 --test-dirs 10 11 12 13 --sp-pooling-max --exp-name maxpool"
export OMP_NUM_THREADS=1
singularity exec --nv $simg /bin/bash -c "source $HOME/.bashrc && pyenv activate $pyversion && cd $dir && $exec $script $args"
