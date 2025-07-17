#!/bin/bash
#FLUX: --job-name=MNIST_sweep
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=576000
#FLUX: --urgency=16

module purge 
module load python/3.10.9/anaconda
module load julia/1.9.0
module load cuda
conda activate /home/rmo2/envs/testenv
python-jl exp_MNIST_full.py --name test_series2 --digits 3 --run 5 --samples 10 --low_bound 0 --eta 0.0005 --decay True
