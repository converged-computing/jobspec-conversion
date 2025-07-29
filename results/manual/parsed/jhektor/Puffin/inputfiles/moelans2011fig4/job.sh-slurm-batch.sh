#!/bin/bash
#SBATCH --job-name=moelansfig4-2d-test
#SBATCH --output=moelansfig4-2d-test_%j.out
#SBATCH --error=moelansfig4-2d-test_%j.err
#SBATCH --mail-user=johan.hektor@solid.lth.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --qos=test
#SBATCH --exclusive

cat $0
ml load GCC/6.3.0-2.27
ml load OpenMPI/2.0.2
ml load Moose_framework
mpirun -bind-to-core ../../puffin-opt -i imcsphere2d.i
