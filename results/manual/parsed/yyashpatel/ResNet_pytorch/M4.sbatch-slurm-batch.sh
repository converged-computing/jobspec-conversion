#!/bin/bash
#FLUX: --job-name=M4
#FLUX: -c=16
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main.py -en 17 -o sgd -dp ./data -b 2 2 2 2 -c 72 110 196 308"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main2.py -en 18 -o sgd -dp ./data -b 2 2 2 2 -c 42 84 168 336"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main3.py -en 19 -o sgd -dp ./data -b 2 2 2 2 -c 42 84 168 336"
