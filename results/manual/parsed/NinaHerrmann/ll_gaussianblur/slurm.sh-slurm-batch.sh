#!/bin/bash
#SBATCH --job-name=GaussianBlurLL_LL_REAL
#SBATCH --output=/scratch/tmp/n_herr03/gaussian/lowlevel/errorandoutput/Gaussian-1802-mili.txt
#SBATCH --error=/scratch/tmp/n_herr03/gaussian/lowlevel/errorandoutput/Gaussian-1802-mili.error
#SBATCH --mail-user=n_herr03@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --time=10:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

module load palma/2020b
module load fosscuda/2020b
cd /home/n/n_herr03/gaussianblur_ll/
nvcc main.cu -I include/ -arch=compute_75 -code=sm_75 -o build/gaussian
for kw in 8 10 12 14 16 18 20; do
	for tile_width in 8 16 32; do
		/home/n/n_herr03/gaussianblur_ll/build/gaussian 1 1 0 $tile_width 1 $kw
	done
	/home/n/n_herr03/gaussianblur_ll/build/gaussian 1 1 0 12 1 $kw
done
