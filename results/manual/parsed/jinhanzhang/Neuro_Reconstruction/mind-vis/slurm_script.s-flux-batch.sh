#!/bin/bash
#FLUX: --job-name=jzfov
#FLUX: -t=14340
#FLUX: --urgency=16

singularity exec --nv --overlay /scratch/jz5952/neuro-recon-stimuli-env/overlay-25GB-500K.ext3:ro /scratch/work/public/singularity/cuda12.3.2-cudnn9.0.0-ubuntu-22.04.4.sif /bin/bash -c "source /ext3/env.sh && cd /scratch/jz5952/mind-vis && python code/stageA1_mbm_pretrain.py --num_epoch 200 --model_name MAEforFMRI"
