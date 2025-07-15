#!/bin/bash
#FLUX: --job-name=blue-cat-5805
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

MASTER=`/bin/hostname -s`
SLAVES=`scontrol show hostnames $SLURM_JOB_NODELIST | grep -v $MASTER`
HOSTLIST="$MASTER $SLAVES"
echo "Master: $MASTER"
echo "Slaves: $SLAVES"
cd /home/users/m/mandadoalmajano/dev
source /home/users/m/mandadoalmajano/.venvs/meshcnn/bin/activate
type python
MPORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()');
echo "Master port: $MPORT"
COMMAND="train.py --dataroot datasets/abc_10K_rem2K_aug --name abc_10K_rem2K_aug --arch meshunet --dataset_mode segmentation --ncf 32 64 128 256 512 --ninput_edges 2000 --pool_res 1600 1280 1024 850 --resblocks 3 --lr 0.002 --batch_size 16 --num_aug 1 --gpu_ids 0,1 --continue_train"
RANK=0
set -x
for node in $HOSTLIST; do
        srun -N 1 -n 1 --nodelist=$node \
                python -m torch.distributed.launch \
                --nproc_per_node 2 \
                --nnodes $SLURM_JOB_NUM_NODES \
                --node_rank $RANK \
                --master_addr "$MASTER" --master_port "$MPORT" --use_env \
                $COMMAND &
        RANK=$((RANK+1))
done
wait
exitCode=$?
echo "done training. Exit code was $exitCode"
deactivate
exit $exitCode
