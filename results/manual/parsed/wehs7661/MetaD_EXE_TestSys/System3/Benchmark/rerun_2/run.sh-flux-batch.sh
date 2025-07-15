#!/bin/bash
#FLUX: --job-name=rerun_2
#FLUX: --priority=16

source /home/wehs7661/src/plumed2/sourceme.sh
source /home/wehs7661/pkgs/gromacs/2020.2/bin/GMXRC
module load gcc/10.1.0
module load mpi/intel_mpi
mpirun -np 28 gmx_mpi mdrun -s sys3.tpr -x sys3.xtc -c sys3_output.gro -e sys3.edr -dhdl sys3_dhdl.xvg -g sys3.log -cpi state.cpt
