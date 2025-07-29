#!/bin/bash
#SBATCH --account=nstaff_g
#SBATCH --nodes=4
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=gpu

IOR="$HOME/src/iopup/src/ior/bin.muller/ior"
SEGMENTS=256
srun $IOR -t 1m -b 1m -s $SEGMENTS 2>&1 | tee tutorial.1
srun $IOR -t 1m -b 1m -s $SEGMENTS -F 2>&1 | tee tutorial.2
srun $IOR -t 1m -b 1m -s $SEGMENTS -F -C 2>&1 | tee tutorial.3
srun $IOR -t 1m -b 1m -s $SEGMENTS -F -C -e 2>&1 | tee tutorial.4
srun $IOR -t 1m -b 1m -s $SEGMENTS -F -e --posix.odirect 2>&1 | tee tutorial.5
srun $IOR -t 1m -b 1m -s $SEGMENTS -C -e 2>&1 | tee tutorial.6
lfs setstripe -c 4 .
srun $IOR -t 1m -b 1m -s $SEGMENTS -C -e 2>&1 | tee tutorial.7
