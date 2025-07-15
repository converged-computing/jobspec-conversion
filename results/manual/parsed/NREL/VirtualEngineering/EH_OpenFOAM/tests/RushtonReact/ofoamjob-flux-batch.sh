#!/bin/bash
#FLUX: --job-name=ehreact
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --urgency=16

export TMPDIR='${LOCAL_SCRATCH}'

export TMPDIR=${LOCAL_SCRATCH}
module purge
module use /nopt/nrel/apps/modules/centos74/modulefiles
module load gcc/7.3.0 
module load openmpi/1.10.7/gcc-7.3.0
source /projects/bpms/openfoam/OpenFOAM-dev/etc/bashrc
module load conda
module load paraview
rm ./blockMeshDict_reactor
rm -r 0
cp -r 0.org 0
python system/write_bmesh_file.py
blockMesh -dict ./blockMeshDict_reactor
stitchMesh -perfect -overwrite inside_to_hub inside_to_hub_copy
stitchMesh -perfect -overwrite hub_to_rotor hub_to_rotor_copy
transformPoints -scale "(0.01 0.01 0.01)"
decomposePar
srun -n 32 EHFoam -parallel
reconstructPar -newTimes
EHFoam -postProcess -func "grad(U)"
pvpython torq.py "lateralWall"
