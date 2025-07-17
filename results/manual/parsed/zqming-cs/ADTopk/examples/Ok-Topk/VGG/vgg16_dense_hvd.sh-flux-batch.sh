#!/bin/bash
#FLUX: --job-name=rainbow-bits-3773
#FLUX: -N=16
#FLUX: -n=16
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=9000
#FLUX: --urgency=16

module load daint-gpu
conda activate py39mpi
which nvcc
nvidia-smi
which python
dnn="${dnn:-vgg16}"
source exp_configs/$dnn.conf
nworkers="${nworkers:-2}"
echo $nworkers
nwpernode=1
sigmascale=2.5
PY=python
horovodrun -n $nworkers  python horovod_trainer.py  --dnn $dnn --dataset $dataset --max-epochs $max_epochs --batch-size $batch_size --nworkers $nworkers --data-dir $data_dir --lr $lr --nwpernode $nwpernode --nsteps-update $nstepsupdate 
