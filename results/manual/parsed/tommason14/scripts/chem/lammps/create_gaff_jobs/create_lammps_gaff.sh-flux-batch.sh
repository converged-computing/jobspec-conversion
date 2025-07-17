#!/bin/bash
#FLUX: --job-name=moolicious-milkshake-7793
#FLUX: -n=16
#FLUX: --queue=comp,short
#FLUX: -t=10800
#FLUX: --urgency=16

export lammps='/projects/sn29/apps/clammps/build/lmp_mpi'

[ $# -lt 6 ] &&
  echo "Syntax: $(basename "$0") -c geodesic.log -x molecule.xyz -f gaff.ff [-s mon|m3]" &&
  echo "By default, a job script for monarch is created." &&
  echo "Also assumes that there is a pack.inp file for packmol to use." &&
  exit 1
while [ $# -gt 0 ]
do
  option="$1"
  case "$option" in
    -c) charges="$2" 
        shift
        shift
        ;;
    -x) mon_xyz="$2"
        shift
        shift
        ;;
    -f) ff="$2"
        shift
        shift
        ;;
    -s) sc="$2"
        shift
        shift
        ;;
  esac
done
scriptlocation="$(dirname "$0")"
mon_data="${mon_xyz%.*}.data"
mod_ff="gaff_modified.ff"
if [ "$USER" = "tommason" ] || [ "$USER" = "tmas0023" ] 
then
  sed="gsed"
  grep="ggrep"
else
  sed="sed"
  grep="grep"
fi
"$scriptlocation"/lmp_gaff.py "$mon_xyz" "$ff"
"$scriptlocation"/average_partial_charges.py -c "$charges" -d "$mon_data" -f "$ff"
packmol < pack.inp
"$scriptlocation"/lmp_gaff.py system.xyz "$mod_ff"
"$scriptlocation"/change_molecule_id.py system.data 
[ ! -d rundir ] && mkdir rundir
mv system.data rundir/
[ ! -d intermediates ] && mkdir intermediates
mv "$mon_data" "$mod_ff" system.xyz intermediates/
cat << ENDINP >> rundir/in.lmp
units           real
boundary        p p p
neighbor        2.0 bin
neigh_modify    every 1 delay 0 check yes
atom_style      full
bond_style      harmonic
angle_style     harmonic
dihedral_style  fourier
improper_style  cvff
pair_style      lj/charmm/coul/long 9.0 10.0 10.0
kspace_style    pppm 0.0001
pair_modify     mix arithmetic
special_bonds   amber
read_data       system.data
thermo_style    custom step cpu etotal ke pe evdwl ecoul elong temp press vol density
thermo          1000
dump d1 all     custom 1000 traj.lmp element xu yu zu
dump_modify d1  element elements
dump_modify d1  sort id
minimize        0.0 1.0e-8 1000 100000
fix             SHAKE all shake 0.0001 20 0 b bonds
velocity        all create 298 298 dist gaussian
timestep        1
fix 8 all       npt temp 298 298 200 iso 1 1 1000 tchain 3 pchain 3 mtk yes
restart         1000 sim.restart1 sim.restart2
run             200000
undump d1
unfix 8
write_data output.data
ENDINP
if [ -z "$sc" ] || [ "$sc" = "mon" ]
then
cat <<\ENDMONJOB >> rundir/job.slm
module load openmpi
export lammps='/mnt/lustre/projects/p2015120004/apps/clammps/build/lmp_mpi'
srun --export=all -n $SLURM_NTASKS $lammps -in in.lmp > lammps.out
find . -empty -delete
ENDMONJOB
elif [ "$sc" = "m3" ] 
then
cat <<\ENDMASJOB >> rundir/job.slm
module load openmpi/1.10.7-mlx
export lammps='/projects/sn29/apps/clammps/build/lmp_mpi'
srun --export=all -n $SLURM_NTASKS $lammps -in input_file.lmp > lammps.out
find . -empty -delete
ENDMASJOB
fi
bonds=$(
  $sed -n '/Bond Coeffs/,/Angle Coeffs/p' rundir/system.data |
  $grep '# H\|-H' |
  awk '{print $1}' |
  tr '\n' ' '
)
$sed -i "s/b bonds/b $bonds/" rundir/in.lmp
elements=$(
  $sed -n '/Pair Coeffs/,/Bond Coeffs/p' rundir/system.data |
  $grep '#' |
  awk '{print $NF}' |
  $grep -Po "^[A-Z]" |
  tr '\n' ' '
)
$sed -i "s/elements/$elements/" rundir/in.lmp
