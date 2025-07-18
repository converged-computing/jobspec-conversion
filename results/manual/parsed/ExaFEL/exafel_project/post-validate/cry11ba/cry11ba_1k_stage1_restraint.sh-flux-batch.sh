#!/bin/bash
#FLUX: --job-name=stage1
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=1200
#FLUX: --urgency=16

export SCRATCH_FOLDER='$SCRATCH/cry11ba/$SLURM_JOB_ID'
export MTZ_PATH='$SCRATCH/cry11ba/${1}/out/ly99sim_all.mtz'
export SPEC_PATH='$SCRATCH/cry11ba/${2}_integ_exp_ref.txt'
export CCTBX_DEVICE_PER_NODE='4'
export N_START='0'
export LOG_BY_RANK='1 # Use Aaron's rank logger'
export RANK_PROFILE='0 # 0 or 1 Use cProfiler, default 1'
export N_SIM='1024 # total number of images to simulate'
export ADD_BACKGROUND_ALGORITHM='cuda'
export DEVICES_PER_NODE='4'
export MOS_DOM='26'
export CCTBX_NO_UUID='1'
export DIFFBRAGG_USE_KOKKOS='1'
export CUDA_LAUNCH_BLOCKING='1'
export NUMEXPR_MAX_THREADS='128'
export SLURM_CPU_BIND='cores # critical to force ranks onto different cores. verify with ps -o psr <pid>'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export SIT_PSDM_DATA='/global/cfs/cdirs/lcls/psdm-sauter'
export CCTBX_GPUS_PER_NODE='4'
export XFEL_CUSTOM_WORKER_PATH='$MODULES/psii_spread/merging/application # User must export $MODULES path'

SRUN="srun -n 64 -c 4"
export SCRATCH_FOLDER=$SCRATCH/cry11ba/$SLURM_JOB_ID
mkdir -p $SCRATCH_FOLDER; cd $SCRATCH_FOLDER
export MTZ_PATH=$SCRATCH/cry11ba/${1}/out/ly99sim_all.mtz
export SPEC_PATH=$SCRATCH/cry11ba/${2}_integ_exp_ref.txt
export CCTBX_DEVICE_PER_NODE=4
export N_START=0
export LOG_BY_RANK=1 # Use Aaron's rank logger
export RANK_PROFILE=0 # 0 or 1 Use cProfiler, default 1
export N_SIM=1024 # total number of images to simulate
export ADD_BACKGROUND_ALGORITHM=cuda
export DEVICES_PER_NODE=4
export MOS_DOM=26
export CCTBX_NO_UUID=1
export DIFFBRAGG_USE_KOKKOS=1
export CUDA_LAUNCH_BLOCKING=1
export NUMEXPR_MAX_THREADS=128
export SLURM_CPU_BIND=cores # critical to force ranks onto different cores. verify with ps -o psr <pid>
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export SIT_PSDM_DATA=/global/cfs/cdirs/lcls/psdm-sauter
export CCTBX_GPUS_PER_NODE=4
export XFEL_CUSTOM_WORKER_PATH=$MODULES/psii_spread/merging/application # User must export $MODULES path
echo "
spectrum_from_imageset = True
method = 'L-BFGS-B'
outdir = 'stage1'
debug_mode = False
roi {
  shoebox_size = 10
  fit_tilt = True
  reject_edge_reflections = False
  reject_roi_with_hotpix = False
  pad_shoebox_for_background_estimation = 0
  fit_tilt_using_weights = False
  mask_outside_trusted_range = True
}
fix {
  detz_shift = True
  ucell=False
  Nabc=False
  G=False
  RotXYZ=False
}
sigmas {
  ucell = .1 .1 .1
  RotXYZ = 0.01 0.01 0.01
  G = 1
  Nabc = 1 1 1
}
init {
  Nabc = 28 28 28
  G = 1e5
}
refiner {
  num_devices=4
  verbose = 0
  sigma_r = 3
  adu_per_photon = 1
  #reference_geom = '${MODULES}/exafel_project/kpp-sim/t000_rg002_chunk000_reintegrated_000000.expt'
}
simulator {
  oversample = 1
  crystal.has_isotropic_ncells = False
  structure_factors {
    mtz_column = 'Iobs(+),SIGIobs(+),Iobs(-),SIGIobs(-)'
  }
  beam {
    size_mm = 0.001
  }
  detector {
    force_zero_thickness = True
  }
}
mins {
  detz_shift = -1.5
  RotXYZ = -15 -15 -15
}
maxs {
  detz_shift = 1.5
  Nabc = 1600 1600 1600
  RotXYZ = 15 15 15
}
ucell_edge_perc = 15
ucell_ang_abs = 1
space_group = P21212
use_restraints = True
centers {
  ucell_a = 168.24
  ucell_b = 158.53
  ucell_c = 57.53
}
betas {
  ucell_a = 0.0000001
  ucell_b = 0.0000001
  ucell_c = 0.000000025
}
logging {
  rank0_level = low normal *high
  logfiles=False
}
downsamp_spec {
  skip = True
}
" > stage1.phil
echo "jobstart $(date)";pwd
$SRUN hopper stage1.phil structure_factors.mtz_name="$MTZ_PATH" exp_ref_spec_file="$SPEC_PATH"
echo "jobend $(date)";pwd
