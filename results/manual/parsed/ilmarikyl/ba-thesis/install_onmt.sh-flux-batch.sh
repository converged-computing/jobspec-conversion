#!/bin/bash
#FLUX: --job-name=onmt_install
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load python-env/intelpython3.6-2018.3 gcc/5.4.0 cuda/9.0 cudnn/7.1-cuda9
module list 
mkdir -p /wrk/${USER}/git/
cd /wrk/${USER}/git/
if [ ! -f "./OpenNMT-py/README.md" ]; then
    echo "cloning OpenNMT-py repository"
    git clone --recursive https://github.com/OpenNMT/OpenNMT-py.git
    # OR our branch:
    # git clone --recursive git@github.com:Helsinki-NLP/OpenNMT-py.git
    cd OpenNMT-py
  else
      echo "repository already exists"
      cd OpenNMT-py
      echo "pulling repository"
      git pull origin master 
fi
pip install git+https://github.com/pytorch/text --user
