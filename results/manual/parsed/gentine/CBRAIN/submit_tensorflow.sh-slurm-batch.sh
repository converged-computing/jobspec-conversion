#!/bin/bash
#SBATCH --job-name=tensorflow_gpu
#SBATCH --account=glab
#SBATCH --mail-user=pg2328@columbia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-23:59:00

module load intel-parallel-studio/2017
module load cuda80/toolkit cuda80/blas cudnn/5.1 
module load anaconda/2-4.2.0 
mpiexec python  ./main.py --run_validation=true --randomize=true --batch_size=4096 --optim=adam --lr=1e-3 --frac_train=0.8 --log_step=100 --epoch=50 --randomize=true --input_names='TAP,QAP,OMEGA,SHFLX,LHFLX,LAT,dTdt_adiabatic,dQdt_adiabatic' --hidden=32,32 --convo=false # > atoutfile
date
