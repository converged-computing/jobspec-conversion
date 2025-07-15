#!/bin/bash
#FLUX: --job-name=butterscotch-peanut-butter-2723
#FLUX: --priority=16

export SLURM_LOADER_LOAD_NO_MPI_LIB='python'

source $HOME/workplace/Tensorflow/TF_env/bin/activate
module load 2020
module load ear
module load cuDNN/8.0.4.30-CUDA-11.0.2
SVDDfilename=$6
cd /scratch
mkdir -p svdd
cd /scratch/svdd
mkdir -p models
mkdir -p data
cp $HOME/workplace/Tensorflow/SVDD/models/${SVDDfilename} models/${SVDDfilename}
cp $HOME/workplace/Tensorflow/SVDD/data/training.h5 data/training.h5
cp $HOME/workplace/Tensorflow/SVDD/data/testing.h5 data/testing.h5
export SLURM_LOADER_LOAD_NO_MPI_LIB=python
srun --ear=on python $HOME/workplace/Tensorflow/SVDD/svdd-default.py --dim $1 --hidden_layers "$2" --fixed_target $3 --iterations $4 --batch $5 --device "gpu" --precision $7 #>> log/example.txt
wait
cd /scratch
rm -r svdd
