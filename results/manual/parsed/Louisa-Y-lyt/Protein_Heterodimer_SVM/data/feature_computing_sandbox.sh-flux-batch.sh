#!/bin/bash
#FLUX: --job-name=feature_compute
#FLUX: -n=8
#FLUX: -c=8
#FLUX: --queue=gpu_requeue
#FLUX: -t=36000
#FLUX: --urgency=50

module load cuda/11.8.0-fasrc01
module load cudnn/8.9.2.26_cuda11-fasrc01
module load python/3.10.9-fasrc01
conda activate alphapulldown_new
cutoff=50
bind_path=$1
singularity exec \
    --no-home \
    --bind "$bind_path":/mnt \
    /n/holyscratch01/ramanathan_lab/yuting/alpha_analysis \
    run_get_good_pae.sh \
    --output_dir=/mnt \
    --cutoff=$cutoff
