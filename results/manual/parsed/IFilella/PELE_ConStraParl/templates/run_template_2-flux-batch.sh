#!/bin/bash
#FLUX: --job-name=2_$OUTNAME_$COMPOUND
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
module load anaconda
module load intel mkl impi cmake
module load transfer
module load bsc
eval "$(conda shell.bash hook)"
source activate /gpfs/projects/bsc72/conda_envs/PELE_ConStraParl
python $CURRENT/scripts/ligand_minimization.py -f $CURRENT/$LIGSDIR/$COMPOUND_prep.pdb -d $CURRENT/results/$OUTNAME/$COMPOUND -r LIG -lf $CURRENT/results/$OUTNAME/$COMPOUND_min
