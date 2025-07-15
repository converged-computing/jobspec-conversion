#!/bin/bash
#FLUX: --job-name=ornery-leopard-3729
#FLUX: --priority=16

export MASTER_PORT='12698'
export WORLD_SIZE='4'
export MASTER_ADDR='$master_addr'
export NCCL_SOCKET_IFNAME='^lo,docker,virbr,vmnet,vboxnet,wl,ww,ppp'
export NCCL_DEBUG='INFO'
export DATADIR='$SLURM_SUBMIT_DIR/'

module load Anaconda3/2020.11
module load cuDNN/8.1.1.33-CUDA-11.2.1
source activate yoz
export MASTER_PORT=12698
export WORLD_SIZE=4
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
export NCCL_SOCKET_IFNAME="^lo,docker,virbr,vmnet,vboxnet,wl,ww,ppp"
export NCCL_DEBUG=INFO
export DATADIR=$SLURM_SUBMIT_DIR/
srun --export=ALL python TrnTstFaceSkin.py -p'./myout_cohfaceface_37P2minto1min_clean.csv' -s './myout_cohfaceskin_37P2minto1min_clean.csv' -m 'test1_cohface_clean37P_2minto1min_SkinFacenormsbest_corrstdbvp_32_492real72_Dmetanh_dp50_dpe50_500e_0.0001l_128bs_sgdwtd0.0001_bvp.pt' -lr 0.0001 -e 500 -opt 'SGD'
