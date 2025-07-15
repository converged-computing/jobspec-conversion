#!/bin/bash
#FLUX: --job-name="scann"
#FLUX: --exclusive
#FLUX: --queue=dphys_compute
#FLUX: -t=7200
#FLUX: --priority=16

echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "Running on $SLURM_JOB_CPUS_PER_NODE cpus per node."
echo "Current working directory is `pwd`"
cd $HOME
path=$1
length=160
jobs_per_node=16
module load python/2.7.6-gcc-4.8.1
index_node=${SLURM_ARRAY_TASK_ID}
cd /users/sibirrer/Lenstronomy/lenstronomy/Sensitivity/
pids=""
for i in `seq 0 $jobs_per_node`; do
    index=$((index_node*jobs_per_node+i))
    srun -n 1 python monch_array_script.py $path $index $length &
    pids="$pids $!"
done
wait $pids
echo "Ending at `date`"
