#!/bin/bash
#FLUX: --job-name=gloopy-signal-2177
#FLUX: -n=36
#FLUX: --queue=comp
#FLUX: -t=259200
#FLUX: --urgency=16

module load openmpi/1.10.3-gcc4-mlx-verbs
lammps=~/p2015120004/apps/lammps-stable_29Oct2020/bin/lmp_monarch
data='pdata.lmp'
pairs='pair-drude.lmp'
atoms="$(lammps_print_atom_types.sh $data)"
cores="$(lammps_print_core_types.sh $data)"
drudes="$(lammps_print_drude_types.sh $data)"
waters="$(lammps_print_molecule_types.sh $data water)"
drudefix="$(lammps_print_drude_fix.py $data)"
shakefix="$(lammps_print_shake_fix.py -d $data -x HOw)" # water is fixed via fix rigid, not SHAKE
elements="$(lammps_print_elements.py $data)"
mpirun -np $SLURM_NTASKS $lammps -in input.pol.lmp \
  -v data "$data" \
  -v pairs "$pairs" \
  -v atoms "$atoms" \
  -v cores "$cores" \
  -v drudes "$drudes" \
  -v waters "$waters" \
  -v drudefix "$drudefix" \
  -v shakefix "$shakefix" \
  -v elements "$elements" >& lammps.out
