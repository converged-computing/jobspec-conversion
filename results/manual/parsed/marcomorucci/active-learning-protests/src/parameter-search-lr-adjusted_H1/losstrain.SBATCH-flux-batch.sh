#!/bin/bash
#FLUX: --job-name=train_heuristic
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load python/intel/3.8.6
singularity exec --nv --bind /scratch/yz5880 --overlay /scratch/yz5880/overlay-25GB-500K.ext3:ro /scratch/yz5880/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
python3 parameter-search-lr-adjusted_H1/losstrain.py --data_dir /scratch/yz5880/ALP/src --data_file loss_decrease_epoch_100e.csv --epochs 50
"
