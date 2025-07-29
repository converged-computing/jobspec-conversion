#!/bin/bash
#SBATCH --output=model_tf%j.out
#SBATCH --mail-user=akira_nair@brown.edu
#SBATCH --mail-type=END,FAIL,TIME_LIMIT,BEGIN
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=01:00:00

module load python/3.11.0 openssl/3.0.0 cuda/11.7.1 cudnn/8.2.0
source /users/anair27/data/anair27/singh-lab-TCGA-project/multiomic-model-tcga/tf_gpu.venv/bin/activate
which python3
which python
nvidia-smi
python3 -c "import tensorflow as tf;tf.test.is_gpu_available(cuda_only=False, min_cuda_compute_capability=None)"
cd /users/anair27/data/anair27/singh-lab-TCGA-project/multiomic-model-tcga/
python3 models/MAVI/simple_model.py
