#!/bin/bash
#FLUX: --job-name=eval_kp_one2one_duc
#FLUX: --queue=smp
#FLUX: -t=518400
#FLUX: --urgency=16

python kp_gen_eval.py -config config/test/config-test-keyphrase.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17/ -output_dir output/keyphrase/meng17/ -testsets duc -gpu -1
