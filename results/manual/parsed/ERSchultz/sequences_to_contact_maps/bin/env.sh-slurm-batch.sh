#!/bin/bash
#SBATCH --job-name=setup
#SBATCH --account=pi-depablo
#SBATCH --output=logFiles/setup.out
#SBATCH --mail-user=erschultz@uchicago.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2000
#SBATCH --time=2-00:00:00
#SBATCH --partition=depablo-gpu
#SBATCH --constraint=ntasks-per-node=5

envName=python3.9_pytorch2.0
ofile=logFiles/conda_env_spectre.log
TORCH=2.0
CUDA=111
conda create --name $envName -y
conda activate $envName
conda install -y python=3.9 pytorch=2.0 pyg pytorch-scatter pytorch-sparse torchvision cudatoolkit=11.1 matplotlib imageio numpy jupyterlab pillow seaborn numba pandas scikit-learn scikit-image scipy pybigwig pybind11 sympy isort -c pytorch -c conda-forge -c bioconda -c pyg &>> $ofile
python3 -m pip install pynvml importmagic hic-straw hicrep pip install opencv-python &>> $ofile
conda env export > logFiles/env_local2.yml
conda deactivate
