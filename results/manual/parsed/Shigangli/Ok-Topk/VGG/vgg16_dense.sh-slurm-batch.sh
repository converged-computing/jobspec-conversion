#!/bin/bash
#SBATCH --output=16nodes_vgg_dense.txt
#SBATCH --nodes=16
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=12
#SBATCH --time=02:30:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
conda activate py38_oktopk
which nvcc
nvidia-smi
which python
dnn="${dnn:-vgg16}"
source exp_configs/$dnn.conf
nworkers="${nworkers:-16}"
echo $nworkers
nwpernode=1
sigmascale=2.5
PY=python
srun $PY -m mpi4py main_trainer.py --dnn $dnn --dataset $dataset --max-epochs $max_epochs --batch-size $batch_size --nworkers $nworkers --data-dir $data_dir --lr $lr --nwpernode $nwpernode --nsteps-update $nstepsupdate --sigma-scale $sigmascale
