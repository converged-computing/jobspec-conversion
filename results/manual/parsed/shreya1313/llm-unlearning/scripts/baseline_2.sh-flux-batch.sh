#!/bin/bash
#FLUX: --job-name=unlearning
#FLUX: -t=43200
#FLUX: --priority=16

module purge
singularity exec --nv \
	    --overlay /scratch/sg7729/my_env/overlay-15GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python /scratch/sg7729/machine-unlearning/unlearn_harm.py --model_name=facebook/opt-1.3b --model_save_dir=/scratch/sg7729/machine-unlearning/models/opt1.3b_unlearned --log_file=/scratch/sg7729/machine-unlearning/logs/opt-1.3b-unlearn.log"
