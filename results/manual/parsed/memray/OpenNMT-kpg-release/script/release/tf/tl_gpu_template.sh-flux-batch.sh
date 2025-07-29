#!/bin/bash
#FLUX: --job-name={job_name}
#FLUX: --queue={partition}
#FLUX: --urgency=16

source ~/.bash_profile # reload LD_LIBRARY due to error ImportError: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found
cmd="/ihome/hdaqing/rum20/anaconda3/envs/kp/bin/python3.7 kp_gen_eval_transfer.py -config config/transfer_kp/infer/keyphrase-one2seq-controlled.yml -tasks {task_args} -data_dir /zfs1/hdaqing/rum20/kp/data/kp/json/ -exp_root_dir {exp_root_dir} -testsets {dataset_args} -splits {split} -batch_size {batch_size} -beam_size {beam_size} -max_length {max_length} -beam_terminate full --step_base {step_base} --data_format jsonl -gpu 0"
echo $cmd
echo $PWD
$cmd
