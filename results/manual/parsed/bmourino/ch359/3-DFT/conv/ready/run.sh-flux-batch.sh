#!/bin/bash
#FLUX: --job-name=<your-job-name>
#FLUX: -t=28800
#FLUX: --priority=16

module load intel
module load gcc/11.3.0
module load openmpi/4.1.3
module load cp2k/9.1-mpi-openmp
cutoffs="50 100 150 200 250 300 350 400 450 500 550 600 650 700"
input_file=mof5.inp
output_file=mof5.out
for ii in $cutoffs ; do
    work_dir=cutoff_${ii}Ry
    cd $work_dir
    if [ -f $output_file ] ; then
        rm $output_file
    fi
'srun' '-n' '36' '/ssoft/spack/syrah/v1/opt/spack/linux-rhel8-skylake_avx512/gcc-11.3.0/cp2k-9.1-klrakkis7sb24thlwnxd7slve3qwspxm/bin/cp2k.popt' '-i' 'mof5.inp'  > $output_file 2>&1
    cd ..
done
wait
