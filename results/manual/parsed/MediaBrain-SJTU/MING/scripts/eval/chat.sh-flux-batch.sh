#!/bin/bash
#FLUX: --job-name=misunderstood-lamp-0770
#FLUX: -c=32
#FLUX: --queue=medai_llm
#FLUX: -t=432000
#FLUX: --urgency=16

srun --jobid $SLURM_JOBID python ming/serve/cli.py \
    --model_path /mnt/petrelfs/liaoyusheng/oss/download_models/MING-7B \
    --conv_template bloom \
    --max_new_token 512 \
    --beam_size 3 \
    --temperature 1.2
