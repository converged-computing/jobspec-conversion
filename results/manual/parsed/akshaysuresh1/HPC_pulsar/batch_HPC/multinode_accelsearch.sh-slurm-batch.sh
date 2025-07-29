#!/bin/bash
#SBATCH --account=phy210030p
#SBATCH --output=/ocean/projects/phy210030p/akshay2/Slurm_logs/multi_acceljerk_%j.log
#SBATCH --mail-user=akshay2
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=RM
#SBATCH --constraint=ntasks-per-node=26

module load openmpi/3.1.6-gcc8.3.1
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
echo $SLURM_NTASKS
$CMDDIR/multinode_accelsearch.cmd
