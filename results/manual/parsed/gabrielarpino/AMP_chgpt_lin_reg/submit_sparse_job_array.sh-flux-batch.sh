#!/bin/bash
#FLUX: --job-name=chocolate-nunchucks-4738
#FLUX: -t=43200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-icl
module load python/3.8.11/gcc/pqdmnzmw
source ~/.bashrc # this is needed for conda activate, deactivate to work
source ~/rds/hpc-work/chgpts_venv_v1/bin/activate
application="~/rds/hpc-work/chgpts_venv_v1/bin/python3.8"
save_path=/home/xl394/rds/hpc-work/AMP/hpc_results/$SLURM_ARRAY_JOB_ID/
mkdir -p "$save_path"
options="hpc_comparison_sparse.py --save_path "$save_path" \
    --num_delta 10 --delta_idx $SLURM_ARRAY_TASK_ID \
    --p 200 --sigma 0.1 --alpha 0.5 \
    --L 3 Lmax 4 --frac_Delta 0.03 --num_trials 15"
workdir=~/rds/hpc-work/AMP  
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
CMD="$application $options"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
