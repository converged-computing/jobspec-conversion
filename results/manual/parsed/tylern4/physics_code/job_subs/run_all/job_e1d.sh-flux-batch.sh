#!/bin/bash
#FLUX: --job-name=e1d_data
#FLUX: -n=28
#FLUX: --queue=defq,BigMem,gpu,defq-48core,gpu-v100-16gb,gpu-v100-32gb,msmoms
#FLUX: --urgency=16

export CC='$(which gcc)'
export CXX='$(which g++)'
export CMAKE_DIR='/work/gothelab/software/cmake'
export PATH='$ROOTSYS/bin:$PATH'
export ROOTSYS='/work/gothelab/software/root'
export PYTHONDIR='$ROOTSYS'
export LD_LIBRARY_PATH='$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH'
export PYTHONPATH='/usr/local/lib:$ROOTSYS/lib:$PYTHONPATH:$ROOTSYS/bindings/pyroot'
export NUM_THREADS='$SLURM_JOB_CPUS_PER_NODE '

module load gcc/6.4.0
module load python3/anaconda/2020.02
module load valgrind/3.14
export CC=$(which gcc)
export CXX=$(which g++)
export CMAKE_DIR=/work/gothelab/software/cmake
export PATH=$CMAKE_DIR/bin:$PATH
export ROOTSYS=/work/gothelab/software/root
export PATH=$ROOTSYS/bin:$PATH
export PYTHONDIR=$ROOTSYS
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
export PYTHONPATH=/usr/local/lib:$ROOTSYS/lib:$PYTHONPATH:$ROOTSYS/bindings/pyroot
cd /home/tylerns/physics_code/build
export NUM_THREADS=$SLURM_JOB_CPUS_PER_NODE 
echo $SLURM_JOB_CPUS_PER_NODE
./e1d /work/tylerns/e1d/outputs/e1d_data.root /work/gothelab/clas6/e1d/golden_run/*.root
./e1d /work/tylerns/e1d/outputs/e1d_empty.root /work/gothelab/clas6/e1d/empty/*.root
./csv_maker -o /work/tylerns/e1d/outputs/csv/data -e1d /work/gothelab/clas6/e1d/golden_run
./csv_maker -o /work/tylerns/e1d/outputs/csv/empty -e1d /work/gothelab/clas6/e1d/empty
