#!/bin/bash
#SBATCH --output=FedLrn
#SBATCH --mail-user=mgg17
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

source /vol/bitbucket/mgg17/diss/venv/bin/activate
source /vol/cuda/10.0.130/setup.sh
TERM=vt100
/usr/bin/nvidia-smi
add-apt-repository ppa:openjdk-r/ppa
apt-get update -q
apt install -y openjdk-11-jdk
uptime
nohup python -u main.py > out/experimentAFAxis.log 2>&1
