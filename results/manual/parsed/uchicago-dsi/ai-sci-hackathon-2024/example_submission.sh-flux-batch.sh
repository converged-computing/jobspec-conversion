#!/bin/bash
#FLUX: --job-name=milky-punk-6387
#FLUX: --queue=schmidt-gpu
#FLUX: -t=7200
#FLUX: --urgency=16

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
