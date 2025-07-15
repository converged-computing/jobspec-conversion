#!/bin/bash
#FLUX: --job-name=pusheena-pedo-2309
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES=''
export SLURM_LOADER_LOAD_NO_MPI_LIB='python'

source $HOME/workplace/Tensorflow/TF_env/bin/activate
module load 2020
module load ear
export CUDA_VISIBLE_DEVICES=''
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
srun --ear=on python $HOME/workplace/Tensorflow/SVDD/svdd-default.py --dim $1 --hidden_layers "$2" --fixed_target $3 --iterations $4 --batch $5 --device "cpu" --precision $7 #>> log/example.txt
wait
cd /scratch
rm -r svdd
