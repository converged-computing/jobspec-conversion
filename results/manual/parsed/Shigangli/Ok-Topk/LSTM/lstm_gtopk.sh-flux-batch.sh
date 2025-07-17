#!/bin/bash
#FLUX: --job-name=expressive-despacito-7728
#FLUX: -N=32
#FLUX: -n=32
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=7800
#FLUX: --urgency=16

module load daint-gpu
conda activate py38_oktopk
which nvcc
nvidia-smi
which python
dnn="${dnn:-lstman4}"
density="${density:-0.02}"
source exp_configs/$dnn.conf
compressor="${compressor:-gtopk}"
nworkers="${nworkers:-32}"
echo $nworkers
nwpernode=1
sigmascale=2.5
PY=python
srun $PY -m mpi4py main_trainer.py --dnn $dnn --dataset $dataset --max-epochs 10 --batch-size $batch_size --nworkers $nworkers --data-dir $data_dir --lr $lr --nwpernode $nwpernode --nsteps-update $nstepsupdate --compression --sigma-scale $sigmascale --density $density --compressor $compressor
