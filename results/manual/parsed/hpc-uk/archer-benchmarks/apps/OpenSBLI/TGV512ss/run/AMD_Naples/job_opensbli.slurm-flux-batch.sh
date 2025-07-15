#!/bin/bash
#FLUX: --job-name=delicious-platanos-9251
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
application="/scratch_lustre_DDN7k/xguox/opensbli/Benchmark/OpenSBLI_mpi"
options=""
workdir="$SLURM_SUBMIT_DIR" 
np=$[${numnodes}*${mpi_tasks_per_node}]
export OMP_NUM_THREADS=1
CMD="srun -n $np $application $options"
cd $workdir
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Current directory: `pwd`"
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
timestamp=$(date '+%Y%m%d%H%M')
srun -n $np $application $options> output_${numnodes}nodes_${timestamp}.txt 2> stderr.txt
