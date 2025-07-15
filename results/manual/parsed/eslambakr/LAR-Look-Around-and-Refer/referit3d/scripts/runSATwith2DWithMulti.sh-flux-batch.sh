#!/bin/bash
#FLUX: --job-name=runSATWithCocoonMutliproceROINoRellu
#FLUX: --queue=batch
#FLUX: -t=180000
#FLUX: --priority=16

module load cuda/10.2.89
module load gcc/6.4.0 
python train_referit3d.py --patience 100 --max-train-epochs 100 --init-lr 1e-4 --batch-size 16 --transformer --model mmt_referIt3DNet -scannet-file ScanWithCocoFinle.pkl  -referit3D-file nr3d.csv --log-dir log/SATwithSyImg --n-workers 8  --unit-sphere-norm True --feat2d ROI --context_2d unaligned --mmt_mask train2d --warmup -load-dense false -load-imgs True  --object-encoder convnext_p++ --img-encoder True --cocoon True --twoStreams True --dist-url 'tcp://127.0.0.1:23459' --dist-backend 'nccl' --multiprocessing-distributed --world-size 1 --rank 0
