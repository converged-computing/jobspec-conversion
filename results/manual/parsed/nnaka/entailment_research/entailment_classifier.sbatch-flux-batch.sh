#!/bin/bash
#FLUX: --job-name=doopy-fudge-2804
#FLUX: -N=3
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
singularity exec --nv \
	    --overlay /scratch/nn1331/entailment/entailment.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python entailment_classifier.py"
