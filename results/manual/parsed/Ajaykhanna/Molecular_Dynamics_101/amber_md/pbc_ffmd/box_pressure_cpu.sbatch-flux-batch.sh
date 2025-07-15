#!/bin/bash
#FLUX: --job-name=amber_pressure
#FLUX: -n=32
#FLUX: -t=259200
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1'
export CUDA_HOME='/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.0.3-mwxjoa2nfce32sfsxxxz66oza5p5tr35/'
export AMBERHOME='/home/akhanna2/data/test_amber_modifications/amber20'

module load cuda/11.0.3
module load openmpi/4.0.6-gcc-8.4.1
export CUDA_VISIBLE_DEVICES=0,1
export CUDA_HOME=/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.0.3-mwxjoa2nfce32sfsxxxz66oza5p5tr35/
export AMBERHOME=/home/akhanna2/data/test_amber_modifications/amber20
whoami
module list
echo $LD_LIBRARY_PATH
echo $PATH
mpirun -np 32 $AMBERHOME/bin/pmemd.MPI -O -i box_pressure.in -o pressure.out -p solute_solvent_box.prmtop -c heat.ncrst -r pressure.ncrst -x pressure.mdcrd -ref pressure.ncrst -inf pressure.info
