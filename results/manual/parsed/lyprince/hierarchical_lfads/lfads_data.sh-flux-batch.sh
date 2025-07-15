#!/bin/bash
#FLUX: --job-name=milky-plant-1195
#FLUX: -t=18000
#FLUX: --urgency=16

start=`date +%s`
module purge
module load python/3.7
source $HOME/pytorch/bin/activate
echo $DATA
echo $PARAMETERS
mkdir $SLURM_TMPDIR/data
mkdir $SLURM_TMPDIR/models
cp $DATA $SLURM_TMPDIR/data
python run_lfads.py -d $SLURM_TMPDIR/$DATA -p $PARAMETERS -o $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/models $HOME/hierarchical_lfads
end=`date +%s`
runtime=$((end-start))
echo "Runtime was $runtime seconds"
