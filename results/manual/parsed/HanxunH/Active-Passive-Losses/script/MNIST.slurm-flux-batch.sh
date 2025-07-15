#!/bin/bash
#FLUX: --job-name=moolicious-poo-3999
#FLUX: -c=8
#FLUX: --queue=gpgpu
#FLUX: -t=172800
#FLUX: --urgency=16

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
    rm -rf ${exp_name}/mnist/sym/$i/${loss}/*
    python3 -u main.py --exp_name ${exp_name}/mnist/sym/$i --seed $seed --noise_rate $i --config_path configs/mnist/sym --version ${loss}
done
declare -a nr_arr=(
                   "0.1"
                   "0.2"
                   "0.3"
                   "0.4"
                  )
for i in "${nr_arr[@]}"
    do
      rm -rf ${exp_name}/mnist/asym/$i/${loss}/*
      python3 -u main.py --exp_name ${exp_name}/mnist/asym/$i --seed $seed --noise_rate $i --config_path configs/mnist/asym --version ${loss} --asym
done
