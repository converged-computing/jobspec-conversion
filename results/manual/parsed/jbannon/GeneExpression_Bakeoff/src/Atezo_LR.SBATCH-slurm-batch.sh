#!/bin/bash
#FLUX: --job-name=Atezo_LR
#FLUX: -N=2
#FLUX: -c=2
#FLUX: -t=345600
#FLUX: --urgency=16

module purge
settings=(KIRC.LOO KIRC.MC BLCA.LOO BLCA.MC PANCAN.LOO PANCAN.MC)
singularity exec --nv \
            --overlay /scratch/jjb509/GeneExpression_Bakeoff/src/my_overlay.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh; python permutation_test.py -drug Atezo -model LogisticRegression -settings ${settings[$SLURM_ARRAY_TASK_ID]}"
