#!/bin/bash
#FLUX: --job-name=0744m640
#FLUX: -N=3
#FLUX: -c=4
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export LEGACY_SURVEY_DIR='/global/cfs/cdirs/cosmo/work/legacysurvey/dr9m'
export DUST_DIR='/global/cfs/cdirs/cosmo/data/dust/v0_1'
export UNWISE_COADDS_DIR='/global/cfs/cdirs/cosmo/work/wise/outputs/merge/neo6/fulldepth:/global/cfs/cdirs/cosmo/data/unwise/allwise/unwise-coadds/fulldepth'
export UNWISE_COADDS_TIMERESOLVED_DIR='/global/cfs/cdirs/cosmo/work/wise/outputs/merge/neo6'
export UNWISE_MODEL_SKY_DIR='/global/cfs/cdirs/cosmo/work/wise/unwise_catalog/dr3/mod'
export GAIA_CAT_DIR='/global/cfs/cdirs/cosmo/work/gaia/chunks-gaia-dr2-astrom-2'
export GAIA_CAT_VER='2'
export TYCHO2_KD_DIR='/global/cfs/cdirs/cosmo/staging/tycho2'
export LARGEGALAXIES_CAT='/global/cfs/cdirs/cosmo/staging/largegalaxies/v3.0/SGA-ellipse-v3.0.kd.fits'
export PS1CAT_DIR='/global/cfs/cdirs/cosmo/work/ps1/cats/chunks-qz-star-v3'
export SKY_TEMPLATE_DIR='/global/cfs/cdirs/cosmo/work/legacysurvey/sky-templates'
export PYTHONNOUSERSITE='1'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export KMP_AFFINITY='disabled'
export MPICH_RANK_REORDER_METHOD='0'

nmpi=48
brick=0744m640
outdir=/global/cscratch1/sd/dstn/dr9m-mpi
BLOB_MASK_DIR=/global/cfs/cdirs/cosmo/work/legacysurvey/dr8/south
export LEGACY_SURVEY_DIR=/global/cfs/cdirs/cosmo/work/legacysurvey/dr9m
export DUST_DIR=/global/cfs/cdirs/cosmo/data/dust/v0_1
export UNWISE_COADDS_DIR=/global/cfs/cdirs/cosmo/work/wise/outputs/merge/neo6/fulldepth:/global/cfs/cdirs/cosmo/data/unwise/allwise/unwise-coadds/fulldepth
export UNWISE_COADDS_TIMERESOLVED_DIR=/global/cfs/cdirs/cosmo/work/wise/outputs/merge/neo6
export UNWISE_MODEL_SKY_DIR=/global/cfs/cdirs/cosmo/work/wise/unwise_catalog/dr3/mod
export GAIA_CAT_DIR=/global/cfs/cdirs/cosmo/work/gaia/chunks-gaia-dr2-astrom-2
export GAIA_CAT_VER=2
export TYCHO2_KD_DIR=/global/cfs/cdirs/cosmo/staging/tycho2
export LARGEGALAXIES_CAT=/global/cfs/cdirs/cosmo/staging/largegalaxies/v3.0/SGA-ellipse-v3.0.kd.fits
export PS1CAT_DIR=/global/cfs/cdirs/cosmo/work/ps1/cats/chunks-qz-star-v3
export SKY_TEMPLATE_DIR=/global/cfs/cdirs/cosmo/work/legacysurvey/sky-templates
export PYTHONNOUSERSITE=1
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export MPICH_GNI_FORK_MODE=FULLCOPY
export KMP_AFFINITY=disabled
bri=$(echo $brick | head -c 3)
mkdir -p $outdir/logs/$bri
log="$outdir/logs/$bri/$brick.log"
mkdir -p $outdir/metrics/$bri
echo Logging to: $log
echo Running on $(hostname)
echo -e "\n\n\n" >> $log
echo "-----------------------------------------------------------------------------------------" >> $log
echo "PWD: $(pwd)" >> $log
echo >> $log
ulimit -a >> $log
echo >> $log
echo -e "\nStarting on $(hostname)\n" >> $log
echo "-----------------------------------------------------------------------------------------" >> $log
export MPICH_RANK_REORDER_METHOD=0
srun -n $nmpi \
     shifter \
     python -u -O -m mpi4py.futures \
     /src/legacypipe/py/legacypipe/mpi-runbrick.py \
       --no-wise-ceres \
       --run south \
       --brick $brick \
       --skip \
       --skip-calibs \
       --blob-mask-dir ${BLOB_MASK_DIR} \
       --checkpoint ${outdir}/checkpoints/${bri}/checkpoint-${brick}.pickle \
       --wise-checkpoint ${outdir}/checkpoints/${bri}/wise-${brick}.pickle \
       --pickle "${outdir}/pickles/${bri}/runbrick-%(brick)s-%%(stage)s.pickle" \
       --outdir $outdir \
       >> $log 2>&1
