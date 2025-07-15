#!/bin/bash
#FLUX: --job-name=ex1
#FLUX: --queue=burst
#FLUX: -t=900
#FLUX: --priority=16

echo "Starting job $SLURM_JOB_NAME"
echo "Job id: $SLURM_JOB_ID"
date
echo "This job was assigned the following nodes"
echo $SLURM_NODELIST
echo "Activing environment with that provides Julia 1.9.2"
source /storage/group/RISE/classroom/astro_528/scripts/env_setup
echo "About to change into $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR            # Change into directory where job was submitted from
FILE=./Project_has_been_instantiated
if [ -f "$FILE" ]; then
    echo "# $FILE exists.  Assuming no need to instantiate project to install packages."
else 
    echo "# $FILE does not exist. Will install relevant packages."
    julia --project -e 'import Pkg; Pkg.instantiate() '
    julia --project -e 'import Pluto, Pkg; Pluto.activate_notebook_environment("ex1.jl"); Pkg.instantiate() '
    touch $FILE
fi
date
echo "# About to run Pluto notebook and generate HTML version with outputs, using $SLURM_TASKS_PER_NODE CPU cores on one node"
julia --project -t $SLURM_TASKS_PER_NODE -e 'import Pkg, PlutoSliderServer; Pkg.offline(); PlutoSliderServer.export_notebook("ex1.jl")'
echo "Julia exited"
date
