#!/bin/bash
#FLUX: --job-name=chunky-poodle-2643
#FLUX: --priority=16

module purge
module load chem/gromacs/2023.3
WORKING_PATH={{working_path}}
cd $WORKING_PATH
echo "This is the working path: $WORKING_PATH"
{% for ensemble_name, ensemble in ensembles.items() %}
echo ""
echo "Starting ensemble: {{ensemble_name}}"
echo ""
mkdir -p {{ensemble_name}}
cd {{ensemble_name}}
gmx_mpi grompp {{ensemble.grompp}}
mpirun -n 20 gmx_mpi mdrun {{ensemble.mdrun}}
echo "Completed ensemble: {{ensemble_name}}"
cd ../
sleep 10
{% endfor %}
echo "Ending. Job completed."
