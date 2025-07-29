#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1

export THEANO_FLAGS='floatX=float64'

module load python/3.5.1
export THEANO_FLAGS='floatX=float64'
python train.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
