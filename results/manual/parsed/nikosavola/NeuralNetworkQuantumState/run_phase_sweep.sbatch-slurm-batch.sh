#!/bin/bash
#SBATCH --job-name=nnqs_phase_sweep
#SBATCH --output=nnqs_phase_sweep_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=2GB
#SBATCH --time=02:00:00
#SBATCH --array=1-4

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
