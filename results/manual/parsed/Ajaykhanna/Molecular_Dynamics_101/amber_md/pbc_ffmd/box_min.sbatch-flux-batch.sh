#!/bin/bash
#FLUX: --job-name=amber_minize
#FLUX: -n=32
#FLUX: --queue=test
#FLUX: -t=3600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1'
export CUDA_HOME='/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.0.3-mwxjoa2nfce32sfsxxxz66oza5p5tr35/'
export AMBERHOME='/home/akhanna2/data/test_amber_modifications/amber20'

whoami
module load openmpi/4.0.6-gcc-8.4.1
export CUDA_VISIBLE_DEVICES=0,1
export CUDA_HOME=/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.0.3-mwxjoa2nfce32sfsxxxz66oza5p5tr35/
export AMBERHOME=/home/akhanna2/data/test_amber_modifications/amber20
module list
echo $LD_LIBRARY_PATH
echo $PATH
mpirun -np 32 $AMBERHOME/bin/sander.MPI -O -i box_min.in -o min.out -p solute_solvent_box.prmtop -c solute_solvent_box.inpcrd -r min.ncrst -x min.mdcrd -inf min.info
