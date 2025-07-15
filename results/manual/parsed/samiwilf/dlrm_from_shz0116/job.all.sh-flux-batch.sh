#!/bin/bash
#FLUX: --job-name=testdlrm
#FLUX: -n=8
#FLUX: --exclusive
#FLUX: -t=2400
#FLUX: --urgency=16

echo $SLURM_NODELIST
echo $SLURM_NODELIST > hostfile1
source /private/home/hongzhang/.zshrc
conda activate mytorch
which python3
large_arch_emb_usr=$(printf '260%.0s' {1..815})
large_arch_emb_usr=${large_arch_emb_usr//"02"/"0-2"} 
large_arch_emb_ads=$(printf '140%.0s' {1..544}) 
large_arch_emb_ads=${large_arch_emb_ads//"01"/"0-1"}
large_arch_emb="$large_arch_emb_usr-$large_arch_emb_ads"
/public/apps/openmpi/4.0.2/gcc.7.4.0/bin/mpirun -prefix /public/apps/openmpi/4.0.2/gcc.7.4.0/ -v -np 8 python3 dlrm_s_pytorch.py --arch-sparse-feature-size=64 --arch-mlp-bot="2000-1024-1024-1024-1024-1024-1024-1024-1024-1024-1024-512-64" --arch-mlp-top="4096-4096-4096-4096-4096-4096-4096-4096-4096-4096-4096-4096-4096-1" --arch-embedding-size=$large_arch_emb --data-generation=synthetic --loss-function=bce --round-targets=True --learning-rate=0.1 --mini-batch-size=2048 --print-freq=1 --print-time --test-mini-batch-size=10240 --test-num-workers=16 --use-gpu --dist-backend='nccl' --num-indices-per-lookup-fixed=1 --num-indices-per-lookup=28 --num-batches=4 --arch-project-size=30
