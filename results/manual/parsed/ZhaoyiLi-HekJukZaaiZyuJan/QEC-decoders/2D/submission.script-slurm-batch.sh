#!/bin/bash
#SBATCH --output=results/%A_%a_terminal.out
#SBATCH --mail-user=ladmon@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00
#SBATCH --array=1-100

ml py-tensorflow/2.6.2_py36
module load gcc/10.1.0
./simulate -s TORUS --pmin 0 --pmax 0.15 --Np 30 -n 10000 --Lmin 3 --Lmax 21 -v 1 --fname 'results/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.out'
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID" "$SLURM_ARRAY_TASK_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
