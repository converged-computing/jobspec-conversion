#!/bin/bash
#FLUX: --job-name=infer
#FLUX: -t=7199
#FLUX: --urgency=16

module purge
MODEL=2
NUM_LOOPS=100
singularity exec --nv \
            --overlay /vast/bc3194/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif\
            /bin/bash -c "source /ext3/env.sh; export TRANSFORMERS_CACHE='/vast/bc3194/huggingface_cache'; python -u testcase.py --model=$MODEL --num_loops=$NUM_LOOPS --pass_at=$SLURM_ARRAY_TASK_ID"
