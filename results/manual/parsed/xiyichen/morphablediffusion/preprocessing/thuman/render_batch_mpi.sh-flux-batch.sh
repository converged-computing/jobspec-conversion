#!/bin/bash
#FLUX: --job-name=preprocess_thuman
#FLUX: -n=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load openmpi/4.1.4
module load blender/3.4.1
mpirun -np 8 python render_batch_mpi.py --input_dir /cluster/scratch/xiychen/data/thuman_2.1 --output_dir /cluster/scratch/xiychen/data/thuman_2.1_preprocessed
