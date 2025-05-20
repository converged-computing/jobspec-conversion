#!/bin/bash
#flux: batch --nodes=1
#flux: batch --ntasks=8
#flux: batch --gpus-per-node=4
#flux: batch --time-limit=48:00:00
#flux: batch --queue=gpgpu
#flux: batch --setattr=system.qos=gpgpumse

# Note: Flux does not have a standard batch directive to specify GPU type (e.g., p100).
# This is typically handled by queue configurations or site-specific resource properties/constraints.
# The --queue=gpgpu request might implicitly select nodes with p100 GPUs if configured that way.
# If more specific GPU type selection is needed, consult local Flux documentation for resource constraints, e.g., --requires=gpu_type:p100

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

time python3 train_Meso.py -n 'Mesonet' -tp './Extracted' -vp './Extracted_val' -bz 256 -e 150 -mn 'meso4.pkl'