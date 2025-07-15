#!/bin/bash
#FLUX: --job-name=muffled-carrot-8130
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load conda/2019.10
__conda_setup="$('/nopt/nrel/apps/anaconda/2019.10/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/nopt/nrel/apps/anaconda/2019.10/etc/profile.d/conda.sh" ]; then
        . "/nopt/nrel/apps/anaconda/2019.10/etc/profile.d/conda.sh"
    else
        export PATH="/nopt/nrel/apps/anaconda/2019.10/bin:$PATH"
    fi
fi
unset __conda_setup
module load openmpi/3.1.6/gcc-8.4.0
conda activate py-jl-mpi
srun python ./mpi_jl_hello_world.py
srun python ./mpi_jl_pi.py
srun python ./mpi_jl_pi_as_lib.py
srun python ./mpi_jl_cv_pi.py
