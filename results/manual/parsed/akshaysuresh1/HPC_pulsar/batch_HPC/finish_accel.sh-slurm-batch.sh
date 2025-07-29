#!/bin/bash
#SBATCH --account=phy210030p
#SBATCH --output=/ocean/projects/phy210030p/akshay2/Slurm_logs/finishaccel_slurm_%j.log
#SBATCH --mail-user=akshay2
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=35

module load openmpi/3.1.6-gcc8.3.1
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
echo $SLURM_NTASKS
$CMDDIR/finish_accel.cmd
