#!/bin/bash
#FLUX: --job-name=python_cpu
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load Python/3.9.6-GCCcore-11.2.0
if [ $# -lt 3 ]; then
    echo "Usage: $0 <problem> [<horizon>] [num_iter]"
    exit 1
fi
source /scratch/s3918343/venvs/thesis/bin/activate
pip install --upgrade pip
pip install --upgrade wheel
pip install -r requirements.txt
echo "problem : $1 , horizon: $2, iter : $3"
cd /scratch/s3918343/venvs/thesis/Thesis
python experiment.py problem=$1 horizon=$2 iter=$3
echo "DONE"
deactivate
