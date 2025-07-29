#!/bin/bash
#SBATCH --job-name=fourcastnet_job
#SBATCH --account=gdsp-k
#SBATCH --output=/scratch/gilbreth/gupt1075/run_fourcastnet.out
#SBATCH --error=/scratch/gilbreth/gupt1075/run_fourcastnet.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=23:00:00
#SBATCH --constraint=ntasks-per-node=32,v100|a100

export PRECXX11ABI='1'
export CUDA='11.7'

module --force purge
unset PYTHONPATH
module load anaconda/5.3.1-py37
module load cuda/11.7.0
module load cudnn/cuda-11.7_8.6
module use /depot/gdsp/etc/modules
module load utilities monitor
module load rcac
module list
export PRECXX11ABI=1
export CUDA="11.7"
echo $PYTHONPATH
source  /apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/etc/profile.d/conda.sh
conda activate pytorch
cd /scratch/gilbreth/wwtung/FourCastNet/
python /scratch/gilbreth/gupt1075/FourCastNet/animate_input.py
