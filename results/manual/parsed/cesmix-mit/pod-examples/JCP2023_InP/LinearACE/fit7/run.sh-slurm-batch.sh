#!/bin/bash
#FLUX: --job-name=InP-PACE
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PYTHONPATH='${HOME}/FitSNAP:$PYTHONPATH'

nodes=$SLURM_JOB_NUM_NODES          # Number of nodes
cores=8                            # Number MPI processes to start on each node
                                    # choose 16 for skybridge, chama and uno
                                    # choose 36 for eclipse, ghost and attaway
                                    # choose 48 for manzano
cores_md=4
module purge
module load cde/v3/gcc/10.3.0
module load cde/v3/cmake/3.23.1
module load cde/v3/openmpi/4.1.2-gcc-10.3.0
__conda_setup="$('/projects/netpub/anaconda3/2022.05/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/projects/netpub/anaconda3/2022.05/etc/profile.d/conda.sh" ]; then
        . "/projects/netpub/anaconda3/2022.05/etc/profile.d/conda.sh"
    else
        export PATH="/projects/netpub/anaconda3/2022.05/bin:$PATH"
    fi
fi
unset __conda_setup
conda init
conda activate fitsnap-pace
export OMP_NUM_THREADS=1
export PYTHONPATH="${HOME}/FitSNAP:$PYTHONPATH"
mpirun -np 36 python -m fitsnap3 InP-example.in --overwrite
