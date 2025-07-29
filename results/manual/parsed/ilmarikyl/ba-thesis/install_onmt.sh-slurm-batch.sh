#!/bin/bash
#SBATCH --job-name=onmt_install
#SBATCH --output=out_%J.onmt_install.txt
#SBATCH --error=err_%J.onmt_install.txt
#SBATCH --mail-user=raul.vazquez@helsinki.fi
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=1g
#SBATCH --time=01:00:00

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
