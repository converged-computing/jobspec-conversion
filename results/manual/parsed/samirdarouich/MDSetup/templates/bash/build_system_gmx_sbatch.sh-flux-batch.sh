#!/bin/bash
#FLUX: --job-name=delicious-cinnamonbun-7038
#FLUX: --urgency=16

module purge
module load chem/gromacs/2023.3
WORKING_PATH={{folder}}
cd $WORKING_PATH
echo "This is the working path: $WORKING_PATH"
{%- for coord, mol, nmol in coord_mol_no %}
{%- if loop.index0 == 0 and not initial_system %}
gmx_mpi insert-molecules -ci {{ coord }} -nmol {{ nmol }} -box {{ box_lengths.x[0]|abs + box_lengths.x[1]|abs box_lengths.y[0]|abs + box_lengths.y[1]|abs box_lengths.z[0]|abs + box_lengths.z[1]|abs }} -try {{ n_try }} -o temp{{ loop.index0 }}.gro
{%- elif loop.index0 == 0 %}
gmx_mpi insert-molecules -ci {{ coord }} -nmol {{ nmol }} -f {{ initial_system }} -try {{ n_try }} -o temp{{ loop.index0 }}.gro
{%- else %} 
gmx_mpi insert-molecules -ci {{ coord }} -nmol {{ nmol }} -f temp{{ loop.index0-1 }}.gro -try {{ n_try }} -o temp{{ loop.index0 }}.gro
{%- endif %}
{%- endfor %}
mv temp{{ coord_mol_no | length - 1 }}.gro {{output_coord}}
rm -f \#*.gro.*#
echo "Ending. Job completed."
