#!/bin/bash
#FLUX: --job-name=frigid-nalgas-8881
#FLUX: --exclusive
#FLUX: --queue=n1s16-t4-2
#FLUX: -t=72000
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

/share/apps/local/bin/p2pBandwidthLatencyTest > /dev/null 2>&1
set -x 
mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
cp -rp /scratch/DL21SP/student_dataset.sqsh /tmp
echo "Dataset is copied to /tmp"
cd $HOME/NYU_DL_comp/moco/
singularity exec --nv \
--bind /scratch \
--overlay /scratch/DL21SP/conda.sqsh:ro \
--overlay /tmp/student_dataset.sqsh:ro \
/share/apps/images/cuda11.1-cudnn8-devel-ubuntu18.04.sif \
/bin/bash -c "
source /ext3/env.sh
conda activate dev
CUDA_VISIBLE_DEVICES=0,1 python3 main_moco.py   -a resnet50   --lr 0.06 --batch-size 512   --dist-url 'tcp://localhost:10004' --multiprocessing-distributed --world-size 1 --rank 0 -data /dataset --mlp --moco-t 0.2 --aug-plus --cos  --workers 4 --checkpoint_dir $SCRATCH/checkpoints/moco --resume $SCRATCH/checkpoints/moco/moco_unsupervised_0090.pth.tar 
"
