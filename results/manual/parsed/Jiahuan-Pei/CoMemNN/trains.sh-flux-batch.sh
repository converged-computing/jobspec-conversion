#!/bin/bash
#FLUX: --job-name=$2$3
#FLUX: -t=345600
#FLUX: --urgency=16

sbatch <<EOT
source ${HOME}/.bashrc
source activate tds_py37_pt
set PYTHONPATH=./
set OMP_NUM_THREADS=2
python -m torch.distributed.launch --nproc_per_node=1 --master_port 29501 ./$2/Run.py --mode='train' --debug=0 --data_dir=/ivi/ilps/personal/jpei/TDS --model_name=$2 --exp_name=$3 $4
EOT
