#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=01:10:10

module load maestro parallel
"$SCHRODINGER/pipeline" -prog mydb phase_inputWnjC.inp -OVERWRITE -HOST localhost:4 -NJOBS 4 -WAIT
