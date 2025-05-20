#!/bin/bash

# Flux directives
#FLUX: -N 1
#FLUX: -n 8
#FLUX: --requires=gpus==4
#FLUX: --requires=constraint[p100]  # Assumes 'p100' is a defined constraint for GPU type
#FLUX: -t 48h
#FLUX: -q gpgpu                     # Maps to Slurm partition

# Environment setup
echo "Loading modules..."
module purge
module load fosscuda/2019b
module load cuda/10.1.243
module load gcccore/8.3.0
module load gcc/8.3.0 openmpi/3.1.4
module load python/3.7.4
module load opencv
module load pillow
module load torch/20200428
module load scipy-bundle
module load pyyaml
module load numpy/1.17.3-python-3.7.4
module load torchvision
module load matplotlib/3.1.1-python-3.7.4
module load scikit-learn
module load torchvision/0.5.0-python-3.7.4
module load tqdm
module unload pytorch/1.4.0-python-3.7.4
module load pytorch-geometric/1.6.1-python-3.7.4-pytorch-1.6.0
module load tensorflow/2.3.1-python-3.7.4
echo "Modules loaded."

# Execute the application
echo "Starting application..."
time python3 train_Meso.py -n 'MesoInception' -tp './Extracted' -vp './Extracted_val' -bz 64 -e 150 -mn 'MesoInception.pkl'
echo "Application finished."
```