#!/bin/bash
#FLUX: --job-name=psycho-gato-2987
#FLUX: --exclusive
#FLUX: --urgency=16

readonly datadir="/datasets/imagenet/train-val-tfrecord"
readonly checkpointdir="$PWD/B0_mulitnode_AMP/"
CREATE_FOLDER_CMD="if [ ! -d ${checkpointdir} ]; then mkdir -p ${checkpointdir} ; fi && nvidia-smi"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 sh -c "${CREATE_FOLDER_CMD}"
OUTFILE="${checkpointdir}/slurm-%j.out"
ERRFILE="${checkpointdir}/error-%j.out"
readonly mounts="${datadir}:/data,${checkpointdir}:/model"
srun -p ${PARTITION} -l -o $OUTFILE -e $ERRFILE --container-image nvcr.io/nvidia/efficientnet-tf2:21.09-tf2-py3 --container-mounts ${mounts} --mpi=pmix bash ./scripts/bind.sh --cpu=exclusive --ib=single -- python3 main.py --cfg config/efficientnet_v1/b0_cfg.py --mode train_and_eval --use_amp --model_dir /model/ --data_dir /data --log_steps 100 --max_epochs 500 --save_checkpoint_freq 5 --train_batch_size 256 --eval_batch_size 256 --augmenter_name autoaugment
