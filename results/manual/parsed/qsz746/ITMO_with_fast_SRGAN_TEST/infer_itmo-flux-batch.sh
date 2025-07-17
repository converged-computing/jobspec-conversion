#!/bin/bash
#FLUX: --job-name=milky-itch-9188
#FLUX: -c=2
#FLUX: -t=3000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='{$LD_LIBRARY_PATH}:$CUDA_HOME/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/'

module load python/3.6
module load nixpkgs/16.09  intel/2018.3  cuda/10.1 cudnn/7.6.5
source /home/$USER/env_fastsrgan/bin/activate
export LD_LIBRARY_PATH={$LD_LIBRARY_PATH}:$CUDA_HOME/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/
cd /home/$USER/scratch/Fast-SRGAN-ITMO
echo $PWD
echo "Inference..."
python infer.py --image_dir images --output_dir output \
--gen "models/20200616091300_28500_generator.h5"
