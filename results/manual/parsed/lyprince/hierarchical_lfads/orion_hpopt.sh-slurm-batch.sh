#!/bin/bash
#FLUX: --job-name=hpopt
#FLUX: --queue=long
#FLUX: -t=7200
#FLUX: --urgency=16

PROJECTDIR=$HOME/hierarchical_lfads/
DATADIR=synth_data
WORKINGDIR=models
FILENAME=run_svlae.py
DATAFILE=lorenz_700
exit_script(){
cp -r $SLURM_TMPDIR/ $PROJECTDIR
}
terminator(){
echo 'job killed'
}
module purge
module load python/3.7
source $HOME/pytorch/bin/activate
chmod +x $FILENAME
if [ ! -d "$SLURM_TMPDIR" ]; then
  mkdir -p $SLURM_TMPDIR
fi
mkdir $SLURM_TMPDIR/$DATADIR
mkdir $SLURM_TMPDIR/$WORKINGDIR
cp -r $PROJECTDIR/$DATADIR/$DATAFILE $SLURM_TMPDIR/$DATADIR/
trap terminator SIGTERM
orion hunt --config $PROJECTDIR/config/run_svlae_config_bayes.yaml \
                    $FILENAME \
                      -d $PROJECTDIR/$DATADIR/$DATAFILE \
                      -p $PROJECTDIR/hyperparameters/lorenz/svlae.yaml \
                      -o $PROJECTDIR/$WORKINGDIR \
                      --batch_size 65 \
                      --max_epochs 800 \
                      -r \
                      --log10_lr~'uniform(-3, -1.5)' \
                      --kl_obs_max~'uniform(0.5, 2.0)' \
                      --kl_deep_max~'uniform(0.5, 2.0)' \
                      --log10_l2_gen_scale~'uniform(1.3, 3.3)' \
                      --deep_start_p~'uniform(0, 6, discrete=True)' \
                      --deep_start_p_scale 0.2 \
                      --kl_obs_dur~'uniform(1, 3, discrete=True)' \
                      --kl_obs_dur_scale 800
