#!/bin/bash
#SBATCH --account=phy210030p
#SBATCH --output=/ocean/projects/phy210030p/akshay2/Slurm_logs/RM_accelsearch_slurm_%j.log
#SBATCH --mail-user=akshay2
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-08:00:00
#SBATCH --constraint=ntasks-per-node=128

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
module swap intel pgi
module load mpi/pgi_openmpi
mpirun -n $SLURM_NTASKS singularity exec -B /local $SINGULARITY_CONT \
	python /ocean/projects/phy210030p/akshay2/HPC_pulsar/executables/accelsearch_sift_fold.py \
       -i /ocean/projects/phy210030p/akshay2/HPC_pulsar/config/accel.cfg
