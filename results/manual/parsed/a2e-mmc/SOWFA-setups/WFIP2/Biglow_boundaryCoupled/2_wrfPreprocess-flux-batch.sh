#!/bin/bash
#FLUX: --job-name=wrfPreProcBdCoup_biglow
#FLUX: -n=128
#FLUX: -t=14400
#FLUX: --urgency=16

source $HOME/.bash_profile
cores=$SLURM_NTASKS
echo "Working directory is" $SLURM_SUBMIT_DIR
echo "Job name is" $SLURM_JOB_NAME
echo "Submit time is" $(squeue -u $USER -o '%30j %20V' | grep -e $SLURM_JOB_NAME | awk '{print $2}')
echo "Starting OpenFOAM job at: " $(date)
echo "using" $cores "core(s)"
OpenFOAM-6-gcc-dev        # OpenFOAM/SOWFA version. OpenFOAM-6-{gcc,intel}-{central,dev}
wrfoutpath=/projects/mmc/cdraxl/wfip/WFIP2/control/2016112106
prefix=wrfout_d02_
suffix=''  # '.nc'
dateref='2016-11-21_07_00_00'
timeref=0
startTime=0
nCores1stPart=16
cp system/controlDict.moveDynamicMesh                  system/controlDict
cp system/fvSolution.flow                              system/fvSolution
cp system/fvSchemes.flow.linearupwind                  system/fvSchemes
refineMeshGlobal()
{
    for  (( i=0; i<$1; i++ )); do
        srun -n $cores topoSet -dict system/topoSetDict.entireDom -parallel > log.2.topoSet.entireDom.$i 2>&1
        srun -n $cores refineHexMesh -overwrite -parallel -noFunctionObjects entireDom > log.2.refineHexMesh.entireDom.$i 2>&1
        srun -n $cores checkMesh  -parallel -noFunctionObjects > log.2.checkMesh.global.$i 2>&1
    done
}
foamDictionary -entry "startFrom" -set "latestTime" -disableFunctionEntries system/controlDict
foamDictionary -entry "stopAt"    -set "noWriteNow" -disableFunctionEntries system/controlDict
srun -n $nCores1stPart --cpu_bind=cores superDeliciousVanilla -parallel > log.2.solver.generatePoints 2>&1
if [ ! -d postProcessing/boundaryData ]; then
    echo "Job killed (1)"; scancel $SLURM_JOBID
fi 
endTimeMesh=$(foamListTimes -processor -latestTime | tail -1)
foamDictionary -entry "writeFormat" -set ascii -disableFunctionEntries system/controlDict
reconstructPar -time $endTimeMesh > log.2.reconstructPar
z0=$(foamDictionary -entry "z0" -value setUp)
sed -i 's/-nan/0/g' $endTimeMesh/Rwall
foamDictionary -entry "boundaryField.lower.z0" -set $z0 $endTimeMesh/Rwall
foamDictionary -entry "writeFormat" -set binary -disableFunctionEntries system/controlDict
writeCellCenters -time $endTimeMesh > log.2.writeCellCenters.$endTimeMesh 2>&1
rm -rf $startTime
mv $endTimeMesh $startTime
rm -r processor*
module load conda
conda activate mynewenv 
python << END
import numpy as np
import os
import sys
sys.path.append('/home/rthedin/ABLTools/python')
from inflowPrepMMC import inflowPrepMMC
latPhysicsSite = 45.638004
lonPhysicsSite = -120.642973
rotation = 0.0
caseDir = os.getcwd()
cellcenterDir = os.path.join(caseDir, 'constant/')
boundaries = ['north','south','east','west','lower','upper']
physicsSite = inflowPrepMMC();
westBoundary = inflowPrepMMC();
[xPhysicsSite,yPhysicsSite,UTMzonePhysicsSite] = physicsSite.LatLonToUTM_elem(latPhysicsSite,lonPhysicsSite)
[lat,lon] = physicsSite.UTMtoLatLon(xPhysicsSite,yPhysicsSite,UTMzonePhysicsSite)
theta = rotation * np.pi / 180.0
R = np.zeros((3,3))
R[2,2] = 1.0
R[0,0] = np.cos(theta)
R[0,1] = -np.sin(theta)
R[1,0] = np.sin(theta)
R[1,1] = np.cos(theta)
for i in range(len(boundaries)):
    boundaryDir = os.path.join(caseDir, 'postProcessing/boundaryData', boundaries[i])
    boundary = inflowPrepMMC()
    boundary.readBoundaryDataPoints( os.path.join(boundaryDir, 'points') )
    boundary.rotateXYZ(R)
    boundary.writeBoundaryDataPoints(os.path.join(boundaryDir, 'points.rotated'))
    boundary.writeDataWRFtoFOAM( os.path.join(boundaryDir, boundaries[i] +'_bc.dat') ,xPhysicsSite,yPhysicsSite,UTMzonePhysicsSite)
internalDom = inflowPrepMMC()
internalDom.readBoundaryDataPoints( os.path.join(cellcenterDir, 'cellCenters') )
internalDom.rotateXYZ(R)
internalDom.writeBoundaryDataPoints( os.path.join(cellcenterDir + 'cellCenterspoints.rotated') )
internalDom.writeDataWRFtoFOAM( os.path.join(cellcenterDir, 'cellCenters.dat') ,xPhysicsSite,yPhysicsSite,UTMzonePhysicsSite)
END
mkdir postProcessing/boundaryDataTOOF
for bddir in postProcessing/boundaryData/*; do
    # get the boundary patch name from full path
    bd=${bddir##*/};
    cp postProcessing/boundaryData/$bd/${bd}_bc.dat postProcessing/boundaryDataTOOF/
done
cp constant/cellCenters.dat  postProcessing/boundaryDataTOOF/interior.dat
cd postProcessing/boundaryDataTOOF
for currfile in $wrfoutpath/$prefix*; do
    echo "Processing $currfile"
    wrftoof $currfile -startdate $dateref -offset 0 -qwall -ic
done
cd ../..
cp -r postProcessing/boundaryDataTOOF/$timeref  $startTime.fromWRF
cp -r $startTime.fromWRF/{U,T,p_rgh} $startTime
rm -r $startTime/uniform  # delete uniform/time file
rm -rf constant/boundaryData*
cp -r  postProcessing/boundaryDataTOOF constant
for bd in north south east west lower upper; do
    cp postProcessing/boundaryData/$bd/points constant/boundaryDataTOOF/$bd
done
rm -r constant/boundaryDataTOOF/{bdy_cache*,*_bc.dat,interior.dat,[0-9]*}
cd constant  && ln -sf boundaryDataTOOF boundaryData && cd ..
changeDictionary -dict system/changeDictionaryDict.TVMIO.bdCoupled.Wmostly -time $startTime -subDict dictionaryReplacement > log.2.changeDictionary.TVMIO.bdCoupled.Wmostly 2>&1
foamDictionary -entry "nCores" -set $cores setUp
foamDictionary -entry "startFrom" -set "startTime" -disableFunctionEntries system/controlDict
foamDictionary -entry "stopAt"    -set "endTime"   -disableFunctionEntries system/controlDict
foamDictionary -entry "startTime" -set $startTime        system/controlDict
foamDictionary -entry "endTime" -set $(($startTime+101))  system/controlDict
decomposePar -cellDist -force -time $startTime > log.2.decomposePar 2>&1
srun -n $cores checkMesh -noFunctionObjects -parallel > log.2.checkMesh.decomposed 2>&1
refineMeshGlobal 1
srun -n $cores moveDynamicMesh -noFunctionObjects -parallel > log.2.moveDynamicMesh 2>&1
printf 'time \t min cell vol \t max cell vol \t total vol' > log.2.volumeMeshHistory
grep -e "Total volume" -e "^Time" log.2.moveDynamicMesh | awk 'NR%2 {print $4 "\t" $8 "\t" $12} !(NR%2) {printf $3 "\t"}' >> log.2.volumeMeshHistory 2>&1
mv constant/polyMesh constant/polyMesh.bak
for ((c=0; c<$cores; c++)) ; do mv processor$c/constant.bak processor$c/constant; done
echo "Ending OpenFOAM job at: " $(date)
