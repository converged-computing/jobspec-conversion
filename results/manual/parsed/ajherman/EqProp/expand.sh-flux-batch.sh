#!/bin/bash
#FLUX: --job-name=main
#FLUX: -t=36000
#FLUX: --priority=16

epochs=50
cores=10
beta=0.2
T1=8
T2=3
hidden_size=256
batch_size=20
tau_dynamic=0.2
omega=1
max_fr=6
for M in {1,8,16,32} # 1,4,8,16,32
do
for omega in {1,4096} # 1,4096
do
fast_stdp_dir=fast_stdp_M_"$M"_omega_"$omega"
slow_stdp_dir=slow_stdp_M_"$M"_omega_"$omega"
slug_stdp_dir=slug_stdp_M_"$M"_omega_"$omega"
mkdir -p $fast_stdp_dir
mkdir -p $slow_stdp_dir
mkdir -p $slug_stdp_dir
srun -N 1 -n 1 -c $((M*2)) -o "$fast_stdp_dir".out --open-mode=append ./main_wrapper.sh --M $M --spiking --load --use-time-variables --directory $fast_stdp_dir --omega $omega --max-fr $max_fr --spike-method binomial --tau-dynamic $tau_dynamic --tau-trace 0.2 --action train --batch-size $batch_size --activation-function hardsigm --size_tab 10 $hidden_size 784 --lr_tab 0.0028 0.0056 --epochs $epochs --T1 $T1 --T2 $T2 --beta $beta --cep --update-rule stdp &
srun -N 1 -n 1 -c $((M*2)) -o "$slow_stdp_dir".out --open-mode=append ./main_wrapper.sh --M $M --spiking --load --use-time-variables --directory $slow_stdp_dir --omega $omega --max-fr $max_fr --spike-method binomial --tau-dynamic $tau_dynamic --tau-trace 0.5 --action train --batch-size $batch_size --activation-function hardsigm --size_tab 10 $hidden_size 784 --lr_tab 0.0028 0.0056 --epochs $epochs --T1 $T1 --T2 $T2 --beta $beta --cep --update-rule stdp &
srun -N 1 -n 1 -c $((M*2)) -o "$slug_stdp_dir".out --open-mode=append ./main_wrapper.sh --M $M --spiking --load --use-time-variables --directory $slug_stdp_dir --omega $omega --max-fr $max_fr --spike-method binomial --tau-dynamic $tau_dynamic --tau-trace 0.8 --action train --batch-size $batch_size --activation-function hardsigm --size_tab 10 $hidden_size 784 --lr_tab 0.0028 0.0056 --epochs $epochs --T1 $T1 --T2 $T2 --beta $beta --cep --update-rule stdp &
done
done
