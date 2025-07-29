#!/bin/bash
#SBATCH --job-name=cc_t2
#SBATCH --account=hpctensor
#SBATCH --output=cc_t2.out
#SBATCH --error=cc_t2.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=56
#SBATCH --mem=512G
#SBATCH --time=12:00:00
#SBATCH --partition=fat
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='56'
export KMP_AFFINITY='granularity=fine,compact,1'

export OMP_NUM_THREADS=56
export KMP_AFFINITY=granularity=fine,compact,1
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 2 --reg=frob,1e-2,1 ../hpctensor/chicago-crime-comm.tns
