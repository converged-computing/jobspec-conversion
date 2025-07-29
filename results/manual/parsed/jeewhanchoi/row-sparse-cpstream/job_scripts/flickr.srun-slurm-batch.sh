#!/bin/bash
#SBATCH --job-name=cc
#SBATCH --account=hpctensor
#SBATCH --output=rsp_flickr.out
#SBATCH --error=rsp_flickr.err
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
./build/Linux-x86_64/bin/splatt cpd -v --stream=4 -r 10 -t 56 --reg=frob,1e-2,4 ../hpctensor/flickr-4d.tns
