#!/bin/bash
#FLUX: --job-name=roi
#FLUX: -N=8
#FLUX: --queue=early_science
#FLUX: -t=1800
#FLUX: --urgency=16

export WORK='$SCRATCH/adse13_249/LY99'
export TRIAL='ly99sim'
export OUT_DIR='${PWD}'
export DIALS_OUTPUT='${WORK}/927185'
export CCTBX_NO_UUID='1'
export DIFFBRAGG_USE_CUDA='1'
export CCTBX_DEVICE_PER_NODE='4'
export CCTBX_GPUS_PER_NODE='4'

export WORK=$SCRATCH/adse13_249/LY99
cd $WORK
mkdir -p $SLURM_JOB_ID; cd $SLURM_JOB_ID
export TRIAL=ly99sim
export OUT_DIR=${PWD}
export DIALS_OUTPUT=${WORK}/927185
export CCTBX_NO_UUID=1
export DIFFBRAGG_USE_CUDA=1
export CCTBX_DEVICE_PER_NODE=4
export CCTBX_GPUS_PER_NODE=4
echo "dispatch.step_list = input filter statistics_unitcell model_statistics annulus statistics_unitcell
input.path=${DIALS_OUTPUT}
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
exafel.scenario=ds1
diffBragg.fix.detz_shift=True
diffBragg.fix.eta_abc=True
diffBragg.logging.rank0_level=high
diffBragg.logging.other_ranks_level=high
diffBragg.logging.log_refined_params=True
diffBragg.spectrum_from_imageset = True
diffBragg.downsamp_spec.skip=True
diffBragg.simulator.crystal.num_mosaicity_samples=20
diffBragg.simulator.structure_factors.mtz_name=${WORK}/928123/out/ly99sim_all.mtz
diffBragg.simulator.structure_factors.mtz_column=IMEAN,SIGIMEAN
diffBragg.space_group=C2
diffBragg.method=L-BFGS-B
diffBragg.simulator.oversample=1
diffBragg.refiner.adu_per_photon=1.0
diffBragg.use_restraints=False
diffBragg {
  no_Nabc_scale=False
  roi {
    shoebox_size=12
    fit_tilt=True
    fit_tilt_using_weights = False
    hotpixel_mask = None
    reject_edge_reflections = False
    reject_roi_with_hotpix = False
    pad_shoebox_for_background_estimation=10
    mask_outside_trusted_range=True
  }
  refiner {
    adu_per_photon = 1
    sigma_r=3
  }
  simulator {
    crystal.has_isotropic_ncells = False
    init_scale = 1
    beam.size_mm = 0.001
    detector.force_zero_thickness = True
  }
  init {
    Nabc=[72,72,72]
    eta_abc=[0.08,0.08,0.08]
    G=100
  }
  mins {
    Nabc=[3,3,3]
    detz_shift=-1.5
    RotXYZ=[-15,-15,-15]
    G=0
  }
  maxs {
    RotXYZ=[15,15,15]
    Nabc=[1600,1600,1600]
    G=1e12
    detz_shift=1.5
  }
  sigmas {
    RotXYZ=[1e-3,1e-3,1e-3]
  }
}
" > annulus.phil
echo "jobstart $(date)";pwd
srun -n 64 cctbx.xfel.merge annulus.phil
echo "jobend $(date)";pwd
