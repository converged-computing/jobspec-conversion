#!/bin/bash
#SBATCH --job-name=hathi-rsync
#SBATCH --output=hathi-rsync.out
#SBATCH --error=hathi-rsync.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=10:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=16

rsync -av data.sharc.hathitrust.org::pd-features/basic/ \
    /scratch/PI/malgeehe/htrc/
