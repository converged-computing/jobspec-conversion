#!/bin/bash
#SBATCH --output=/scratch/users/ladmon/3D/results/%A_%a_terminal.out
#SBATCH --mail-user=ladmon@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2-00:00:00
#SBATCH --array=1-100

module load gcc #for slac cluster
./simulate -s PLANE --pmin 0.01 --pmax 0.01 --qmin 0 --qmax 0 --Np 1 --Nq 1 -n 1000000 --lmin 3 --lmax 19 -v 1 -N INDEP --fname "/scratch/users/ladmon/3D/results/${SLURM_ARRAY_JOB_ID}_$SLURM_ARRAY_TASK_ID.out"
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
echo "node list:" "$SLURM_JOB_NODELIST"
echo "node list:" "$SLURM_JOB_NODELIST"
