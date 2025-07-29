#!/bin/bash
#SBATCH --job-name=runexample
#SBATCH --account=mh1126
#SBATCH --output=./runexample_out.%j.out
#SBATCH --error=./runexample_err.%j.out
#SBATCH --mail-user=clara.bayley@mpimet.mpg.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=128

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

buildtype=$1
path2CLEO=$2
path2build=$3
executables="$4"
pythonscript=$5
script_args="$6"
cleoenv=/work/mh1126/m300950/cleoenv
python=${cleoenv}/bin/python3
spack load cmake@3.23.1%gcc
module load python3/2022.01-gcc-11.2.0
source activate ${cleoenv}
echo "----- Running Example -----"
echo "buildtype:  ${buildtype}"
echo "path2CLEO: ${path2CLEO}"
echo "path2build: ${path2build}"
echo "executables: ${executables}"
echo "pythonscript: ${pythonscript}"
echo "script_args: ${script_args}"
echo "---------------------------"
${path2CLEO}/scripts/bash/build_cleo.sh ${buildtype} ${path2CLEO} ${path2build}
cd ${path2build} && make clean
${path2CLEO}/scripts/bash/compile_cleo.sh ${cleoenv} ${buildtype} ${path2build} "${executables}"
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
${python}  ${pythonscript} ${path2CLEO} ${path2build} ${script_args}
