#!/bin/bash
#FLUX: --job-name=dirty-arm-5725
#FLUX: -N=4
#FLUX: -t=259200
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='0'

echo "$0"
printf "%s" "$(<$0)"
echo ""
env
echo $SLURM_JOB_NODELIST
nodes="$(scontrol show hostname $SLURM_JOB_NODELIST | paste -d, -s)"
echo ${nodes}
for node in ${nodes//,/ } 
do
    ssh ${node} 'timeout 2400 nvidia-smi -l 1 -f '${PWD}'/nvidia.'${SLURM_JOB_ID}'.${HOSTNAME}.txt' &
done
echo "git commit"
git --git-dir=$PWD/disruptcnn/.git  show --oneline -s
export CUDA_LAUNCH_BLOCKING=0
file="file:///scratch/gpfs/rmc2/main_${SLURM_JOB_ID}.txt"
fileprof="profile_${SLURM_JOB_ID}_rank_${SLURM_PROCID}.prof"
srun -n 16 python -u disruptcnn/main.py --dist-url $file --backend 'nccl' \
                    --batch-size=12 --dropout=0.1 --clip=0.3 \
                    --lr=0.5 \
                    --workers=6 \
                    --nsub 78125 \
                    --epochs=1500 \
                    --label-balance='const' \
                    --data-step=10 --levels=4 --nrecept=30000 --nhid=80 \
                    --undersample \
                    --iterations-valid 60
