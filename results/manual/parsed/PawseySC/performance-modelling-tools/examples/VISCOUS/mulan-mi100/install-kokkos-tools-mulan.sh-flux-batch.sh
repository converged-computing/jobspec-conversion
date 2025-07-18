#!/bin/bash
#FLUX: --job-name=joyous-earthworm-6986
#FLUX: -c=32
#FLUX: -t=1200
#FLUX: --urgency=16

checkout="c901382c4c76b108e4e6d190e9236848dc764526" # 8 August 2022
dir="kokkos-tools-mulan"
umask 007
module unload gcc/9.3.0
module load craype-accel-amd-gfx908
module load rocm/4.5.0
rm -fr $dir
git clone https://github.com/kokkos/kokkos-tools.git $dir
cd $dir
git checkout $checkout
rm -f kp_json_writer kp_reader kp_*.so probes.o profiling/systemtap-connector/probes.h
sed -i '/papi-connector/ s/^make/#make/' build-all.sh 
sed -i '/memory-hwm-mpi/ s/^make/#make/' build-all.sh 
sed -i '/nvprof-/ s/^make/#make/' build-all.sh 
sed -i '/nvprof-focused-connector/a make -f $ROOT_DIR/profiling/roctx-connector/Makefile' build-all.sh
sed -i '/DUSE_MPI=0/ s/^#CFLAGS/CFLAGS/' profiling/space-time-stack/Makefile
sed -i '/DUSE_MPI=0/ s/^#CFLAGS/CFLAGS/' profiling/chrome-tracing/Makefile
sed -i 's/CXX *= *mpicxx/CXX=g++/g' profiling/*/Makefile
bash build-all.sh
