#!/bin/bash
#FLUX: --job-name=cluster
#FLUX: -c=4
#FLUX: --queue=cs
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
singularity exec $nv \
            --overlay /scratch/$USER/my_env/overlay-15GB-500K.ext3:ro \
            /scratch/wz2247/singularity/images/pytorch_22.08-py3.sif  \
            /bin/bash -c "source /ext3/miniconda3/bin/activate;
            python /scratch/$USER/DSGA_1006_capstone/scripts/clustering_for_all.py $SLURM_ARRAY_TASK_ID"
