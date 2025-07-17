#!/bin/bash
#FLUX: --job-name=chocolate-knife-6493
#FLUX: -c=8
#FLUX: --queue=normal
#FLUX: -t=21600
#FLUX: --urgency=16

echo "Running the cluster/remote build script"
WORKING_DIR=<FINN_WORKDIR>
module reset
module load system singularity
ml fpga
ml xilinx/xrt/2.14
ml xilinx/vitis/22.1
ml devel/Doxygen/1.9.5-GCCcore-12.2.0
ml compiler/GCC/12.2.0
ml devel/CMake/3.24.3-GCCcore-12.2.0
mkdir -p $WORKING_DIR/SINGULARITY_CACHE
mkdir -p $WORKING_DIR/SINGULARITY_TMP
mkdir -p $WORKING_DIR/FINN_TMP
if [ -d "/dev/shm" ]; then
  echo "Copying file to ramdisk"
  cp -r $WORKING_DIR /dev/shm/temporary_finn_dir
  WORKING_DIR=/dev/shm/temporary_finn_dir
  echo "Done."
fi
<SET_ENVVARS>
cd $WORKING_DIR/finn
./run-docker.sh build_custom $1
if [ -d "/dev/shm" ]; then
    echo "Copying files back"
    cp -r $WORKING_DIR <FINN_WORKDIR>
    # Copy back files into FINN_TMP as well, because they could be required for the next run
    cp -r <FINN_WORKDIR>/temporary_finn_dir/FINN_TMP/* <FINN_WORKDIR>/FINN_TMP
fi
