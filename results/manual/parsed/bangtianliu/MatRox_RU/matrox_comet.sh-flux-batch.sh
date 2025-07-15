#!/bin/bash
#FLUX: --job-name="PPoPP_artifact"
#FLUX: --queue=compute
#FLUX: --priority=16

export MODULEPATH='/share/apps/compute/modulefiles:$MODULEPATH'
export MKLROOT='/share/apps/compute/intel/intelmpi2018/compilers_and_libraries/linux/mkl/'
export CMAKE_CXX_COMPILER='/share/apps/compute/intel/intelmpi2018/compilers_and_libraries/linux/bin/intel64/icpc'

module load cmake
cometORknl=1  # Comet is 1, KNL is 2
if [ "$#" -eq 1 ]; then
cometORknl=$1
fi
if [ $cometORknl -eq 1 ]; then
export MODULEPATH=/share/apps/compute/modulefiles:$MODULEPATH
module load intel/2018.1.163
module load gnu/6.2.0
module load python
module load scipy/3.6
export MKLROOT=/share/apps/compute/intel/intelmpi2018/compilers_and_libraries/linux/mkl/
export CMAKE_CXX_COMPILER=/share/apps/compute/intel/intelmpi2018/compilers_and_libraries/linux/bin/intel64/icpc
fi
MatRox_HOME=$(pwd)
MatRox_build=${MatRox_HOME}/build/sympiler/
MatRox_Lib=${MatRox_HOME}/libTest/
MatRox_Fig=${MatRox_HOME}/Figures/
mkdir build
cd build
cmake ..
cd sympiler
make
cp ../../scripts/* .
cp ../../scripts/* ${MatRox_Lib}/
cd ${MatRox_build}
bash nrhssh  0.0
cp hssnrhs.csv ../../Figures/Fig4-nrhs/
bash nrhssh 0.03
cp h2nrhs.csv ../../Figures/Fig4-nrhs/
cd ${MatRox_Lib}
bash GOnrhsh 0.0
cp gohssnrhs.csv ../Figures/Fig4-nrhs/
bash GOnrhsh 0.03
cp goh2nrhs.csv ../Figures/Fig4-nrhs/
bash stnrhsh
cp stnrhs.csv ../Figures/Fig4-nrhs/
cd ${MatRox_Fig}/Fig4-nrhs/
python3 drawhssnrhs.py --m hssnrhs.csv --g gohssnrhs.csv --s stnrhs.csv
python3 drawh2bnrhs.py --m h2nrhs.csv --g goh2nrhs.csv
cd ${MatRox_build}
bash HSSFlops
cp hssflops.csv ../../Figures/Fig5-flops/
bash H2Flops
cp h2flops.csv ../../Figures/Fig5-flops/
cd ${MatRox_Lib}
bash testGOFlops 0.0
cp gohssflops.csv ../Figures/Fig5-flops/
bash testGOFlops 0.03
cp goh2flops.csv ../Figures/Fig5-flops/
bash testSTFlops
cp stflops.csv ../Figures/Fig5-flops/
cd ${MatRox_Fig}/Fig5-flops/
python3 drawhssflops.py --m hssflops.csv --g gohssflops.csv --s stflops.csv
python3 drawh2bflops.py --m h2flops.csv --g goh2flops.csv
cd ${MatRox_build}
bash testScal
cp scal.csv ../../Figures/Fig7-scal/
cd ${MatRox_Lib}
bash testGOScal
cp goscal.csv ../Figures/Fig7-scal/
bash testSTScal
cp stscal.csv ../Figures/Fig7-scal/
bash testSMAScal
cp smascal.csv ../Figures/Fig7-scal/
cd ${MatRox_Fig}/Fig7-scal/
python3 drawscal.py --m scal.csv --g goscal.csv --s stscal.csv --sa smascal.csv
cd ${MatRox_build}
bash accsh 0.03
cp acc.csv ${MatRox_Fig}/Fig9-acc/
cd ${MatRox_Fig}/Fig9-acc/
python3 drawacc.py acc.csv
cd ${MatRox_build}
bash nrunsh 0.03
cp nrun.csv ../../Figures/Fig10-nrun/
cd ${MatRox_Lib}
bash GOnrunsh 0.03
cp gonrun.csv ../Figures/Fig10-nrun/
cd ${MatRox_Fig}/Fig10-nrun/
python3 drawnrun.py --m nrun.csv --g gonrun.csv
