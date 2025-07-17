#!/bin/bash
#FLUX: --job-name=norbench
#FLUX: -c=8
#FLUX: --queue=standard-g
#FLUX: -t=36000
#FLUX: --urgency=16

export NCCL_SOCKET_IFNAME='hsn'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OPENBLAS_VERBOSE='2'
export PYTHONUSERBASE='/projappl/project_465000498/.local'
export PATH='$PYTHONUSERBASE/bin:$PATH'
export PYTHONPATH='$PYTHONUSERBASE/lib/python3.9/site-packages:$PYTHONPATH'

source ${HOME}/.bashrc
module --quiet purge
module load LUMI/22.08
module load cray-python/3.9.12.1
module load rocm/5.2.3
export NCCL_SOCKET_IFNAME=hsn
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_VERBOSE=2
export PYTHONUSERBASE='/projappl/project_465000498/.local'
export PATH=$PYTHONUSERBASE/bin:$PATH
export PYTHONPATH=$PYTHONUSERBASE/lib/python3.9/site-packages:$PYTHONPATH
MODEL=${1}  # Path to the model or its HuggingFace name
IDENTIFIER=${2}  # identifier to save the results and checkpoints with
echo ${MODEL}
echo ${IDENTIFIER}
python3 norbench_run.py --path_to_model ${MODEL} --task sentiment --task_specific_info sentence --model_name ${IDENTIFIER} --batch_size 16 --max_length 512
