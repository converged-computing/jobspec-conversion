#!/bin/bash
#SBATCH --job-name=mpi-test
#SBATCH --account=YOUR_ALLOCATION
#SBATCH --output=launcher.o%j
#SBATCH --nodes=2
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

module load python3
module load cuda/12.0
module load tacc-apptainer
ibrun -n 16 -o  0 task_affinity singularity exec --nv tacc-tutorial.sif python test_mpi.py --job_id 0 > output/job0.txt &   
ibrun -n 16 -o 16 task_affinity singularity exec --nv tacc-tutorial.sif python test_mpi.py --job_id 1 >  output/job1.txt & 
wait
