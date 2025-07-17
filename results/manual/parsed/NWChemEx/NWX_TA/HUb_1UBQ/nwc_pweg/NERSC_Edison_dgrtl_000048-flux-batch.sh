#!/bin/bash
#FLUX: --job-name=eds_nwc_pweg_dgrtl_000048
#FLUX: -N=2
#FLUX: --queue=regular
#FLUX: -t=21600
#FLUX: --urgency=16

export NWCHEM_MEMORY_HEAP='6553600'
export NWCHEM_MEMORY_STACK='104857600'
export NWCHEM_MEMORY_GLOBAL='268435456'
export NWCHEM_BASIS_LIBRARY='/global/common/sw/cray/cnl6/ivybridge/nwchem/6.6/intel/17.0.2.174/kdw3gtl/share/nwchem/libraries/'
export SCRATCH_DIR='$SCRATCH/$SLURM_JOB_NAME.$SLURM_JOB_ID'
export PERMANENT_DIR='$SCRATCH_DIR'
export OMP_NUM_THREADS='1'
export START_DIR='`pwd`'

export NWCHEM_MEMORY_HEAP=6553600
export NWCHEM_MEMORY_STACK=104857600
export NWCHEM_MEMORY_GLOBAL=268435456
export NWCHEM_BASIS_LIBRARY=/global/common/sw/cray/cnl6/ivybridge/nwchem/6.6/intel/17.0.2.174/kdw3gtl/share/nwchem/libraries/
export SCRATCH_DIR=$SCRATCH/$SLURM_JOB_NAME.$SLURM_JOB_ID
export PERMANENT_DIR=$SCRATCH_DIR
export OMP_NUM_THREADS=1
export START_DIR=`pwd`
env | sort
pwd
mkdir $SCRATCH_DIR
cd ..
cp nwc_pweg/nwc_pweg_dgrtl.nw  $SCRATCH_DIR
cp struct_h_added/dgrtl.pdb    $SCRATCH_DIR
cd 
cp edison/nwchem-1/bin/LINUX64/nwchem $SCRATCH_DIR
cd $SCRATCH_DIR
srun -n $SLURM_NPROCS ./nwchem nwc_pweg_dgrtl.nw
rm -rf $SCRATCH_DIR
