#!/bin/bash
#FLUX: --job-name=pdb_data_curation_array
#FLUX: -c=12
#FLUX: --queue=nodes
#FLUX: -t=86400
#FLUX: --urgency=16

export CC='$GCC'
export CXX='$GPLUSPLUS'
export FC='$GFORTRAN'

module purge
module load devel/CMake/3.16.4-GCCcore-9.3.0
module load lang/Python/3.8.2-GCCcore-9.3.0
cmake --version || "CMake is not found!. Install CMake then re-run this script " || exit 3
gcc --version  || "GCC is not found!. Install GCC then re-run this script " || exit 3
GCC="$(which gcc)"
GPLUSPLUS="$(which g++)"
echo "GCC: $GCC"
echo "GCC: $GPLUSPLUS"
GFORTRAN="$(which gfortran)"
echo "GFORTRAN: $GFORTRAN"
Threads="$(nproc --all)"
export CC=$GCC
export CXX=$GPLUSPLUS
export FC=$GFORTRAN
mainDir=/users/hb1115/scratch/PDB_anal
cd $mainDir
cd $mainDir/privateer
privateerDir=$PWD
echo Current working directory is `pwd`
echo Running job on host:
echo -e '\t'`hostname` at `date`
echo $SLURM_CPUS_ON_NODE CPU cores available
echo
echo Privateer directory is located at $privateerDir
echo My working directory is `pwd`
echo Running array job index $SLURM_ARRAY_TASK_ID, on host:
echo -e '\t'`hostname` at `date`
echo
source $privateerDir/pvtpython/bin/activate
source $privateerDir/ccp4.envsetup-sh
projectSigmaDir=$privateerDir/project_sigma
cd $projectSigmaDir
python3 --version
which python3
filename=$(awk NR==$SLURM_ARRAY_TASK_ID /users/hb1115/scratch/PDB_anal/viking_job_scripts/pdb_mirror.folders)
python3 $projectSigmaDir/data_collection/prepare_glycans_for_clustering.py -folder $filename
ls $projectSigmaDir/data_collection/intermediate_output
echo Job completed at `date`
