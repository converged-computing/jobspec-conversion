#!/bin/bash
#FLUX: --job-name=hp3d
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --queue=skx-normal
#FLUX: -t=300
#FLUX: --urgency=16

export KMP_INIT_AT_FORK='FALSE'

module list
pwd
date
nthreads=12
 export KMP_STACKSIZE=48M    # p=5
export KMP_INIT_AT_FORK=FALSE
alpha=1.0d-4
 zl=128.0d0  ; imax=8 ; maxnods=8050   ; file_geometry='../GEOMETRIES/waveguide/rect_128'
job=1
px=5; py=5; pz=5
dp=1
ibc=2
usepml=false
pmlfrac=0.25d0
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
args=" -geom 1 -isol 5 -comp 2 -alpha ${alpha}"
args+=" -job ${job} -imax ${imax} -jmax 0"
args+=" -px ${px} -py ${py} -pz ${pz} -dp ${dp}"
args+=" -ibc ${ibc}"
args+=" -nlflag 0 -heat 0 -copump 1"
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
