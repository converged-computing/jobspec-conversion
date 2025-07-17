#!/bin/bash
#FLUX: --job-name=fat-noodle-7715
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=n1c24m128-v100-4
#FLUX: -t=54000
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
cp -rp /scratch/DL22SP/unlabeled_224.sqsh /tmp
cp -rp /scratch/DL22SP/labeled.sqsh /tmp
echo "Dataset is copied to /tmp"
singularity exec --nv \
--bind /scratch \
--overlay /scratch/DL22SP/conda.ext3:ro \
--overlay /tmp/unlabeled_224.sqsh \
--overlay /tmp/labeled.sqsh \
/share/apps/images/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
source /ext3/env.sh
conda activate
python -m torch.distributed.launch --nproc_per_node=4 main_vicreg.py --data-dir /unlabeled --exp-dir /home/ag7654/multiple_run_04_24_2022_16_40/ --arch resnet50 --epochs 20 --batch-size 256 --base-lr 0.3
python -m torch.distributed.launch --nproc_per_node=4 main_vicreg.py --data-dir ../unlabeled_data --exp-dir ./outputs --arch resnet50 --epochs 20 --batch-size 256 --base-lr 0.3
"
