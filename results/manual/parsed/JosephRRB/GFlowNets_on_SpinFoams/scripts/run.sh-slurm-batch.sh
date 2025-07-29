#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --mail-user=jwogan2@uwo.ca
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:08:00

module load python/3 gcc arrow cuda cudnn
virtualenv --no-download tensorflow
source tensorflow/bin/activate
pip install --no-index tensorflow==2.8
pip install -r ./../requirements.txt
pip install -e ./../
python ./test-parameters.py
