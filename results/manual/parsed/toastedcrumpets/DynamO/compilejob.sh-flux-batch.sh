#!/bin/bash
#FLUX: --job-name=DynamO_compile
#FLUX: --queue=laird,sixhour,cebc
#FLUX: -t=21600
#FLUX: --priority=16

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
