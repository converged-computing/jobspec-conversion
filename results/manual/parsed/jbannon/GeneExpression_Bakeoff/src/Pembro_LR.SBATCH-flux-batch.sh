#!/bin/bash
#FLUX: --job-name=Pembro_LR
#FLUX: -N=2
#FLUX: -c=2
#FLUX: -t=345600
#FLUX: --priority=16

module purge
settings=(STAD.MC STAD.LOO SKCM.MC SKCM.LOO PANCAN.MC PANCAN.LOO)
singularity exec --nv \
            --overlay /scratch/jjb509/GeneExpression_Bakeoff/src/my_overlay.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh; python permutation_test.py -drug Pembro -model LogisticRegression -settings ${settings[$SLURM_ARRAY_TASK_ID]}"
