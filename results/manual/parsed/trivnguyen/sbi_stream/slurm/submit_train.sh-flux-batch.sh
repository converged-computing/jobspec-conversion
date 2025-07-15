#!/bin/bash
#FLUX: --job-name=train_0
#FLUX: -t=18000
#FLUX: --priority=16

module unload python
if [ -f "/mnt/home/tnguyen/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/mnt/home/tnguyen/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="/mnt/home/tnguyen/miniconda3/bin:$PATH"
fi
conda activate geometric
config=$(realpath config.py)
cd /mnt/home/tnguyen/projects/sbi_stream
python train.py --config $config
exit 0
