#!/bin/bash
#FLUX: --job-name=reproducer
#FLUX: -N=4
#FLUX: --queue=early_science
#FLUX: -t=360
#FLUX: --urgency=16

export WORK='$CFS/m3562/nks/LY99'
export OUT_DIR='${PWD}'
export CCTBX_NO_UUID='1'
export DIFFBRAGG_USE_CUDA='1'

export WORK=$CFS/m3562/nks/LY99
mkdir -p $SLURM_JOB_ID; cd $SLURM_JOB_ID
export OUT_DIR=${PWD}
export CCTBX_NO_UUID=1
export DIFFBRAGG_USE_CUDA=1
echo "dispatch.step_list = input statistics_unitcell model_statistics annulus
input.path=${WORK}
input.experiments_suffix=00.img_integrated.expt
input.reflections_suffix=00.img_integrated.refl
input.keep_imagesets=True
input.read_image_headers=False
input.persistent_refl_cols=shoebox
input.persistent_refl_cols=bbox
input.persistent_refl_cols=xyzcal.px
input.persistent_refl_cols=xyzobs.px.value
input.persistent_refl_cols=delpsical.rad
input.persistent_refl_cols=panel
input.parallel_file_load.method=uniform
scaling.model=${WORK}/1m2a.pdb
scaling.unit_cell=67.2 59.8 47.2 90 110.3 90
scaling.space_group=C2
scaling.resolution_scalar=0.993420862158964
merging.d_max=None
merging.d_min=2.1
statistics.annulus.d_max=2.5
statistics.annulus.d_min=2.1
spread_roi.enable=True
spread_roi.strong=2.0
output.output_dir=${OUT_DIR}
output.log_level=0 # stdout stderr
exafel.trusted_mask=${WORK}/pixels.mask
exafel.scenario=3A
exafel.shoebox_border=0
exafel.context=kokkos_gpu
exafel.model.plot=False
exafel.model.mosaic_spread.value=0.08
exafel.model.Nabc.value=72,72,72
exafel.debug.lastfiles=False
exafel.debug.verbose=False
exafel.debug.finite_diff=-1
exafel.debug.eps=1.e-8
exafel.skin=False # whether to use diffBragg
exafel{
  refpar{
    label = *background *G
    background {
      algorithm=rossmann_2d_linear
      scope=spot
      slice_init=border
      slice=all
    }
  }
}
" > annulus.phil
echo "jobstart $(date)";pwd
CCTBX_GPUS_PER_NODE=4 srun -n 32 -c 2 cctbx.xfel.merge annulus.phil
echo "jobend $(date)";pwd
