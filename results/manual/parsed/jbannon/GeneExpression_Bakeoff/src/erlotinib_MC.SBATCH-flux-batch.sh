#!/bin/bash
#FLUX: --job-name=SVM_Array
#FLUX: -N=2
#FLUX: -c=2
#FLUX: -t=345600
#FLUX: --priority=16

module purge
models=(LogisticRegression RandomForest Poly_SVC RBF_SVC Linear_SVC)
singularity exec --nv \
            --overlay /scratch/jjb509/GeneExpression_Bakeoff/src/my_overlay.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh; python monte_carlo.py --drug erlotinib --model ${models[$SLURM_ARRAY_TASK_ID]} --niter 100"
