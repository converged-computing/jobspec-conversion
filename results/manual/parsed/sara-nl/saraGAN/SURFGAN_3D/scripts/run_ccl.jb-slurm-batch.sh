#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sara-nl/saraGAN/SURFGAN_3D/scripts/run_ccl.jb
