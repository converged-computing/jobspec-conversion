#!/bin/bash
#FLUX: --job-name=nerve-mrcnn
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
unset XDG_RUNTIME_DIR
if [ "$SLURM_JOBTMP" != "" ]; then
    export XDG_RUNTIME_DIR=$SLURM_JOBTMP
fi
singularity exec --nv /beegfs/work/public/singularity/cuda-9.0-cudnn7-devel-ubuntu16.04.simg bash -c "source /home/jtb470/.bashrc && conda activate nerve-mrcnn && python tools/train_net.py --config-file 'configs/nerve-101.yaml' OUTPUT_DIR final"
