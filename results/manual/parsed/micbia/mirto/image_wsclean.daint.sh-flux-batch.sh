#!/bin/bash
#FLUX: --job-name=wscelan_img
#FLUX: -c=12
#FLUX: -t=10800
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

module purge
module load spack-config
module load gcc/9.3.0
BIPP_PATH="/users/mibianco/codes/bluebild2"
. $BIPP_PATH/spack/share/spack/setup-env.sh
spack env activate -p bipp00
IDX_S=0
IDX_F=612 #"$((${SLURM_ARRAY_TASK_ID}))"
FNAME="lc_256_train_130923_i${IDX_S}_dTnoisegainiongfpoint_ch${IDX_F}_4h1d_256"
MS_PREFIX="$SCRATCH/output_sdc3/dataLC_130923/test/$FNAME"
PATH_MS="${MS_PREFIX}.MS"
SCALE="14.0625asec" # for 8 deg FoV
SIZE=2048
WEIGHT="natural"
if [[ "$FNAME" == *"noise"* || "$FNAME" == *"gain"* ]]; then
    DATA="MODEL_DATA"  # for noise and gain
else
    DATA="DATA"
fi
DATA="DATA"
echo $DATA
export HDF5_USE_FILE_LOCKING='FALSE'
if [[ "$WEIGHT" == *"natural"* ]]; then
    #wsclean -data-column $DATA -minuv-l 0 -maxuv-l 500 -reorder -mem 3 -use-wgridder -parallel-gridding 10 -weight $WEIGHT -oversampling 4095 -kernel-size 15 -nwlayers 1000 -grid-mode kb -taper-edge 100 -padding 2 -name $MS_PREFIX -size $SIZE $SIZE -scale $SCALE -niter 0 -pol xx -make-psf $PATH_MS
    wsclean -data-column $DATA -reorder -mem 3 -use-wgridder -parallel-gridding 10 -weight $WEIGHT -oversampling 4095 -kernel-size 15 -nwlayers 1000 -grid-mode kb -taper-edge 100 -padding 2 -name $MS_PREFIX -size $SIZE $SIZE -scale $SCALE -niter 0 -pol xx -make-psf $PATH_MS
else
    wsclean -data-column $DATA -no-update-model-required -use-wgridder -multiscale -parallel-gridding 10 -weight $WEIGHT -oversampling 4095 -kernel-size 15 -nwlayers 1000 -grid-mode kb -taper-edge 100 -padding 2 -taper-gaussian 60 -super-weight 4 -name $MS_PREFIX -size $SIZE $SIZE -scale $SCALE -niter 1000000 -auto-threshold 4 -mgain 0.8 -pol xx -make-psf $PATH_MS
fi
rm "${MS_PREFIX}-image.fits"
rm "${MS_PREFIX}-psf.fits"
