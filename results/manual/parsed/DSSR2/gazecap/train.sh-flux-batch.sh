#!/bin/bash
#FLUX: --job-name=stanky-house-0271
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_BLOCKING_WAIT='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_BLOCKING_WAIT=1
module load python/3.8
module load httpproxy
pwd
cd $SLURM_TMPDIR
virtualenv ./env
source ./env/bin/activate
module load opencv
module load scipy-stack
pip install pillow pandas tensorboard torch torchvision comet-ml pytorch-lightning --no-index
pip install --upgrade setuptools
pip install scikit-image imutils tqdm
tar -xf  ~/projects/def-skrishna/dssr/gazecap_my.tar.gz -C .
echo untar done
ls 
scp -r  ~/projects/def-skrishna/gazecap .
echo copy done
ls
cd gazecap
python gazecap_train.py --dataset_dir ../gazecap_my/ --save_dir ~/projects/def-skrishna/dssr/trained_models/gazecap_my/ --checkpoint  ./checkpoints/checkpoint.ckpt --comet_name gazecap_my --gpus 2 --epochs 25 --workers 18 --bs 300
