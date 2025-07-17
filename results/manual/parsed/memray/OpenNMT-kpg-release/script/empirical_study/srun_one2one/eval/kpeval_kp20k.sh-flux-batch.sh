#!/bin/bash
#FLUX: --job-name=eval_kp_one2one_kp20k
#FLUX: --queue=high-mem
#FLUX: -t=345600
#FLUX: --urgency=16

srun python kp_gen_eval.py -config config/test/config-test-keyphrase-one2one.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17-one2one/meng17-one2one-kp20k-topmodels/ -output_dir output/keyphrase/meng17-one2one/meng17-one2one-kp20k-topmodels/ -testsets kp20k -gpu -1 -tasks pred
