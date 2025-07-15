#!/bin/bash
#FLUX: --job-name=confused-cat-6722
#FLUX: -t=18000
#FLUX: --urgency=16

start=`date +%s`
module purge
module load python/3.7
source $HOME/pytorch/bin/activate
echo $SYSTEM
echo $SEED
echo $MODEL
mkdir $SLURM_TMPDIR/synth_data
mkdir $SLURM_TMPDIR/models
if [ -e $HOME/synth_data/${SYSTEM}_${SEED} ]
then
  cp $HOME/synth_data/${SYSTEM}_${SEED} $SLURM_TMPDIR/synth_data/${SYSTEM}_${SEED}
else
  python generate_synthetic_data.py -d $SYSTEM -s $SEED -o $SLURM_TMPDIR -p $HOME/hierarchical_lfads/synth_data/${SYSTEM}_params.yaml
fi
python run_lfads_synth.py -d $SLURM_TMPDIR/synth_data/${SYSTEM}_${SEED} -p parameters/parameters_${SYSTEM}_${MODEL}.yaml -o $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/models $HOME/hierarchical_lfads
cp -r $SLURM_TMPDIR/synth_data $HOME/hierarchical_lfads
end=`date +%s`
runtime=$((end-start))
echo "Runtime was $runtime seconds"
