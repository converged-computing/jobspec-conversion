#!/bin/bash
#FLUX: --job-name=bumfuzzled-bicycle-5870
#FLUX: --priority=16

module load python/3.7.4
module load gcc/10.2
module load cuda/11.1.1
module load cudnn/8.2.0
source /gpfs/data/epavlick/mlepori/miniconda3/etc/profile.d/conda.sh
conda activate CircuitProbing
python $PROJECT_DIR/src/circuit_probing.py --config $CONFIG
