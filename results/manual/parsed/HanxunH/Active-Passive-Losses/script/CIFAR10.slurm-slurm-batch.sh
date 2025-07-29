#!/bin/bash
#SBATCH --account=punim0784
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/robust_loss_nips
module load Python/3.6.4-intel-2017.u2-GCC-6.2.0-CUDA10
nvidia-smi
exp_name=$1
seed=$2
loss=$3
declare -a nr_arr=("0.0"
                   "0.2"
                   "0.4"
                   "0.6"
                   "0.8")
for i in "${nr_arr[@]}"
    do
    rm -rf ${exp_name}/cifar10/sym/$i/${loss}/*
    python3 -u main.py --exp_name ${exp_name}/cifar10/sym/$i --seed $seed --noise_rate $i --config_path configs/cifar10/sym --version ${loss}
done
declare -a nr_arr=(
                   "0.1"
                   "0.2"
                   "0.3"
                   "0.4"
                  )
for i in "${nr_arr[@]}"
    do
      rm -rf ${exp_name}/cifar10/asym/$i/${loss}/*
      python3 -u main.py --exp_name ${exp_name}/cifar10/asym/$i --seed $seed --noise_rate $i --config_path configs/cifar10/asym --version ${loss}
done
