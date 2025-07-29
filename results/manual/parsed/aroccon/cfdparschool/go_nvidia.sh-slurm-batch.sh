#!/bin/bash
#SBATCH --account=tra23_cfd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

module load nvhpc/22.3 
echo $HOSTNAME > hostname.dat
./application_name  > out.4096.C.$SLURM_JOBID.dat
