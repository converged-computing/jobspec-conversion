#!/bin/bash
#SBATCH --job-name=nell
#SBATCH --account=hpctensor
#SBATCH --output=nell.out
#SBATCH --error=nell.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=56
#SBATCH --mem=512G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

export KMP_AFFINITY='granularity=fine,compact,1'
export OMP_NUM_THREADS='56'

export KMP_AFFINITY=granularity=fine,compact,1
export OMP_NUM_THREADS=56
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 56 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 28 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 14 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 8 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 4 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 2 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 1 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
