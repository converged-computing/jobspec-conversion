#!/bin/bash
#SBATCH --job-name=cuda_4_calmip_test
#SBATCH --mail-user=paul.karlshoefer@atos.net
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=20000
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=16

echo $SLURM_JOB_NODELIST
module load cuda/10.1.105
nvprof -o prof_v2 ./main
echo "done"
