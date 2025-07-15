#!/bin/bash
#FLUX: --job-name=valgrind3
#FLUX: -c=2
#FLUX: --queue=gpu_p
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ml CUDA/10.0.130
ml GCCcore/6.4.0
valgrind --error-exitcode=1 --tool=memcheck --errors-for-leak-kinds=definite --leak-check=full --show-leak-kinds=all bin/SFM -d /work/demlab/sfm/SSRLCV-Sample-Data/everest1024/3view -s /work/demlab/sfm/SSRLCV-Sample-Data/seeds/seed_spongebob.png
