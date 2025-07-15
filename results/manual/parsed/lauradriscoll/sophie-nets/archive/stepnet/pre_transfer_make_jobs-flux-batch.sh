#!/bin/bash
#FLUX: --job-name=pre_transfer
#FLUX: -t=259200
#FLUX: --urgency=16

rnn_type_array=("LeakyRNN")
activation_array=("softplus" "retanh")
init_array=("randgauss" "diag")
rule_trains_key_array=("w_all_but_delayanti" "w_all_but_dmsnogo" "w_key_motifs" "wo_key_motifs")
for rnn_type in ${rnn_type_array[*]};do
for activation in ${activation_array[*]};do
for init in ${init_array[*]};do
for n_rnn in 256;do
for l2w in -6;do
for l2h in -6;do
for l1w in 0;do
for l1h in 0;do
for seed in 0;do
for lr in -7;do
for rule_trains_key in ${rule_trains_key_array[*]};do
cat > pre_transfer_"$rnn_type"_"$activation"_"$init"_"$n_rnn"_"$l2w"_"$l2h"_"$l1w"_"$l1h"_"$seed"_"$lr"_"$rule_trains_key" << EOF1
ml python/2.7.13
module load py-scipystack/1.0_py27 py-tensorflow/1.9.0_py27
srun python pre_transfer.py $rnn_type $activation $init $n_rnn $l2w $l2h $l1w $l1h $seed $lr $rule_trains_key
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
