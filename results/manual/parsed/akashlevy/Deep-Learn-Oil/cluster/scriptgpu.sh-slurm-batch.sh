#!/bin/bash
#SBATCH --output=hostname.out
#SBATCH --error=hostname.err
#SBATCH --mail-user=YOUR
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=01:00:00
#SBATCH --partition=holyseasgpu

THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32 python fcn.py
