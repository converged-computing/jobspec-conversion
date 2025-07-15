#!/bin/bash
#FLUX: --job-name=run_cleocoupledsdm
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module load gcc/11.2.0-gcc-11.2.0
module load python3/2022.01-gcc-11.2.0
module load nvhpc/23.7-gcc-11.2.0
spack load cmake@3.23.1%gcc
source activate /work/mh1126/m300950/cleoenv
path2CLEO=${HOME}/CLEO/
path2build=$1 # get from command line argument(s)
configfile=${HOME}/CLEO/src/config/config.txt
python=python
if [ "${path2build}" == "" ]
then
  path2build=${HOME}/CLEO/build/
fi
echo "path to build directory: ${path2build}"
cd ${path2build} && pwd
make -j 128
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
runcmd="${path2build}/src/cleocoupledsdm ${configfile}"
echo ${runcmd}
${runcmd}
