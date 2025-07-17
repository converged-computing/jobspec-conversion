#!/bin/bash
#FLUX: --job-name=installation
#FLUX: -c=8
#FLUX: --queue=medium
#FLUX: -t=10800
#FLUX: --urgency=16

echo "$state Start"
echo Time is `date`
echo "Directory is ${PWD}"
echo "This job runs on the following nodes: ${SLURM_JOB_NODELIST}"
conda install pytorch==1.11.0 torchvision==0.12.0 cudatoolkit=11.3 -c pytorch
cd $HOME
mkdir openblas
cd $HOME/Projects
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
make
make install PREFIX=$HOME/openblas
echo export LD_LIBRARY_PATH=$HOME/openblas:$LD_LIBRARY_PATH >> ~/.bashrc
echo export BLAS=$HOME/openblas/lib/libopenblas.a >> ~/.bashrc
echo export ATLAS=$HOME/openblas/lib/libopenblas.a >> ~/.bashrc
cd ../
git clone https://github.com/NVIDIA/MinkowskiEngine.git
cd MinkowskiEngine
python setup.py install --blas_include_dirs=$HOME/openblas/include --blas=openblas
pip uninstall tinycudann
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
python ./Collaborative-NeRF/scripts/test_cuda_available.py
pip install open3d
pip install tqdm scikit-image opencv-python configargparse lpips imageio-ffmpeg \
            kornia lpips tensorboard visdom tensorboardX matplotlib plyfile trimesh
