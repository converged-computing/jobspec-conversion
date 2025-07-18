#!/bin/bash
#FLUX: --job-name=sweep_task
#FLUX: -t=43200
#FLUX: --urgency=16

rnn_type_array=("LeakyRNN")
activation_array=("softplus")
init_array=("randgauss")
ruleset_array=("basic")
for rnn_type in ${rnn_type_array[*]};do
for activation in ${activation_array[*]};do
for init in ${init_array[*]};do
for n_rnn in 128;do
for l2w in -6;do 
for l2h in -6;do 
for l1w in -0;do
for l1h in -0;do
for seed in 6;do
for lr in -6;do 
for sigma_rec in 1;do 
for sigma_x in 2;do 
for pop_rule in 1;do
for ruleset in ${ruleset_array[*]};do
for w_rec_coeff in 9;do
cat > ruleset_sweep_"$rnn_type"_"$activation"_"$init"_"$n_rnn"_"$l2w"_"$l2h"_"$l1w"_"$l1h"_"$seed"_"$lr"_"$sigma_rec"_"$sigma_x"_"$pop_rule"_"$ruleset"_"$w_rec_coeff" << EOF1
ml python/2.7.13
module load py-scipystack/1.0_py27 py-tensorflow/1.9.0_py27
srun python ruleset_sweep.py $rnn_type $activation $init $n_rnn $l2w $l2h $l1w $l1h $seed $lr $sigma_rec $sigma_x $pop_rule $ruleset $w_rec_coeff
deactivate
EOF1
done
done
done
done
done
done
done
done
done
done
done
done
done
done
done
