#!/bin/bash
#FLUX: --job-name=amber_heat
#FLUX: -n=32
#FLUX: -t=3600
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1'
export CUDA_HOME='/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.0.3-mwxjoa2nfce32sfsxxxz66oza5p5tr35/'
export AMBERHOME='/home/akhanna2/data/test_amber_modifications/amber20'

whoami
module load openmpi/4.0.6-gcc-8.4.1
module load cuda/11.0.3
export CUDA_VISIBLE_DEVICES=0,1
export CUDA_HOME=/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.0.3-mwxjoa2nfce32sfsxxxz66oza5p5tr35/
export AMBERHOME=/home/akhanna2/data/test_amber_modifications/amber20
module list
echo $LD_LIBRARY_PATH
echo $PATH
$AMBERHOME/bin/pmemd.cuda -O -i box_heat.in -o heat.out -p solute_solvent_box.prmtop -c min.ncrst -r heat.ncrst -x heat.mdcrd -ref min.ncrst -inf heat.info
