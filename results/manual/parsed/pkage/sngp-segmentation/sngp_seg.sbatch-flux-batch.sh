#!/bin/bash
#FLUX: --job-name=sngp_seg
#FLUX: -c=64
#FLUX: --queue=disc
#FLUX: -t=34200
#FLUX: --priority=16

export PROJ_DIR='/ourdisk/hpc/ai2es/jroth/sngp_seg/'
export LSCRATCH='/lscratch/$SLURM_JOB_ID'
export OMP_NUM_THREADS='16'

export PROJ_DIR=/ourdisk/hpc/ai2es/jroth/sngp_seg/
export LSCRATCH=/lscratch/$SLURM_JOB_ID
cd $PROJ_DIR
poetry install
if ! [ -f ./IN1K-vit.h.14-300e.pth.tar ]; then
    echo "vit not found, downloading..."
    curl -L -O -J https://dl.fbaipublicfiles.com/ijepa/IN1K-vit.h.14-300e.pth.tar
else
    echo "vit has been downloaded already"
fi
if ! [ -f ./VOCtrainval_11-May-2012.tar ]; then
    echo "voc not found, downloading..."
    curl -L -O -J http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar
else
    echo "voc has been downloaded already"
fi
export OMP_NUM_THREADS=16
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
echo Node IP: $head_node_ip
. /home/fagg/tf_setup.sh
conda activate /home/jroth/.conda/envs/torch
source .env
srun torchrun \
--nnodes $SLURM_JOB_NUM_NODES \
--nproc_per_node 2 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint "$head_node_ip:64425" \
main_ddp.py
