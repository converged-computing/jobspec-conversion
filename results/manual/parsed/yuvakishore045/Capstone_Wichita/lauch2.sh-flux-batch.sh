#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=4
#FLUX: --queue=wsu_gen_gpu.q
#FLUX: -t=216000
#FLUX: --urgency=16

module load Python/3.9.6-GCCcore-11.2.0
source /home/p793x363/Documents/test/bin/activate
python Wav2vec2.py  #run python script
