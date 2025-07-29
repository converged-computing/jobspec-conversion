#!/bin/bash
#SBATCH --account=dasrepo_g
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gpus-per-task=1
#SBATCH --time=00:06:00
#SBATCH --constraint=gpu,ntasks-per-node=1

module load pytorch/1.11.0
mkdir -p ./outlog;
echo $lead30d
echo $memlen
echo $logname
srun python3 LSTM_NN_RMM.py > ./outlog/$logname.txt
