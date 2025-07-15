#!/bin/bash
#FLUX: --job-name=mpi_omp_job_2_nodes
#FLUX: -n=14
#FLUX: -c=10
#FLUX: --queue=defq
#FLUX: -t=600
#FLUX: --urgency=16

module load openmpi/4.1.5-gcc-11.2.0-ux65npg
allocated_nodes_info=$(scontrol show job "$SLURM_JOBID" | grep -E "NodeCnt=|CPUTasksPerNode=|ReqNodeList=")
echo "Allocated Node Information:"
echo "$allocated_nodes_info"
output_dir="output_directory_2_nodes${SLURM_ARRAY_TASK_ID}"
mkdir -p "$output_dir"
command="srun -n $SLURM_ARRAY_TASK_ID ./sim $output_dir"
echo "Running $command"
$command
