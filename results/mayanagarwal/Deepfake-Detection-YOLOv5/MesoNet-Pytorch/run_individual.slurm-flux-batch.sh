#!/bin/bash
#flux: --nodes=1
#flux: --ntasks=8
#flux: --gpus-per-node=4
#flux: --time-limit=48h
#
# Note: The original Slurm script requested a specific GPU type: p100.
# In Flux, GPU type or feature constraints can be requested using --requires.
# The exact syntax depends on how resources are defined in your Flux instance
# (e.g., --requires=gputype:p100 or --requires=feature:p100).
# Consult your system's documentation for specifying GPU types.
#
# Note: The original Slurm script specified a partition (-p gpgpu) and
# a QoS (-q gpgpumse). In Flux, these are typically handled at submission
# time (e.g., using options with `flux submit`) or by submitting to a
# pre-configured Flux instance, rather than via directives in the script.

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

# Note: The original script loads OpenMPI and requests 8 tasks, but launches the Python script directly.
# If 'train_Meso.py' is an MPI application, you might need to explicitly launch it in parallel
# for it to utilize all 8 allocated tasks. For example:
# mpirun -np 8 python3 train_Meso.py ...
# or using Flux's native launcher:
# flux run -n 8 python3 train_Meso.py ...
# The command below directly mirrors the original script's execution style.

time python3 train_Meso.py -n 'Mesonet' -tp './extracted_ff' -vp './extracted_val_ff' -bz 64 -e 50 -mn 'meso4_ff.pkl'