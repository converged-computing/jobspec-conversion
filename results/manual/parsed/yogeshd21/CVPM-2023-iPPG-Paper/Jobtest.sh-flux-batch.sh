#!/bin/bash
#FLUX: --job-name=red-sundae-9498
#FLUX: --priority=16

export MASTER_PORT='21621'
export WORLD_SIZE='4'
export MASTER_ADDR='$master_addr'
export NCCL_SOCKET_IFNAME='^lo,docker,virbr,vmnet,vboxnet,wl,ww,ppp'
export NCCL_DEBUG='INFO'
export DATADIR='$SLURM_SUBMIT_DIR/'

module load Anaconda3/2020.11
module load cuDNN/8.1.1.33-CUDA-11.2.1
source activate yoz
export MASTER_PORT=21621
export WORLD_SIZE=4
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
export NCCL_SOCKET_IFNAME="^lo,docker,virbr,vmnet,vboxnet,wl,ww,ppp"
export NCCL_DEBUG=INFO
export DATADIR=$SLURM_SUBMIT_DIR/
srun --export=ALL python Testmodel.py -p './myoutcohfaceframesinface_3min_2minto1min_clean_derstd.csv' -m 'testcohface_clean_derstd_31P_3min_2minto1min_CorrectedFramesinfacenormsbest_allcorrboth_e48_1.0lr_adel_bvp_Itrbicu.pt' -lr 1.0 -e 48 -opt 'Adadelta'
