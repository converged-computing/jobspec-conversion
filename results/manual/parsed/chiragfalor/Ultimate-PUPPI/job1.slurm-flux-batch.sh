#!/bin/bash
#FLUX: --job-name=sluma_4GPUs
#FLUX: --exclusive
#FLUX: --queue=sched_system_all_8
#FLUX: -t=43200
#FLUX: --urgency=16

export NODELIST='nodelist.$'

HOME2=/home/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=pyt6
CONDA_ROOT=$HOME2/.conda
source /home/software.ppc64le/spack/v0.16.2/spack/opt/spack/linux-rhel8-power9le/gcc-8.3.1/anaconda3-2020.02-2ks5tchtak3kzzbryjloiqhusujnh67c/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
cd /home/cfalor/
cd -
nvidia-smi
ulimit -s unlimited
export NODELIST=nodelist.$
srun -l bash -c 'hostname' |  sort -k 2 -u | awk -vORS=, '{print $2":4"}' | sed 's/,$//' > $NODELIST
echo " "
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " GPUs per node:= " $SLURM_JOB_GPUS
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo " Run started at:- "
date
cd /nobackup/users/cfalor/upuppi/Ultimate-PUPPI/
python -c "import torch; print(torch.version.cuda); print(torch.cuda.is_available())"
python retrain_model.py
echo "Run completed at:- "
date
