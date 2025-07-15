#!/bin/bash
#FLUX: --job-name=clair3_train_hg002_v100
#FLUX: -c=12
#FLUX: --queue=v100
#FLUX: -t=7200
#FLUX: --priority=16

singularity exec --nv --overlay /scratch/sc8781/Project/environment/overlay-50G-10M.ext3:rw \
 /scratch/work/public/singularity/cuda9.2.148-cudnn7.6.5.32-devel-ubuntu18.04.6.sif /bin/bash \
 -c "source /ext3/env.sh && /scratch/sb7580/HPMLProject/Clair3Proj/pileup_training_hg002.sh && /bin/bash -norc;"
