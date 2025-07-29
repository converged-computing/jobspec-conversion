#!/bin/bash
#FLUX: --job-name=moco_800ep
#FLUX: -N=8
#FLUX: -c=8
#FLUX: -t=252000
#FLUX: --urgency=16

export NCCL_SOCKET_IFNAME='^docker0,lo'

module load anaconda3
source activate ssl_runs
DATADIR=$1
OUTDIR=$2
OUTDIR+='/moco_800ep'
mkdir -p ${OUTDIR}
export NCCL_SOCKET_IFNAME=^docker0,lo
master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40056
echo "disturl:" ${dist_url}
srun --label python  main_moco.py \
                    -a resnet50 \
                    --lr 0.24 \
                    --batch-size 2048 \
                    --dist-url ${dist_url} \
                    --multiprocessing-distributed \
                    --world-size 8 --rank 0  \
                    --epochs 800 --workers 8 \
                    --mlp --moco-t 0.2 --aug-plus --cos \
                    --dump_path ${OUTDIR} \
                    ${DATADIR}
