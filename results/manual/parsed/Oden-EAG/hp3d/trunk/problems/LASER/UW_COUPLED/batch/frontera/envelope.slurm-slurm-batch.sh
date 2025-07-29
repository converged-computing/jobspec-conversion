#!/bin/bash
#FLUX: --job-name=hp3d
#FLUX: -N=16
#FLUX: -n=64
#FLUX: --queue=development
#FLUX: -t=1740
#FLUX: --urgency=16

export KMP_STACKSIZE='24M   # p=3'
export KMP_INIT_AT_FORK='FALSE'

module list
pwd
date
nthreads=14
export KMP_STACKSIZE=24M   # p=3
export KMP_INIT_AT_FORK=FALSE
alpha=1.0d-4
gain=1.0d4
envelope=true
zl=1228.8d0; pmlfrac=0.03125d0; imax=9; maxnods=126000
file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_1228_8'
job=1
jmax=1
px=5; py=5; pz=6
dp=1
ref_core=1.4512d0
ref_clad=1.4500d0
ibc=0
usepml=true
nlflag=0
heat=0
plane_pump=0
plane_pump_power=1.d3
copump=1
raman=0.d0
aniso_heat=1
aniso_ref_index=0
art_grating=0
nsteps=10
dt=0.1d0
gamma=1.0d0
ctrl='../COMMON_FILES/control_0'
mkdir ${SLURM_JOB_ID}
cd ${SLURM_JOB_ID}
mkdir outputs
cd outputs
mkdir paraview
mkdir power
mkdir temp
cd ../..
dir_output="${SLURM_JOB_ID}/outputs/"
vis_level=3
args=" -geom 5 -isol 17 -alpha ${alpha} -gamma ${gamma} -comp 1"
args+=" -ref_core ${ref_core} -ref_clad ${ref_clad}"
args+=" -aniso_ref_index ${aniso_ref_index}"
args+=" -art_grating ${art_grating}"
args+=" -job ${job} -imax ${imax} -jmax ${jmax}"
args+=" -ibc ${ibc}"
args+=" -px ${px} -py ${py} -pz ${pz} -dp ${dp}"
args+=" -copump ${copump} -nlflag ${nlflag} -gain ${gain} -raman ${raman}"
args+=" -plane_pump ${plane_pump} -plane_pump_power ${plane_pump_power}"
args+=" -heat ${heat} -aniso_heat ${aniso_heat} -nsteps ${nsteps} -dt ${dt}"
args+=" -dir_output ${dir_output} -vis_level ${vis_level}"
args+=" -file_geometry ${file_geometry} -zl ${zl}"
args+=" -file_control ${ctrl}"
args+=" -maxnods ${maxnods}"
args+=" -nthreads ${nthreads}"
if [ "$usepml" = true ] ; then
   args+=" -usepml -pmlfrac ${pmlfrac}"
fi
if [ "$envelope" = true ] ; then
   args+=" -envelope"
   args+=" -wavenum_signal 85.0d0 -wavenum_pump 92.7d0"
fi
ibrun ./uwLaser ${args}
date
