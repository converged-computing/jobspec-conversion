#!/bin/bash
#FLUX: --job-name=CompileSIMPLE
#FLUX: -c=12
#FLUX: -t=300
#FLUX: --urgency=16

export INTEL_DIR='/usr/local/intel/2017u4/'

MASSIVE=m3.massive.org.au
MASSIVE_USERNAME=$1
MASSIVE_ACCOUNT=el85
cat <<EOF  > buildsimple
module load fftw/3.3.5-gcc5 cmake/3.5.2 git/2.8.1 gcc/5.4.0
cd ~/${SLURM_JOB_ACCOUNT}_scratch/${MASSIVE_USERNAME}/SIMPLE3.0
git pull --rebase
[ -d tmpbuild ] && rm -rf tmpbuild
mkdir tmpbuild
cd tmpbuild
cmake  -DUSE_OPENACC=OFF -DUSE_MPI=OFF  -DUSE_CUDA=OFF -DCMAKE_BUILD_TYPE=DEBUG .. -Wdev  --debug-trycompile > log_cmake 2> log_cmake_err
make -j12 install > log_make 2> log_make_err
. add2.bashrc
ctest -V
OMP_NUM_THREADS=4 simple_test_omp
EOF
cat <<EOF > buildsimplegcc8
module load  git fftw cmake/3.5.2  gcc/8.1.0
cd ~/${SLURM_JOB_ACCOUNT}_scratch/${MASSIVE_USERNAME}/SIMPLE3.0
git pull --rebase
[ -d tmpbuild-gcc8 ] && rm -rf tmpbuild-gcc8
mkdir tmpbuild-gcc8
cd tmpbuild-gcc8
cmake  -DUSE_OPENACC=OFF -DUSE_MPI=OFF  -DUSE_CUDA=OFF -DCMAKE_BUILD_TYPE=DEBUG ..  -Wdev  --debug-trycompile > log_cmake 2> log_cmake_err
make -j12 install > log_make 2> log_make_err
. add2.bashrc
ctest -V  > log_check 2> log_check_err
OMP_NUM_THREADS=4 simple_test_omp
EOF
cat <<EOF  > buildsimpleintel
module load git cmake/3.5.2 intel/2017u4
export INTEL_DIR=/usr/local/intel/2017u4/
 . \${INTEL_DIR}/bin/compilervars.sh intel64
 . \${INTEL_DIR}/mkl/bin/mklvars.sh intel64 lp64
cd ~/${SLURM_JOB_ACCOUNT}_scratch/${MASSIVE_USERNAME}/SIMPLE3.0
git pull --rebase
[ -d tmpbuild-intel ] && rm -rf tmpbuild-intel
mkdir tmpbuild-intel
cd tmpbuild-intel
 FC=ifort CC=icc CXX=icpc LDFLAGS="" cmake -DVERBOSE=ON -DSIMPLE_BUILD_GUI=OFF -DUSE_OPENACC=OFF -DUSE_MPI=OFF -DCMAKE_BUILD_TYPE=RELEASE -Wdev -DINTEL_OMP_OVERRIDE=ON -DUSE_AUTO_PARALLELISE=ON --debug-trycompile .. > log_cmake 2> log_cmake_err
make -j12 install > log_make 2> log_make_err
. add2.bashrc
ctest -V > log_check 2> log_check_err
OMP_NUM_THREADS=4 simple_test_omp
EOF
cat <<EOF > buildsimplecudampi
module load  cuda/8.0.61 fftw/3.3.5-gcc5 cmake/3.5.2 git/2.8.1 gcc/5.4.0 openmpi/1.10.3-gcc5-mlx
cd ~/${SLURM_JOB_ACCOUNT}_scratch/${MASSIVE_USERNAME}/SIMPLE3.0
git pull --rebase
[ -d tmpbuildall ] && rm -rf tmpbuildall
mkdir tmpbuildall
cd tmpbuild
FC=mpifort CC=mpicc CXX=mpicxx cmake  -DVERBOSE=ON -DSIMPLE_BUILD_GUI=OFF -DUSE_OPENACC=ON -DUSE_MPI=ON -DUSE_CUDA=ON -DCMAKE_BUILD_TYPE=DEBUG -BUILD_SHARED_LIBS=ON .. > log_cmake 2> log_cmake_err
make -j12 install > log_make 2> log_make_err
. add2.bashrc
ctest -V > log_check 2> log_check_err
OMP_NUM_THREADS=4 simple_test_omp
srun simple_test_mpi
module load virtualgl
vglrun simple_test_cuda
EOF
cat <<EOF > buildsimple-gcc4.9-mpi
module load  fftw/3.3.4-gcc cmake/3.5.2 git/2.8.1 gcc/4.9.3 openmpi/1.10.3-gcc4-mlx-verbs
cd ~/${SLURM_JOB_ACCOUNT}_scratch/${MASSIVE_USERNAME}/SIMPLE3.0
git pull --rebase
[ -d tmpbuildgcc4 ] && rm -rf tmpbuildgcc4
mkdir tmpbuildgcc4
cd tmpbuild
FC=mpifort CC=mpicc CXX=mpicxx cmake  -DVERBOSE=ON -DSIMPLE_BUILD_GUI=OFF -DUSE_OPENACC=OFF -DUSE_MPI=ON -DUSE_CUDA=OFF -DCMAKE_BUILD_TYPE=DEBUG -BUILD_SHARED_LIBS=ON .. > log_cmake 2> log_cmake_err
make -j12 install > log_make 2> log_make_err
. add2.bashrc
ctest -V > log_check 2> log_check_err
OMP_NUM_THREADS=4 simple_test_omp
srun ./bin/simple_test_mpi
EOF
