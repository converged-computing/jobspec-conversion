#!/bin/bash
#FLUX: --job-name=eval_kp_one2many_nus
#FLUX: --queue=smp
#FLUX: -t=518400
#FLUX: --urgency=16

python kp_run_eval.py -config script/srun_one2many/kpeval-beam50-maxlen40/config-test-keyphrase-one2many.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17/ -output_dir output/keyphrase/meng17-one2many-beam50-maxlen40/ -gpu -1 -testsets nus
