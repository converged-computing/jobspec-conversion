#!/bin/bash
#FLUX: --job-name=3_$OUTNAME_$COMPOUND
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load anaconda
module load intel mkl impi cmake
module load transfer
module load bsc
eval "$(conda shell.bash hook)"
source activate /gpfs/projects/bsc72/conda_envs/PELE_ConStraParl
python $CURRENT/scripts/disc.py -d $CURRENT/results/$OUTNAME/$COMPOUND_min/output/ -c 4
python $CURRENT/scripts/corrector.py -d $CURRENT/results/$OUTNAME/$COMPOUND -lf $CURRENT/results/$OUTNAME/$COMPOUND_min --skip_strain_per_cluster
