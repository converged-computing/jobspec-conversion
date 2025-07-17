#!/bin/bash
#FLUX: --job-name=evasive-general-5481
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load python/3.11.0 openssl/3.0.0 cuda/11.7.1 cudnn/8.2.0
source /users/anair27/data/anair27/singh-lab-TCGA-project/multiomic-model-tcga/tf_gpu.venv/bin/activate
which python3
which python
nvidia-smi
python3 -c "import tensorflow as tf;tf.test.is_gpu_available(cuda_only=False, min_cuda_compute_capability=None)"
cd /users/anair27/data/anair27/singh-lab-TCGA-project/multiomic-model-tcga/
python3 models/MAVI/simple_model.py
