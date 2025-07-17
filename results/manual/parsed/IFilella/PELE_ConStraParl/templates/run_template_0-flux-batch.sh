#!/bin/bash
#FLUX: --job-name=0_$OUTNAME_$COMPOUND
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda
module load intel mkl impi cmake
module load transfer
module load bsc
eval "$(conda shell.bash hook)"
source activate /gpfs/projects/bsc72/conda_envs/platform
python -m pele_platform.main $CURRENT/results/$OUTNAME/$COMPOUND.yaml
