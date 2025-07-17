#!/bin/bash
#FLUX: --job-name=visuals
#FLUX: -t=3600
#FLUX: --urgency=16

singularity exec \
	--overlay /scratch/aeb783/pangeo/pytorch1.7.0-cuda11.0.ext3:ro \
	/scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
	bash -c "source /ext3/env.sh;
python -u /home/aeb783/mom6/MOM6-examples/scripts/MOM_ss_visuals.py"
