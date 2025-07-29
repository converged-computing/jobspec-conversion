#!/bin/bash
#SBATCH --job-name=parallel_onenode_v2
#SBATCH --account=ebf11-fa23
#SBATCH --output=parallel_onenode_v2_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=4

echo "Starting job $SLURM_JOB_NAME"
echo "Job id: $SLURM_JOB_ID"
date
echo "This job was assigned the following nodes"
echo $SLURM_NODELIST
echo "Activing environment with that provides Julia 1.9.2"
source /storage/group/RISE/classroom/astro_528/scripts/env_setup
echo "About to change into $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR            # Change into directory where job was submitted from
date
echo "About to start Julia, using $SLURM_TASKS_PER_NODE worker processes on assigned node"
julia --project=. -p $SLURM_TASKS_PER_NODE parallel_v2.jl
echo "Julia exited"
date
