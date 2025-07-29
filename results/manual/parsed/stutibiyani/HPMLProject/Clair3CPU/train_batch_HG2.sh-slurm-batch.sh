#!/bin/bash
#FLUX: --job-name=hpml_proj_Clair3_train_HG002
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --urgency=16

singularity exec --overlay /scratch/sc8781/Project/environment/overlay-50G-10M.ext3:rw \
 /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif /bin/bash \
 -c "source /ext3/env.sh && /scratch/sc8781/Project/Clair3Proj/pileup_training_HG2.sh && /bin/bash -norc;"
