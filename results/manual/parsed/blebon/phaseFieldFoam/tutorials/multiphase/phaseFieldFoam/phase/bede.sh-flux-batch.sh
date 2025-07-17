#!/bin/bash
#FLUX: --job-name=OF10_GccOpt_Phase
#FLUX: --queue=infer
#FLUX: -t=7200
#FLUX: --urgency=16

export application='`getApplication`'

pwd; hostname; date
module load gcc/10.2.0; module load cmake; module load boost; module load openmpi; module load vtk; module load cuda
source $HOME/OpenFOAM/${USER}-10/etc/bashrc
unset FOAM_SIGFPE
conda activate base
source $WM_PROJECT_DIR/bin/tools/RunFunctions
export application=`getApplication`
if [ ! -f log.decomposePar ]; then
    ./Allrun.pre
fi
nProcs=$(foamDictionary system/decomposeParDict -entry numberOfSubdomains -value)
echo "Running $application in parallel on $(pwd) using $nProcs processes"
nsys profile -t nvtx,cuda -o report_cpu --stats=true mpirun -n $nProcs $FOAM_USER_APPBIN/$application -parallel > log.$application 2>&1
runApplication reconstructPar -newTimes
./Allpost
date
