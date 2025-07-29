#!/bin/bash
#SBATCH --job-name=ABNAME0000
#SBATCH --account=454HTPSeq
#SBATCH --output=outerr/H3.%j.out
#SBATCH --error=outerr/H3.%j.err
#SBATCH --mail-user=jeffreyjgray@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal

export MKL_MIC_ENABLE='1'

ROSETTA=$WORK/git/Rosetta
ROSETTABIN=$ROSETTA/main/source/bin
ROSETTAEXE=antibody_H3
COMPILER=mklmpi.linuxiccrelease
EXE=$ROSETTABIN/$ROSETTAEXE.$COMPILER
echo Starting MPI job running $EXE
export MKL_MIC_ENABLE=1
time ibrun $EXE @../abH3.flags
