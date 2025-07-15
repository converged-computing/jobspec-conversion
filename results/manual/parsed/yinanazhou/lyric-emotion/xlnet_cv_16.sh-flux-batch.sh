#!/bin/bash
#FLUX: --job-name=purple-milkshake-0200
#FLUX: -c=4
#FLUX: -t=259200
#FLUX: --urgency=16

module load python/3.8
module load scipy-stack
module load cuda
module --ignore-cache load torch/1.4.0
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip3 install --upgrade --no-binary numpy==1.20.0 numpy==1.20.0
pip install --no-index -r requirements.txt
echo "Starting Task"
python xlnet_cv.py --ml 512 --bs 16 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 1
python xlnet_cv.py --ml 512 --bs 16 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 2
python xlnet_cv.py --ml 512 --bs 16 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 3
python xlnet_cv.py --ml 512 --bs 16 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 4
python xlnet_cv.py --ml 512 --bs 16 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 5
python xlnet_cv.py --ml 512 --bs 16 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 6
