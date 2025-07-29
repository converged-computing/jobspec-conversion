#!/bin/bash
#SBATCH --job-name=job-name
#SBATCH --account=username
#SBATCH --mail-user=username@mail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=15-00:00:00

	#for all queues
	#for cuda queue
module load centos7.3/app/namd/2017-11-10-multicore-cuda
echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
$NAMD_DIR/namd2  +p $SLURM_NTASKS  +idlepoll config.conf
