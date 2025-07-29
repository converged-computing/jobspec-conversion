#!/bin/bash
#SBATCH --job-name=margo-p2p-bw
#SBATCH --account=csc332
#SBATCH --output=%x-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

. /ccs/home/carns/working/src/spack/share/spack/setup-env.sh
spack env activate crusher-demo
spack find -vN
srun -n 2 --ntasks-per-node=1 /ccs/home/carns/working/install-crusher/bin/margo-p2p-bw -x 8388608 -n "cxi://" -c 8 -D 20
