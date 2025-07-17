#!/bin/bash
#FLUX: --job-name=$1
#FLUX: --queue=cpu
#FLUX: -t=86400
#FLUX: --urgency=16

sbatch <<EOT
source ${HOME}/.bashrc
source activate tds_py37_pt
set PYTHONPATH=./
set OMP_NUM_THREADS=2
python -u ./$1/Prepare_dataset.py --data_dir=/ivi/ilps/personal/jpei/TDS $2
EOT
