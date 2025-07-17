#!/bin/bash
#FLUX: --job-name=swampy-house-6847
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

uname -a                                          # Display assigned cluster info
srun echo "I am on"
srun echo $HOSTNAME
srun echo "I got gpu number"
srun echo $CUDA_VISIBLE_DEVICES
srun nvidia-docker run --rm -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets -v /storage2/datasets:/storage2/datasets -v /local:/local -v /home/$USER:/home/$USER -v /storage1:/storage1 madratman/deeprl_hw /bin/bash -c /home/ratneshm/slurm_deeprl/meta_scripts/2.sh
