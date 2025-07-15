#!/bin/bash
#FLUX: --job-name=frigid-lettuce-7460
#FLUX: -c=32
#FLUX: --queue=gpuq
#FLUX: -t=14400
#FLUX: --urgency=16

export srclist='/astro/mwaeor/dev/sdc3/catalog/sdc3_inner_lobes.fits" # <- YOUR SOURCELIST HERE'
export visName='sub_lobes_points"                                      # <- NAME YOUR OUTPUT'
export hypArgs='/astro/mwaeor/cjordan/sdc3/sdc3.toml --timesteps 0"   # <- single timestep, saves time.'
export lo='$((SLURM_ARRAY_TASK_ID * 150))'
export hi='$(((SLURM_ARRAY_TASK_ID+1) * 150))'
export sdc3store='/astro/mwaeor/dev/sdc3/store'
export mergeName='106-196MHz_ts0720-0731'
export vis='106-196MHz_ts0060_${visName}.ms'
export imgName='wsclean_${vis%%.ms}_ch${lo}-${hi}'

export srclist="/astro/mwaeor/dev/sdc3/catalog/sdc3_inner_lobes.fits" # <- YOUR SOURCELIST HERE
export visName="sub_lobes_points"                                      # <- NAME YOUR OUTPUT
export hypArgs="/astro/mwaeor/cjordan/sdc3/sdc3.toml --timesteps 0"   # <- single timestep, saves time.
export lo=$((SLURM_ARRAY_TASK_ID * 150))
export hi=$(((SLURM_ARRAY_TASK_ID+1) * 150))
module use /astro/mwaeor/software/modulefiles
module load hyperdrive/sdc3 wsclean/2.9 singularity
cd /nvmetmp; mkdir deleteme; cd deleteme
export sdc3store=/astro/mwaeor/dev/sdc3/store
export mergeName="106-196MHz_ts0720-0731"
cp ${sdc3store}/uvfMerge/${mergeName}.uvfits .                        # <- unsub
export vis="106-196MHz_ts0060_${visName}.ms"
hyperdrive vis-sub $hypArgs \
    --data ${mergeName}.uvfits \
    --source-list $srclist \
    --outputs $vis
singularity exec \
    --bind ${PWD}:/tmp --writable-tmpfs --pwd /tmp --home ${PWD} --cleanenv \
    /pawsey/mwa/singularity/casa5/casa5.sif \
    casa -c "tb.open('${vis}/POLARIZATION', nomodify=False); tb.putcell(rownr=0,columnname='CORR_TYPE',thevalue=[1]); tb.close(); print('done')"
export imgName="wsclean_${vis%%.ms}_ch${lo}-${hi}"
wsclean \
  -name $imgName \
  -reorder \
  -use-wgridder \
  -parallel-gridding 10 \
  -oversampling 4095 \
  -kernel-size 15 \
  -nwlayers 1000 \
  -grid-mode kb \
  -taper-edge 100 \
  -padding 2 \
  -size 8192 8192 \
  -scale 8asec \
  -weight uniform \
  -multiscale \
  -super-weight 4 \
  -auto-threshold 4 \
  -mgain 0.8 \
  -pol I \
  -channel-range $lo $hi \
  -channels-out 15 \
  -join-channels \
  -niter 1000 \
  -save-source-list \
  -minuv-l 400 \
  -fit-spectral-log-pol 2 \
  -multiscale-scales 1,2,3,4,5,6,7,8,9,10 \
  -no-update-model-required \
  ${vis}
  # -taper-gaussian 60 \
mkdir -p /astro/mwaeor/${USER}/sdc3/img-${visName}
(set -x; cp ${imgName}*-MFS-{psf,image,model,residual}.fits ${imgName}*.txt /astro/mwaeor/${USER}/sdc3/img-${visName})
printf '\a'
