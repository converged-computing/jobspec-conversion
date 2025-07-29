#!/bin/bash
#SBATCH --job-name=sysevr_setup
#SBATCH --account=tk-student
#SBATCH --output=/ukp-storage-1/schroeder_e/sysevr_setup.txt
#SBATCH --mail-user=marco.schroeder@stud.tu-darmstadt.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --partition=gpu-tk

export PATH='/ukp-storage-1/schroeder_e/cmake/cmake-3.27.7-linux-x86_64/bin:$PATH'

export PATH=/ukp-storage-1/schroeder_e/cmake/cmake-3.27.7-linux-x86_64/bin:$PATH
mkdir -p /ukp-storage-1/schroeder_e/SySeVR/
python3.6 -m venv /ukp-storage-1/schroeder_e/SySeVR/venv
source /ukp-storage-1/schroeder_e/SySeVR/venv/bin/activate
module load cuda/10.0
cd /ukp-storage-1/schroeder_e/SySeVR
git clone https://github.com/SySeVR/SySeVR.git
cd SySeVR
cd /ukp-storage-1/schroeder_e/SySeVR/SySeVR/SySeVR_docker/docker_build/home/SySeVR/softdir/py2neo-py2neo-2.0 
python setup.py install
cd /ukp-storage-1/schroeder_e/SySeVR/SySeVR/SySeVR_docker/docker_build/home/SySeVR/softdir/python-joern-0.3.1
python setup.py install
pip install igraph
pip install xlrd==1.1.0
pip install gensim==3.4
pip install pyyaml==3.12
pip install tensorflow==1.6.0
