#!/bin/bash
#FLUX: --job-name=<rN>.prep.ALA
#FLUX: -N=6
#FLUX: -t=172800
#FLUX: --priority=16

export SLURM_COMP_VERBOSE='3'
export SLURM_LOADER_VERBOSE='3'
export OPENFAST_DIR='/home/$USER/tools/OpenFAST/install'
export HDF5_DIR='/softs/contrib/apps/hdf5/1.10.5'
export BLASLIB='/softs/contrib/apps/Openblas/0.3.6/lib -lopenblas'
export SOWFA_DIR='$WM_PROJECT_USER_DIR/SOWFA6'
export SOWFA_APPBIN='$SOWFA_DIR/platforms/$WM_OPTIONS/bin'
export SOWFA_LIBBIN='$SOWFA_DIR/platforms/$WM_OPTIONS/lib'
export LD_LIBRARY_PATH='$SOWFA_LIBBIN:$OPENFAST_DIR/lib:$BLASLIB:$LD_LIBRARY_PATH'
export PATH='$SOWFA_APPBIN:$OPENFAST_DIR/bin:$PATH'

echo "#############################"
echo "User:" $USER
echo "Submit time:" $(squeue -u $USER -o '%30j %20V' | \
    grep -e $SLURM_JOB_NAME | awk '{print $2}')
echo "Launch time:" `date +"%Y-%m-%dT%T"`
echo "Host:" `hostname`
echo "Directory:" `pwd`
echo "SLURM_JOBID:" $SLURM_JOBID
echo "SLURM_JOB_NAME:" $SLURM_JOB_NAME
echo "SLURM_SUBMIT_DIR:" $SLURM_SUBMIT_DIR
echo "SLURM_JOB_NODELIST:" $SLURM_JOB_NODELIST
echo "#############################"
umask 0077
export SLURM_COMP_VERBOSE=3
export SLURM_LOADER_VERBOSE=3
OpenFOAMversion=OpenFOAM-6      # OpenFOAM/SOWFA version
precursorDir=<precursorDir>
startTime=20000                 # Start time
updateBCType=1                  # Boolean for whether or not the BC types will be updated
nLocalRefs=2                    # Number of local refinements (serial)
nGlobalRefs=0                   # Number of global refinements (parallel) 
solver=superDeliciousVanilla.turbine
refLoc=ground                   # floating, ground
interp=linearupwind             # midpoint (for gravity waves), linearupwind
parallel=0                      # Boolean for whether or not the preprocessing is parallel.
unset LD_LIBRARY_PATH
echo "Sourcing the bash profile, loading modules, and setting the OpenFOAM environment variables..."
source /home/nishant/.bash_profile
module purge
module load gcc/7.3.0
module load Openblas/0.3.6
module load hdf5/1.10.5/openmpi_4.0.2/gcc_7.3.0
source /home/nishant/tools/spack/share/spack/setup-env.sh
spack env activate preciceFoam 
export OPENFAST_DIR=/home/$USER/tools/OpenFAST/install
export HDF5_DIR=/softs/contrib/apps/hdf5/1.10.5
export BLASLIB="/softs/contrib/apps/Openblas/0.3.6/lib -lopenblas"
export SOWFA_DIR=$WM_PROJECT_USER_DIR/SOWFA6
export SOWFA_APPBIN=$SOWFA_DIR/platforms/$WM_OPTIONS/bin
export SOWFA_LIBBIN=$SOWFA_DIR/platforms/$WM_OPTIONS/lib
export LD_LIBRARY_PATH=$SOWFA_LIBBIN:$OPENFAST_DIR/lib:$BLASLIB:$LD_LIBRARY_PATH
export PATH=$SOWFA_APPBIN:$OPENFAST_DIR/bin:$PATH
pythonPATH=/home/nishant/tools/spack/var/spack/environments/preciceFoam/.spack-env/view/bin/python
if [ ! -f system/controlDict ];                                                    then echo "Job killed (1)"; scancel $SLURM_JOBID; fi
if [ $nLocalRefs -gt 0 ] && [ ! -f system/topoSetDict.$refLoc.$nLocalRefs ];       then echo "Job killed (2)"; scancel $SLURM_JOBID; fi
if [ ! -f $precursorDir/setUp ];                                                   then echo "Job killed (3)"; scancel $SLURM_JOBID; fi
if [ ! -d $precursorDir/postProcessing/boundaryData ];                             then echo "Job killed (4)"; scancel $SLURM_JOBID; fi
if [ ! -d $precursorDir/$starTime ];                                               then echo "Job killed (5)"; scancel $SLURM_JOBID; fi
cp system/fvSchemes.flow.$interp                       system/fvSchemes
cp $precursorDir/setUp                             setUp
cp constant/ABLProperties.givenSourceFiles         constant/ABLProperties
cores=$(foamDictionary -value -entry "nCores" setUp.WT)
refineMeshLocal()
{
   i=1
   while [ $i -le $1 ]; do
      #- Select cells, refine them, and check the new mesh. refineHexMesh refines mesh and solution
      topoSet -dict system/topoSetDict.$refLoc.$i -noFunctionObjects > log.toposet.$refLoc.$i 2>&1
      refineHexMesh -overwrite $refLoc > log.refineHexMesh.$refLoc.$i 2>&1
      checkMesh -noFunctionObjects > log.checkMesh.local.$i 2>&1
      let i=i+1
   done
}
refineMeshGlobal()
{
   i=1
   while [ $i -le $1 ]
   do
      #- Refine all cells and check the new mesh. refineMesh only refines mesh
      mpirun -n $cores refineMesh -all -parallel -overwrite -noFunctionObjects > log.refineMesh.global.$i 2>&1
      mpirun -n $cores checkMesh  -parallel -noFunctionObjects > log.checkMesh.global.$i 2>&1
      let i=i+1
   done
}
echo "Starting OpenFOAM job at: " $(date)
echo "using" $cores "core(s)"
rm -rf $startTime $startTime.fromPrec
rm -rf constant/polyMesh
rm -rf constant/boundaryData
mkdir $startTime.fromPrec
cp -f $precursorDir/$startTime/{U,T,k,kappat,nut,p_rgh,qwall,Rwall} $startTime.fromPrec
cp -rf $startTime.fromPrec $startTime
cp -rf $precursorDir/constant/polyMesh constant
cp -rf $precursorDir/system/blockMeshDict system
$pythonPATH ./sowfa_convert_source_history.py $precursorDir/postProcessing/sourceHistory > log.convertSourceHistory 2>&1
ln -sf $precursorDir/postProcessing/boundaryData constant/boundaryData
ln -sf $precursorDir/constant/givenSource* constant/
refineMeshLocal $nLocalRefs
if [ $parallel -eq 1 ]; then
   #- Decompose the mesh and solution files (serial)
   decomposePar -cellDist -force > log.decomposePar 2>&1
   #- Perform global refinements after decomposePar, avoiding load unbalance
   refineMeshGlobal $nGlobalRefs
   #- The mesh got globally refined, but the solution file did not, so
   #- the boundary fields may not have the correct number of entries.
   #- Use the changeDictionary utility to overwrite the spatially varying
   #- boundary data to a uniform single value.
   if [ $updateBCType -eq 1 ]; then
      mpirun -n $cores changeDictionary -dict system/changeDictionaryDict.updateBCs.west -time $startTime -subDict dictionaryReplacement -parallel > log.changeDictionary 2>&1
   fi
   #- Renumber the mesh for better matrix solver performance.
   if [ $(($nLocalRefs+$nGlobalRefs)) -gt 0 ]; then
       mpirun -n $cores renumberMesh -parallel -overwrite > log.renumberMesh 2>&1
   fi
   #- Last check on the mesh.
   # mpirun -n $cores checkMesh -parallel -allGeometry -allTopology > log.checkMesh.full 2>&1
   mpirun -n $cores checkMesh -parallel > log.checkMesh.full 2>&1
else
   #- Renumber the mesh.
   renumberMesh -overwrite > log.renumberMesh 2>&1
   #- Decompose the mesh and solution files (serial)
   decomposePar -cellDist -force > log.decomposePar 2>&1
   #- Check the mesh.
   checkMesh > log.checkMesh.full 2>&1
fi
echo "Ending OpenFOAM job at: " $(date)
