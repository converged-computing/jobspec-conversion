#!/bin/bash
#FLUX: --job-name=delicious-blackbean-4845
#FLUX: -N=32
#FLUX: -n=32
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=4800
#FLUX: --priority=16

module load daint-gpu
conda activate py38_oktopk
which nvcc
nvidia-smi
which python
dnn="${dnn:-lstman4}"
source exp_configs/$dnn.conf
nworkers="${nworkers:-32}"
echo $nworkers
nwpernode=1
sigmascale=2.5
PY=python
srun $PY -m mpi4py main_trainer.py --dnn $dnn --dataset $dataset --max-epochs 10 --batch-size $batch_size --nworkers $nworkers --data-dir $data_dir --lr $lr --nwpernode $nwpernode --nsteps-update $nstepsupdate --sigma-scale $sigmascale
