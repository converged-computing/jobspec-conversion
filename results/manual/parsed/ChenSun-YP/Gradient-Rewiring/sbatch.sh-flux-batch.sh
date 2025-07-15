#!/bin/bash
#FLUX: --job-name=frigid-pastry-6403
#FLUX: -N=6
#FLUX: -t=740
#FLUX: --urgency=16

module load python/3.8
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip
cd spikingjelly
python setup.py install
pip list
cd ..
cd c10
module load cuda
module load cudnn
pip install --no-index torch==1.9.1 torchvision==0.9.1 
pip install  tensorboard==2.2.1 --no-index
python --version
nvidia-smi
python c10.py -test  -s 0.95  -gpu 0 --dataset-dir ../data_cifar10 --dump-dir dump_no_prune -m no_prune -N 20
wait
echo "Done"
