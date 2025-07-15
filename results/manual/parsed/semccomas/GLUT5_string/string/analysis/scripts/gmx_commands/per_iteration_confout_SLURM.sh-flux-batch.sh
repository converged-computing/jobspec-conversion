#!/bin/bash
#FLUX: --job-name=confused-peanut-0055
#FLUX: --urgency=16

module load gromacs/2020.2
trajext='../../../../../2021071200_GLUT5_string_influx_TMD/GLUT5_string/string/string_sims/TMD_initial_path'
trajdir='influx_apo_gate_CV'
iteration=0
max_beads=15
other_beads_max=$((max_beads-1))
gmx editconf -f $trajext/$trajdir/md/0/0/restrained/confout.gro -o ../confout_files/pdb_clips/$trajdir.$iteration.0.pdb -n $trajext/$trajdir/topology/index.ndx -ndef <<EOF 
0
EOF
gmx editconf -f $trajext/$trajdir/md/0/$max_beads/restrained/confout.gro -o ../confout_files/pdb_clips/$trajdir.$iteration.$max_beads.pdb -n $trajext/$trajdir/topology/index.ndx -ndef << EOF
0
EOF
for i in $(seq 1 $other_beads_max); do 
gmx editconf -f $trajext/$trajdir/md/$iteration/$i/restrained/confout.gro -o ../confout_files/pdb_clips/$trajdir.$iteration.$i.pdb -n $trajext/$trajdir/topology/index.ndx -ndef << EOF
0
EOF
done
eval "cat ../confout_files/pdb_clips/$trajdir.$iteration.{0..$max_beads}.pdb > ../confout_files/measure_per_iteration/$trajdir.$iteration.string.pdb"
