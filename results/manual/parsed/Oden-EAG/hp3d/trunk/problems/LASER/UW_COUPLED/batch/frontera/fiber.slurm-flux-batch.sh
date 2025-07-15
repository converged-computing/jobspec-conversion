#!/bin/bash
#FLUX: --job-name=doopy-toaster-0290
#FLUX: --urgency=16

export KMP_STACKSIZE='48M   # p=5'
export KMP_INIT_AT_FORK='FALSE'

module list
pwd
date
nthreads=14
export KMP_STACKSIZE=48M   # p=5
export KMP_INIT_AT_FORK=FALSE
gain=1.0d4
alpha=1.0d-4
zl=1.2d0; pmlfrac=0.25d0; imax=5; maxnods=8000 #6250
file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_1_2'
job=1
jmax=0
px=5; py=5; pz=5
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
args=" -geom 5 -isol 13 -alpha ${alpha} -gamma ${gamma} -comp 1"
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
ibrun ./uwLaser ${args}
date
