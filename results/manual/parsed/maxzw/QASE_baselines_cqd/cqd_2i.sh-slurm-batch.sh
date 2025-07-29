#!/bin/bash
#SBATCH --output=job_logs/output_%A.out
#SBATCH --error=job_logs/errors_%A.err
#SBATCH --mail-user=m.j.zwager@student.vu.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=1
#SBATCH --time=01:00:00
#SBATCH --partition=gpu_shared

module purge all
module load 2021
module load Anaconda3/2021.05
SCRATCH_DIRECTORY=/global/work/${USER}/kelp/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}
source /home/${USER}/.bashrc
source activate thesis
srun python main.py --do_valid --do_test -n 1 -b 1000 -d 1000 --cpu_num 0 --geo cqd --tasks 2i \
--print_on_screen --test_batch_size 1 --cqd discrete --cqd-t-norm prod --cqd-k 16 --cuda ${@:1}
