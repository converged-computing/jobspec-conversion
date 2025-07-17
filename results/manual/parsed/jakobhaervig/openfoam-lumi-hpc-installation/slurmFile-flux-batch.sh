#!/bin/bash
#FLUX: --job-name=<simulation_name>
#FLUX: -n=128
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

module load LUMI/23.09 partition/C EasyBuild-user
module load OpenFOAM/v2312-cpeGNU-23.09
source $EBROOTOPENFOAM/etc/bashrc WM_COMPILER=Cray WM_MPLIB=CRAY-MPICH
blockMesh
decomposePar
srun pisoFoam -parallel
