#!/bin/bash
#FLUX: --job-name=fuzzy-punk-2564
#FLUX: -c=4
#FLUX: -t=42600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='{$LD_LIBRARY_PATH}:$CUDA_HOME/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/'

module load python/3.6
module load nixpkgs/16.09  intel/2018.3  cuda/10.1 cudnn/7.6.5
source /home/$USER/env_fastsrgan/bin/activate
pip install --no-index setuptools==41.6.0 tensorflow_gpu==2.2.0 opencv_python_headless==4.1.1.26 numpy
export LD_LIBRARY_PATH={$LD_LIBRARY_PATH}:$CUDA_HOME/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/
cd /home/$USER/scratch/Fast-SRGAN-ITMO
echo $PWD
echo "Training..."
tensorboard --logdir="logs/train" --host 0.0.0.0 &
python main_load.py \
--lr_image_dir "/home/$USER/projects/def-panos/shared_itmo_fixed" --lr_size 128 \
--hr_image_dir "/home/$USER/projects/def-panos/shared_itmo_fixed" --hr_size 128 \
--batch_size 32 --epochs 500
