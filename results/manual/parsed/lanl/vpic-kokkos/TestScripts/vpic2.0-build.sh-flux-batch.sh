#!/bin/bash
#FLUX: --job-name=gassy-squidward-2621
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export CRAYPE_LINK_TYPE='dynamic '
export NVCC_WRAPPER_DEFAULT_COMPILER='CC'

module swap PrgEnv-cray PrgEnv-gnu
module load cmake cuda
module list
export CRAYPE_LINK_TYPE=dynamic 
export NVCC_WRAPPER_DEFAULT_COMPILER=CC
echo "NVCC_WRAPPER_DEFAULT_COMPILER:" $NVCC_WRAPPER_DEFAULT_COMPILER
echo "CRAYPE_LINK_TYPE:" $CRAYPE_LINK_TYPE
lscpu
nvidia-smi
src_dir=/users/matsekh/VPIC/vpic-kokkos
builds=/lustre/scratch5/.mdt0/matsekh/VPIC/vpic-kokkos-build
mkdir -p $builds
openmp=$builds/openmp
pthreads=$builds/pthreads
function vpic_cmake(){
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_INTEGRATED_TESTS=ON \
  -DENABLE_UNIT_TESTS=ON \
  -DBUILD_INTERNAL_KOKKOS=ON \
  -DENABLE_KOKKOS_CUDA=ON \
  -DVPIC_ENABLE_TEAM_REDUCTION=$6 \
  -DVPIC_ENABLE_HIERARCHICAL=$5\
  -DKokkos_ARCH_ZEN2=ON \
  -DKokkos_ARCH_AMPERE80=ON \
  -DCMAKE_CXX_COMPILER="$(readlink -f $1/kokkos/bin/nvcc_wrapper)" \
  -DCMAKE_CXX_FLAGS=$4 \
  -DKokkos_ENABLE_OPENMP=$3 \
  -DKokkos_ENABLE_PTHREAD=$2 \
  $1
}
function build_deck(){
    $1/bin/vpic $2/TestScripts/data/portability_test_x2-y2-z2.cxx
    $1/bin/vpic $2/TestScripts/data/portability_test_x4-y2-z2.cxx
    $1/bin/vpic $2/TestScripts/data/portability_test_x4-y4-z2.cxx
    $1/bin/vpic $2/TestScripts/data/portability_test_x4-y4-z4.cxx
    $1/bin/vpic $2/TestScripts/data/portability_test_x8-y4-z4.cxx
    $1/bin/vpic $2/TestScripts/data/portability_test_x8-y8-z4.cxx
    $1/bin/vpic $2/TestScripts/data/portability_test_x8-y8-z8.cxx
}
build_dir=$openmp/no-team_no-hierarch
mkdir -p $build_dir 
cd $build_dir
cmake_openmp="ON" 
cmake_pthreads="OFF"
cmake_team_reduction="OFF"
cmake_hierarchical="OFF"
cmake_cxx_flags="-fopenmp -rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$openmp/team_no-hierarch
mkdir -p $build_dir
cd $build_dir
cmake_openmp="ON" 
cmake_pthreads="OFF"
cmake_team_reduction="ON"
cmake_hierarchical="OFF"
cmake_cxx_flags="-fopenmp -rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$openmp/no-team_hierarch
mkdir -p $build_dir
cd $build_dir
cmake_openmp="ON"
cmake_pthreads="OFF"
cmake_team_reduction="OFF"
cmake_hierarchical="ON"
cmake_cxx_flags="-fopenmp -rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$openmp/team_hierarch
mkdir -p $build_dir
cd $build_dir
cmake_openmp="ON"
cmake_pthreads="OFF"
cmake_team_reduction="ON"
cmake_hierarchical="ON"
cmake_cxx_flags="-fopenmp -rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$pthreads/no-team_no-hierarch
mkdir -p $build_dir 
cd $build_dir
cmake_openmp="OFF" 
cmake_pthreads="ON"
cmake_team_reduction="OFF"
cmake_hierarchical="OFF"
cmake_cxx_flags="-rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$pthreads/team_no-hierarch
mkdir -p $build_dir
cd $build_dir
cmake_openmp="OFF" 
cmake_pthreads="ON"
cmake_team_reduction="ON"
cmake_hierarchical="OFF"
cmake_cxx_flags="-rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$pthreads/no-team_hierarch
mkdir -p $build_dir
cd $build_dir
cmake_openmp="OFF"
cmake_pthreads="ON"
cmake_team_reduction="OFF"
cmake_hierarchical="ON"
cmake_cxx_flags="-rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
build_dir=$pthreads/team_hierarch
mkdir -p $build_dir
cd $build_dir
cmake_openmp="OFF"
cmake_pthreads="ON"
cmake_team_reduction="ON"
cmake_hierarchical="ON"
cmake_cxx_flags="-rdynamic -dynamic"
vpic_cmake $src_dir $cmake_pthreads $cmake_openmp $cmake_cxx_flags $cmake_hierarchical $cmake_team_reduction
make
make test
build_deck $build_dir $src_dir
