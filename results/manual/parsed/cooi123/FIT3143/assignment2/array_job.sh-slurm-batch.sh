#!/bin/bash
#SBATCH --job-name=mpi_omp_job_2_nodes
#SBATCH --output=node_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=16G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=14
#SBATCH --array=3-14

module load openmpi/4.1.5-gcc-11.2.0-ux65npg
allocated_nodes_info=$(scontrol show job "$SLURM_JOBID" | grep -E "NodeCnt=|CPUTasksPerNode=|ReqNodeList=")
echo "Allocated Node Information:"
echo "$allocated_nodes_info"
output_dir="output_directory_2_nodes${SLURM_ARRAY_TASK_ID}"
mkdir -p "$output_dir"
command="srun -n $SLURM_ARRAY_TASK_ID ./sim $output_dir"
echo "Running $command"
$command
