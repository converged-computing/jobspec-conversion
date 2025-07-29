#!/bin/bash
#FLUX: --job-name=resnet18_pokemon
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'

module purge
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
singularity exec --nv \
	    --overlay /scratch/sg7729/hpml/my_pytorch2.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python /scratch/sg7729/DL_project/Classifier/VGG.py"
