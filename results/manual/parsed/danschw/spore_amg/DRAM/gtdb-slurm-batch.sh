#!/bin/bash
#SBATCH --mail-user=jrodram@colostate.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100gb
#SBATCH --time=9-02:00:00
#SBATCH --partition=wrighton-hi
#SBATCH --nodelist=zenith

cd /home/projects/Sporulation_AMG/hmp/VirHostMatcher/
gtdbtk classify_wf --extension fna --genome_dir /home/projects/Sporulation_AMG/hmp/VirHostMatcher/host --out_dir /home/projects/Sporulation_AMG/hmp/VirHostMatcher/GTDB_1.5.0_jrr
