#!/bin/bash
#SBATCH --job-name=Duck
#SBATCH --output=./logs/DuckDuckGeese.out
#SBATCH --error=./logs/err_Duck.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00

export PYTHONPATH='$PYTHONPATH:/gpfsdswork/projects/rech/pch/ulz67kb/SMATE_MTS/Baselines/mtsc_nmsu_ijcai2020/src'

module purge
module load tensorflow-gpu/py2/1.14 openjdk python/2.7.16
conda activate /gpfslocalsup/pub/anaconda-py2/2019.03/envs/tensorflow-gpu-1.14
export PYTHONPATH=$PYTHONPATH:/gpfslocalsup/pub/anaconda-py2/2019.03/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:/gpfsdswork/projects/rech/pch/ulz67kb/SMATE_MTS/Baselines/mtsc_nmsu_ijcai2020/src
set -x
 python fcn_ca_main.py DuckDuckGeese 0
