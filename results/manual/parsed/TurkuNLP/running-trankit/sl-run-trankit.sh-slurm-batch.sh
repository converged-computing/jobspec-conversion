#!/bin/bash
#SBATCH --account=Project_2005092
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1,nvme:100
#SBATCH --mem=10G
#SBATCH --time=00:07:00
#SBATCH --partition=gputest
#SBATCH --constraint=ntasks-per-node=1

mkdir -p logs
echo "START: $(date)"
echo "installing venv"
python3 -m venv venv-trankit
source venv-trankit/bin/activate
echo "venv done"
echo 
pip3 install --upgrade pip
pip3 install setuptools-rust
pip3 install trankit==1.1.0
pip3 install transformers
echo "Parsing"
cat $1 | srun python3 parse.py | gzip > output.conllu.gz
