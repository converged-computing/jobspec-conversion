#!/bin/bash
#FLUX: --job-name=dirty-bicycle-3455
#FLUX: --exclusive
#FLUX: --priority=16

readonly datadir="/datasets/imagenet/train-val-tfrecord"
readonly checkpointdir="$PWD/B4_mulitnode_AMP/"
CREATE_FOLDER_CMD="if [ ! -d ${checkpointdir} ]; then mkdir -p ${checkpointdir} ; fi && nvidia-smi"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 sh -c "${CREATE_FOLDER_CMD}"
OUTFILE="${checkpointdir}/slurm-%j.out"
ERRFILE="${checkpointdir}/error-%j.out"
readonly mounts="${datadir}:/data,${checkpointdir}:/model"
srun -p ${PARTITION} -l -o $OUTFILE -e $ERRFILE --container-image nvcr.io/nvidia/efficientnet-tf2:21.02-tf2-py3 --container-mounts ${mounts} --mpi=pmix bash ./scripts/bind.sh --cpu=exclusive --ib=single -- python3 main.py --mode train_and_eval --arch efficientnet-b4 --model_dir /model --data_dir /data --use_amp --use_xla --lr_decay cosine --weight_init fan_out --max_epochs 500 --log_steps 100 --save_checkpoint_freq 3 --train_batch_size 128 --eval_batch_size 128 --lr_init 0.005 --batch_norm syncbn --resume_checkpoint --augmenter_name autoaugment --mixup_alpha 0.2 --weight_decay 5e-6 --epsilon 0.001
