#!/bin/bash
#FLUX: --job-name=face_extract
#FLUX: -c=4
#FLUX: --queue=small-g
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPICH_GPU_SUPPORT_ENABLED='1'
export PYTHONUSERBASE='/scratch/project_462000139/jorma/momaf/github/facerec/python_base'

SAVE_EVERY=5
OUT_PATH=out
NO_IMAGES=""
if [[ $# == 0 ]]; then
    echo $0 : video file name argument missing
    exit 1
fi
if [[ $# > 1 ]]; then
    echo $0 : too many arguments
    exit 1
fi
echo Running in `hostname` $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $1
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPICH_GPU_SUPPORT_ENABLED=1
module use /appl/local/csc/modulefiles
module load tensorflow
export PYTHONUSERBASE=/scratch/project_462000139/jorma/momaf/github/facerec/python_base
python3 -u ./facerec/extract.py \
    --n-shards $SLURM_ARRAY_TASK_COUNT \
    --shard-i $SLURM_ARRAY_TASK_ID \
    --save-every $SAVE_EVERY \
    --out-path $OUT_PATH \
    $NO_IMAGES \
    $1
if [[ $? -ne 0 ]]
then
    echo FAILED in `hostname` $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $1
    exit 1
fi
echo SUCCESS $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $1
sacct -P -n -a --format JobID,User,Group,State,Cluster,AllocCPUS,REQMEM,TotalCPU,Elapsed,MaxRSS,ExitCode,NNodes,NTasks -j $SLURM_JOB_ID
