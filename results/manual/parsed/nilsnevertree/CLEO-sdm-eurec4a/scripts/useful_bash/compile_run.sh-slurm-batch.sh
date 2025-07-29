#!/bin/bash
#SBATCH --job-name=run_cleocoupledsdm
#SBATCH --account=mh1126
#SBATCH --output=./gpu_cleocoupledsdm_out.%j.out
#SBATCH --error=./gpu_cleocoupledsdm_err.%j.out
#SBATCH --mail-user=clara.bayley@mpimet.mpg.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --mem=30G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=128

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
