#!/bin/bash
#SBATCH --account=C3SE2023-1-8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:V100:1
#SBATCH --time=1-23:00:00

module purge
ml AMGX/2.3.0-foss-2021a-CUDA-11.3.1 SciPy-bundle/2021.05-foss-2021a matplotlib/3.4.2-foss-2021a
ml PyTorch/1.12.1-foss-2021a-CUDA-11.3.1
ml scikit-learn/0.24.2-foss-2021a
./run-python
