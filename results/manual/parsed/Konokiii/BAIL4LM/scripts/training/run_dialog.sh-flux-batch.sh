#!/bin/bash
#FLUX: --job-name=BAIL_Dialog
#FLUX: --queue=n1s16-v100-2
#FLUX: -t=86400
#FLUX: --urgency=16

singularity exec --bind /scratch --nv --overlay /scratch/zd662/overlay-25GB-500K.ext3:rw /scratch/zd662/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate rl4lm
python ./train_text_generation.py --config_path ./task_configs/dialog/gpt2_bail.yml
"
