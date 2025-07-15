#!/bin/bash
#FLUX: --job-name=expressive-house-5036
#FLUX: --priority=16

module load gromacs/2020.2
trajext='../../../../../2021071200_GLUT5_string_influx_TMD/GLUT5_string/string/string_sims/TMD_initial_path'
trajdir='influx_apo_gate_CV'
bead=13  #choose 1-14 (0 and 15 are fixed...)
min_iteration=0
max_iteration=745
for i in $(seq $min_iteration $max_iteration); do 
gmx editconf -f $trajext/$trajdir/md/$i/$bead/restrained/confout.gro -o ../confout_files/pdb_clips/$trajdir.bead_$bead.iteration_$i.pdb -n $trajext/$trajdir/topology/index.ndx -ndef << EOF
0
EOF
done
min_iteration=1
eval "cat ../confout_files/pdb_clips/$trajdir.bead_$bead.iteration_{$min_iteration..$max_iteration}.pdb > ../confout_files/measure_per_bead/$trajdir.bead_$bead.string.pdb"
