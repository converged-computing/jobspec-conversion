#!/bin/bash
#FLUX: --job-name=joyous-onion-0117
#FLUX: --exclusive
#FLUX: --priority=16

set +x
source /global/common/software/nersc/shasta2105/python/3.8-anaconda-2021.05/etc/profile.d/conda.sh
conda activate 3DCNN
env | grep SLURM
srun python main.py --image_path /pscratch/sd/s/stella/ABCD_TFF/MNI_to_TRs --dataset_name ABCD --step 3 --batch_size_phase3 4 --target nihtbx_totalcomp_uncorrected --fine_tune_task regression --resume 
