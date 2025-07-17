#!/bin/bash
#FLUX: --job-name=VAR_Test
#FLUX: -n=16
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load gsl
module load eigen3
module load cray-hdf5-parallel
exe=./uoi_var
input=/global/cscratch1/sd/mbalasu2/var/Model_Data_1000_95_5.h5
output=./test/1/output.h5
output1=./test/1/lasso.h5
L=7
D=1
nlamb=3
B1=5
B2=5
srun -n 16 -c 4 --cpu_bind=cores -u $exe $input $L $D $nlamb $B1 $B2 $output $output1
