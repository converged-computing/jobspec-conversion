#!/bin/bash
#FLUX: --job-name=roi
#FLUX: -N=10
#FLUX: --queue=early_science
#FLUX: -t=600
#FLUX: --urgency=16

export WORK='$SCRATCH/adse13_249/LY99'
export TRIAL='ly99sim'
export OUT_DIR='${PWD}'
export DIALS_OUTPUT='${WORK}/927185'
export CCTBX_NO_UUID='1'

export WORK=$SCRATCH/adse13_249/LY99
cd $WORK
mkdir -p $SLURM_JOB_ID; cd $SLURM_JOB_ID
export TRIAL=ly99sim
export OUT_DIR=${PWD}
export DIALS_OUTPUT=${WORK}/927185
export CCTBX_NO_UUID=1
echo "dispatch.step_list = input filter statistics_unitcell model_statistics annulus
input.path=${DIALS_OUTPUT}
input.experiments_suffix=0.img_integrated.expt
input.reflections_suffix=0.img_integrated.refl
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
filter.algorithm=unit_cell
filter.unit_cell.algorithm=cluster
filter.unit_cell.cluster.covariance.file=${WORK}/covariance_ly99sim_30000.pickle
filter.unit_cell.cluster.covariance.component=0
filter.unit_cell.cluster.covariance.mahalanobis=4.0
filter.outlier.min_corr=-1.0
merging.d_max=None
merging.d_min=2.1
statistics.annulus.d_max=2.5
statistics.annulus.d_min=2.1
spread_roi.enable=True
spread_roi.strong=2.0
output.output_dir=${OUT_DIR}/${TRIAL}
output.log_level=0 # stdout stderr
exafel.trusted_mask=${WORK}/pixels.mask
exafel.scenario=3
exafel.shoebox_border=0
exafel.context=kokkos_gpu
exafel.model.plot=False
exafel.model.Nabc.value=50,50,50
exafel.debug.lastfiles=False
exafel.debug.verbose=False
exafel{
  refpar{
    label = *background *nonsense
    background {
      algorithm=rossmann_2d_linear
      scope=spot
      slice_init=border
      slice=all
    }
    nonsense {
      algorithm=None
      scope=global
      slice=all
    }
  }
}
" > annulus.phil
echo "jobstart $(date)";pwd
srun -n 320 -c 2 cctbx.xfel.merge annulus.phil
echo "jobend $(date)";pwd
