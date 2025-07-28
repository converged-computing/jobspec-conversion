#!/bin/bash
#FLUX: --job-name=PPoPP
#FLUX: --queue=normal
#FLUX: -t=5400
#FLUX: --urgency=16

export MKLROOT='/opt/intel/compilers_and_libraries_2018.2.199/linux/mkl/ '
export CMAKE_CXX_COMPILER='/opt/intel/compilers_and_libraries_2018.2.199/linux/bin/intel64/icpc'

module cmake
module load intel/18.0.2
export MKLROOT=/opt/intel/compilers_and_libraries_2018.2.199/linux/mkl/ 
export CMAKE_CXX_COMPILER=/opt/intel/compilers_and_libraries_2018.2.199/linux/bin/intel64/icpc
MatRox_HOME=$(pwd)
MatRox_build=${MatRox_HOME}/build/sympiler/
MatRox_Lib=${MatRox_HOME}/libTest/
MatRox_Fig=${MatRox_HOME}/Figures/
mkdir build
cd build
cmake ..
cd sympiler
make
cp ../../scripts/KNL/testScalKNL ./
cp ../../scripts/KNL/* ${MatRox_Lib}/
cd ${MatRox_build}
bash testScalKNL
cp scalknl.csv ../../Figures/Fig7-scal/
cd ${MatRox_Lib}
unzip GOFMM.zip
cd GOFMM/
source set_env_knl.sh
mkdir build
cd build
rm -rf *
cmake ..
make 
make install
cp ./bin/artifact_sc17gofmm.x ${MatRox_Lib}/ 
cd ${MatRox_Lib}
mv artifact_sc17gofmm.x artifact_sc17gofmm_knl.x
bash testGOScalKNL
cp goscalknl.csv ../Figures/Fig7-scal/
bash testSTScalKNL
cp stscalknl.csv ../Figures/Fig7-scal/
echo "please copy figures to local machine and draw figures by using following instruction"
