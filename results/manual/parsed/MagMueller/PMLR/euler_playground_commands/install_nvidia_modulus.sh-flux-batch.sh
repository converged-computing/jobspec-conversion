#!/bin/bash
#FLUX: --job-name=fourcastnet_gpu_job
#FLUX: -t=7200
#FLUX: --urgency=16

cd $SCRATCH
singularity pull docker://nvcr.io/nvidia/modulus/modulus:23.08
mkdir  $SCRATCH/models
module load cuda/12.1.1
module load gcc/8.2.0 python/3.10.4
srun --pty --gpus=gpu:1 --mem-per-cpu=4G --time=02:00:00 bash -i
singularity run --nv --compat --pwd $SCRATCH --bind /cluster:/cluster $SCRATCH/modulus_23.08.sif 
git clone https://github.com/NVIDIA/earth2mip.git
cd earth2mip && pip install .
cd $SCRATCH/models
wget 'https://api.ngc.nvidia.com/v2/models/nvidia/modulus/modulus_fcnv2_sm/versions/v0.2/files/fcnv2_sm.zip'
unzip fcnv2_sm.zip
python fcnv2_sm/simple_inference.py
