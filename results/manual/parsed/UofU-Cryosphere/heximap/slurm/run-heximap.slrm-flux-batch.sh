#!/bin/bash
#FLUX: --job-name=butterscotch-toaster-8100
#FLUX: -c=8
#FLUX: --queue=lonepeak
#FLUX: -t=21600
#FLUX: --urgency=16

StartDir=$(pwd)
HexDir="/uufs/chpc.utah.edu/common/home/u1046484/Codebase/heximap/"
SourceDir=$HexDir"src/"
ScratchDir="/scratch/general/vast/u1046484/heximap/"
DataDir="/uufs/chpc.utah.edu/common/home/u1046484/Documents/Research/GSLR/data/"
ImageDir=$DataDir"hexagon/declass-ii/imagery/"
GeoDir=$DataDir"refDEMs/"
OutDir=$StartDir/"outputs/"
PyScriptPath=$HexDir"scripts/chpc-main.py"
MatScriptPath=$HexDir"scripts/HPC_HEX.m"
echo "LOADING MODULES..."
module purge
module load gcc/8.5.0 matlab/R2022a opencv/3.4.1-mex-nomkl mexopencv/R2022a-nomkl
module use $HOME/MyModules
module load miniconda3/latest
conda activate heximap
mkdir -p $ScratchDir
cp $PyScriptPath $ScratchDir
cp $MatScriptPath $ScratchDir
cd $ScratchDir
echo "RUNNING PYTHON SCRIPT"
python chpc-main.py $SourceDir $DataDir $ImageDir $GeoDir $OutDir
echo "RUNNING MATLAB SCRIPT"
matlab -nodisplay -batch 'HPC_HEX' -logfile matlab_stdout.log
