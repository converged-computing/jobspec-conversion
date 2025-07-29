#!/bin/bash
#SBATCH --job-name=DynamO_compile
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=06:00:00
#SBATCH --partition=laird,sixhour,cebc
#SBATCH --constraint=intel

export BOOST_ROOT='$WORK/boost_1_64_0/'
export BOOST_LIBRARYDIR='$WORK/boost_1_64_0/stage/lib'

module purge
module load compiler/gcc/8.3
module load cmake
module load anaconda/4.7
cd build
export BOOST_ROOT=$WORK/boost_1_64_0/
export BOOST_LIBRARYDIR=$WORK/boost_1_64_0/stage/lib
make
