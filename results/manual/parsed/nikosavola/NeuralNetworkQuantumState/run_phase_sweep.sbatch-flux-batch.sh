#!/bin/bash
#FLUX: --job-name=nnqs_phase_sweep
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --priority=16

module load anaconda gcc openmpi
pip install --upgrade "jax[cpu]" "netket[mpi]" typing-extensions
i=$SLURM_ARRAY_TASK_ID
number_of_J2=12
for n in $(seq 1 $number_of_J2); do
    if [ $((n % i)) -eq 0 ]; then
        echo "$n"
        srun python run_phase_sweep.py --hyperparams "data/hyperparams.json" --J2_idx "$n" --J2_max "$number_of_J2"
    fi
done
