#!/bin/bash
#FLUX: --job-name=eval_one2one_v2_kp20k
#FLUX: --queue=smp
#FLUX: -t=259200
#FLUX: --urgency=16

python kp_gen_eval.py -config config/test/config-test-keyphrase-one2one.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17-one2one/meng17-one2one-kp20k-v2/ -output_dir output/keyphrase/meng17-one2one/meng17-one2one-kp20k-v2/ -testsets kp20k -gpu -1 -tasks pred
