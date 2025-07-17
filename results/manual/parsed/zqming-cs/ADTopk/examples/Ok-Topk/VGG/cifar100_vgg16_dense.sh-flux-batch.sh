#!/bin/bash
#FLUX: --job-name=outstanding-nunchucks-8257
#FLUX: -N=16
#FLUX: -n=16
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=9000
#FLUX: --urgency=16

conda activate py39
which nvcc
nvidia-smi
which python
dnn="${dnn:-vgg16}"
source exp_configs/cifar100_vgg16.conf
nworkers="${nworkers:-8}"
echo $nworkers
nwpernode=1
sigmascale=2.5
PY=python
mpiexec -n $nworkers  python main_trainer.py  --dnn $dnn --dataset $dataset --max-epochs $max_epochs --batch-size $batch_size --nworkers $nworkers --data-dir $data_dir --lr $lr --nwpernode $nwpernode --nsteps-update $nstepsupdate --sigma-scale $sigmascale 
