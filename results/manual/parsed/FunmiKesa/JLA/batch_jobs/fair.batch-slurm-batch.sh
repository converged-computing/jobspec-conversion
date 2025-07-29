#!/bin/bash
#FLUX: --job-name=fair
#FLUX: --queue=pearl
#FLUX: -t=420
#FLUX: --urgency=16

MASTER=`/bin/hostname -s`
echo $MASTER
MASTER_PORT=`comm -23 <(seq 49000 65535 | sort) <(ss -tan | awk '{print $4}' | cut -d':' -f2 | grep '[0-9]{1,5}' | sort -u)| shuf | head -n 1`
echo $MPORT
singularity exec \
        --nv -w \
	    ../transfer sh -c "cd src && python train.py mot --exp_id debug --arch rnnforecast_34 --load_model ../models/ctdet_coco_dla_2x.pth --data_cfg ../src/lib/cfg/mot17.json --batch_size 16 --num_workers 8 --gpus 0,1 --num_epochs 60 --forecast --use_embedding --multiprocessing_distributed --rank 0 --dist-url tcp://$MASTER:$MASTER_PORT --dist-backend nccl --world-size 1"
singularity exec         --nv -w     ../transfer sh -c "cd src && OMP_NUM_THREADS=1 python train.py mot --exp_id optim_mot_17 --arch rnnforecast_34 --load_model ../exp/mot/optim_mot_17/model_last.pth --data_cfg ../src/lib/cfg/mot17.json --batch_size 24 --num_workers 16 --gpus 0,1,2,3 --num_epochs 60 --forecast --use_embedding --multiprocessing_distributed --rank 0 --dist-url tcp://$MASTER:$MASTER_PORT --dist-backend nccl --world-size 1 --resume "
