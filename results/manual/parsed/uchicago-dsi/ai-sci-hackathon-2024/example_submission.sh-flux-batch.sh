#!/bin/bash
#FLUX: --job-name=spicy-banana-0962
#FLUX: -t=7200
#FLUX: --priority=16

module load python/miniforge-24.1.2 # python 3.10
echo "output of the visible GPU environment"
nvidia-smi
source /project/dfreedman/hackathon/hackathon-env/bin/activate
echo PyTorch
python example_torch.py
echo Tensorflow
python example_tf.py
source /project/dfreedman/hackathon/hackathon-env-jax/bin/activate
echo JAX
python example_jax.py
