#!/bin/bash
#FLUX: --job-name=stanky-itch-7288
#FLUX: -N=16
#FLUX: -n=16
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=5400
#FLUX: --priority=16

module load daint-gpu
conda activate py38_oktopk
which nvcc
nvidia-smi
which python
dnn="${dnn:-vgg16}"
density="${density:-0.02}"
source exp_configs/$dnn.conf
compressor="${compressor:-gaussiank}"
nworkers="${nworkers:-16}"
echo $nworkers
nwpernode=1
sigmascale=2.5
PY=python
srun $PY -m mpi4py main_trainer.py --dnn $dnn --dataset $dataset --max-epochs $max_epochs --batch-size $batch_size --nworkers $nworkers --data-dir $data_dir --lr $lr --nwpernode $nwpernode --nsteps-update $nstepsupdate --compression --sigma-scale $sigmascale --density $density --compressor $compressor
