#!/bin/bash
#FLUX: --job-name=reclusive-carrot-2809
#FLUX: --priority=16

export LEGACYPIPE_DIR='/src/legacypipe'
export SDSSDIR='/global/cfs/cdirs/sdss/data/sdss/'
export NUMPROC='$(($SLURM_CPUS_ON_NODE / 2))'
export SWEEPS_NUMPROC='$(($SLURM_CPUS_ON_NODE / 6))'

makelist=true
mopup=true
dr=dr10.1
drdir=/global/cfs/cdirs/cosmo/work/legacysurvey/$dr
droutdir=$SCRATCH/$dr
export LEGACYPIPE_DIR=/src/legacypipe
HOM=`eval echo "~$USER"`
export SDSSDIR=/global/cfs/cdirs/sdss/data/sdss/
export NUMPROC=$(($SLURM_CPUS_ON_NODE / 2))
export SWEEPS_NUMPROC=$(($SLURM_CPUS_ON_NODE / 6))
for survey in south
do
    # ADM the file that holds general information about LS bricks.
    #export BRICKSFILE=$drdir/$survey/survey-bricks.fits.gz
    # ADM hardcode this to dr10 for dr10.1 as there's no distinct file.
    export BRICKSFILE=/global/cfs/cdirs/cosmo/work/legacysurvey/dr10/survey-bricks.fits.gz
    # ADM set up the per-survey input and output directories.
    export INDIR=$drdir/$survey
    echo working on input directory $INDIR
    export TRACTOR_INDIR=$INDIR/tractor
    export OUTDIR=$droutdir/$survey
    echo writing to output directory $OUTDIR
    export SWEEP_OUTDIR=$OUTDIR/sweep
    export EXTERNAL_OUTDIR=$OUTDIR/external
    export TRACTOR_FILELIST=$OUTDIR/tractor_filelist
    mkdir -p $SWEEP_OUTDIR
    mkdir -p $EXTERNAL_OUTDIR
    # ADM write the bricks of interest to the output directory.
    if "$makelist"; then
        echo making new list of bricks to process
	# ADM the -L is needed to follow symbolic links.
        find -L $TRACTOR_INDIR -name 'tractor-*.fits' > $TRACTOR_FILELIST
        echo wrote list of tractor files to $TRACTOR_FILELIST
    else
        echo makelist is $makelist: Refusing to make new list of bricks to process.
    fi
    # ADM run the sweeps. Should never have to use the --ignore option here,
    # ADM which usually means there are some discrepancies in the data model!
    echo running sweeps on $SWEEPS_NUMPROC nodes
    if "$mopup"; then
        echo "Mopping up (won't overwrite existing sweep files)"
        time python $LEGACYPIPE_DIR/bin/generate-sweep-files.py \
             -v --numproc $SWEEPS_NUMPROC -f fits -F $TRACTOR_FILELIST --schema blocksdr10 \
             --mopup -d $BRICKSFILE $TRACTOR_INDIR $SWEEP_OUTDIR
    else
        time python $LEGACYPIPE_DIR/bin/generate-sweep-files.py \
             -v --numproc $SWEEPS_NUMPROC -f fits -F $TRACTOR_FILELIST --schema blocksdr10 \
             -d $BRICKSFILE $TRACTOR_INDIR $SWEEP_OUTDIR
    fi
    echo done running sweeps for the $survey
    # ADM run each of the external matches.
    echo making $EXTERNAL_OUTDIR/survey-$dr-$survey-dr7Q.fits
    time python $LEGACYPIPE_DIR/bin/match-external-catalog.py \
         -v --numproc $NUMPROC -f fits -F $TRACTOR_FILELIST \
         $SDSSDIR/dr7/dr7qso.fit.gz \
         $TRACTOR_INDIR \
         $EXTERNAL_OUTDIR/survey-$dr-$survey-dr7Q.fits --copycols SMJD PLATE FIBER RERUN
    echo done making $EXTERNAL_OUTDIR/survey-$dr-$survey-dr7Q.fits
    echo making $EXTERNAL_OUTDIR/survey-$dr-$survey-dr12Q.fits
    time python $LEGACYPIPE_DIR/bin/match-external-catalog.py \
         -v --numproc $NUMPROC -f fits -F $TRACTOR_FILELIST \
         $SDSSDIR/dr12/boss/qso/DR12Q/DR12Q.fits \
         $TRACTOR_INDIR \
         $EXTERNAL_OUTDIR/survey-$dr-$survey-dr12Q.fits --copycols MJD PLATE FIBERID RERUN_NUMBER
    echo done making $EXTERNAL_OUTDIR/survey-$dr-$survey-dr12Q.fits
    echo making $EXTERNAL_OUTDIR/survey-$dr-$survey-superset-dr12Q.fits
    time python $LEGACYPIPE_DIR/bin/match-external-catalog.py \
         -v --numproc $NUMPROC -f fits -F $TRACTOR_FILELIST \
         $SDSSDIR/dr12/boss/qso/DR12Q/Superset_DR12Q.fits \
         $TRACTOR_INDIR \
         $EXTERNAL_OUTDIR/survey-$dr-$survey-superset-dr12Q.fits --copycols MJD PLATE FIBERID
    echo done making $EXTERNAL_OUTDIR/survey-$dr-$survey-superset-dr12Q.fits
    echo making $EXTERNAL_OUTDIR/survey-$dr-$survey-specObj-dr16.fits
    time python $LEGACYPIPE_DIR/bin/match-external-catalog.py \
         -v --numproc $NUMPROC -f fits -F $TRACTOR_FILELIST \
         $SDSSDIR/dr16/sdss/spectro/redux/specObj-dr16.fits \
         $TRACTOR_INDIR \
         $EXTERNAL_OUTDIR/survey-$dr-$survey-specObj-dr16.fits --copycols MJD PLATE FIBERID RUN2D
    echo done making $EXTERNAL_OUTDIR/survey-$dr-$survey-specObj-dr16.fits
    echo making $EXTERNAL_OUTDIR/survey-$dr-$survey-dr16Q-v4.fits
    time python $LEGACYPIPE_DIR/bin/match-external-catalog.py \
         -v --numproc $NUMPROC -f fits -F $TRACTOR_FILELIST \
         $SDSSDIR/dr16/eboss/qso/DR16Q/DR16Q_v4.fits \
         $TRACTOR_INDIR \
         $EXTERNAL_OUTDIR/survey-$dr-$survey-dr16Q-v4.fits --copycols MJD PLATE FIBERID
    echo done making $EXTERNAL_OUTDIR/survey-$dr-$survey-dr16Q-v4.fits
    echo making $EXTERNAL_OUTDIR/survey-$dr-$survey-superset-dr16Q-v3.fits
    time python $LEGACYPIPE_DIR/bin/match-external-catalog.py \
         -v --numproc $NUMPROC -f fits -F $TRACTOR_FILELIST \
	 $SDSSDIR/dr16/eboss/qso/DR16Q/DR16Q_Superset_v3.fits \
         $TRACTOR_INDIR \
         $EXTERNAL_OUTDIR/survey-$dr-$survey-superset-dr16Q-v3.fits --copycols MJD PLATE FIBERID
    echo done making $EXTERNAL_OUTDIR/survey-$dr-$survey-superset-dr16Q-v3.fits
done
wait
echo done writing sweeps and externals for all surveys
