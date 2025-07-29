#!/bin/bash
#SBATCH --job-name=covid19
#SBATCH --account=joaiml
#SBATCH --output=outputs/output_%j.out
#SBATCH --error=errors/error_%j.er
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='/p/project/joaiml/ingolfsson1/jupyter/kernels/covid_kernel/lib/python3.6/site-packages:${PYTHONPATH}'
export LD_LIBRARY_PATH='/p/home/jusers/ingolfsson1/deep/COVID-Net/softlinks:$LD_LIBRARY_PATH'

module -q purge
module -q use $OTHERSTAGES
module -q load Stages/Devel-2019a GCC/8.3.0 GCCcore/.8.3.0 ParaStationMPI/5.4.0-1-CUDA
module -q load Horovod/0.16.2-GPU-Python-3.6.8
module -q load TensorFlow/1.13.1-GPU-Python-3.6.8
module -q load scikit/2019a-Python-3.6.8
module list
source /p/project/joaiml/ingolfsson1/jupyter/kernels/covid_kernel/bin/activate
export PYTHONPATH=/p/project/joaiml/ingolfsson1/jupyter/kernels/covid_kernel/lib/python3.6/site-packages:${PYTHONPATH}
cd /p/home/jusers/ingolfsson1/deep/COVID-Net/softlinks
ln -s /usr/lib64/libcuda.so.1
ln -s /usr/lib64/libnvidia-ml.so.1
export LD_LIBRARY_PATH=/p/home/jusers/ingolfsson1/deep/COVID-Net/softlinks:$LD_LIBRARY_PATH
nvidia-smi
cd /p/home/jusers/ingolfsson1/deep/COVID-Net
srun --cpu-bind=none,v --accel-bind=gn python -u test_cov.py
