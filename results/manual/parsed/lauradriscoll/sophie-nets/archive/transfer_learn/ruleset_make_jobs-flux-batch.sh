#!/bin/bash
#FLUX: --job-name=ruleset
#FLUX: -t=43200
#FLUX: --urgency=16

rnn_type_array=("LeakyRNN")
activation_array=("softplus")
init_array=("diag")
ruleset_array=("untrained")
for rnn_type in ${rnn_type_array[*]};do
for activation in ${activation_array[*]};do
for init in ${init_array[*]};do
for n_rnn in 256;do
for l2w in -6;do
for l2h in -6;do
for l1w in -0;do
for l1h in -0;do
for seed in {0..5};do #4;do #4;do #4;do #{0..3};do
for lr in -7;do
for sigma_rec in 1;do
for sigma_x in 2;do
for ruleset in ${ruleset_array[*]};do
cat > ruleset_"$rnn_type"_"$activation"_"$init"_"$n_rnn"_"$l2w"_"$l2h"_"$l1w"_"$l1h"_"$seed"_"$lr"_"$sigma_rec"_"$sigma_x"_"$ruleset" << EOF1
ml python/2.7.13
module load py-scipystack/1.0_py27 py-tensorflow/1.9.0_py27
srun python ruleset.py $rnn_type $activation $init $n_rnn $l2w $l2h $l1w $l1h $seed $lr $sigma_rec $sigma_x $ruleset
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
