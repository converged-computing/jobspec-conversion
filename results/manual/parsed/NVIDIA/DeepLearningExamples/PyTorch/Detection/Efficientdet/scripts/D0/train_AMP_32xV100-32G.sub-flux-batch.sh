#!/bin/bash
#FLUX: --job-name=butterscotch-pedo-8782
#FLUX: --exclusive
#FLUX: -t=28800
#FLUX: --urgency=16

readonly datadir="/coco2017"
readonly checkpointdir="$PWD/results/"
CREATE_FOLDER_CMD="if [ ! -d ${checkpointdir} ]; then mkdir -p ${checkpointdir} ; fi"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 sh -c "${CREATE_FOLDER_CMD}"
OUTFILE="${checkpointdir}/slurm-%j.out"
ERRFILE="${checkpointdir}/error-%j.out"
readonly mounts="${datadir}:/workspace/object_detection/datasets/coco,${checkpointdir}:/model,/backbone_checkpoints:/checkpoints"
srun -l -o $OUTFILE -e $ERRFILE --container-image nvcr.io/nvidia/effdet:21.06-py3 --no-container-entrypoint --container-mounts ${mounts} --mpi=pmix python3 train.py /workspace/object_detection/datasets/coco --model efficientdet_d0 -b 60 --lr 2.42 --amp --sync-bn --opt fusedmomentum --warmup-epochs 90 --output /model --lr-noise 0.55 0.9 --workers 16 --fill-color mean --model-ema --model-ema-decay 0.999 --eval-after 200 --epochs 400 --resume --pretrained-backbone-path /backbone_checkpoints/jocbackbone_statedict_B0.pth --smoothing 0.0 --fused-focal-loss --seed 31
