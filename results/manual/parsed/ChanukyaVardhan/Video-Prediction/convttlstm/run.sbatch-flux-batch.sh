#!/bin/bash
#FLUX: --job-name=convttlst
#FLUX: -c=24
#FLUX: -t=36000
#FLUX: --priority=16

module purge
singularity exec --nv \
	    --overlay /scratch/snm6477/singu/my_pytorch.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "
source /ext3/env.sh
cd /scratch/snm6477/github/DL_Competition/convttlstm
python3 -m torch.distributed.launch --nproc_per_node=2 model_train.py --use_distributed --batch_size=4 --no_sigmoid --valid_samples=500 --num_epochs=10 --future_frames=11 --output_frames=11 --use_amp --gradient_clipping --train_samples_epoch 3000
"
