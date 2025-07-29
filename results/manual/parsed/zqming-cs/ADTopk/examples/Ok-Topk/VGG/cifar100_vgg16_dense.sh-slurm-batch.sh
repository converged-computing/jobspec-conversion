#!/bin/bash
#SBATCH --output=16nodes_vgg_dense.txt
#SBATCH --nodes=16
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=12
#SBATCH --time=02:30:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

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
