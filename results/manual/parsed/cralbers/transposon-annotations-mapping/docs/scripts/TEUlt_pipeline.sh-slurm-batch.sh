#!/bin/bash
#SBATCH --job-name=example
#SBATCH --account=libudalab
#SBATCH --output=example.out
#SBATCH --error=example.err
#SBATCH --mail-user=calbers@uoregon.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:59:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=28

module load python3/3.7.5
module load python2/2.7.13
module load easybuild
module load GCC/6.3.0-2.27
module load OpenMPI/2.0.2
module load RepeatModeler/1.0.11
module load RepeatMasker/4.0.7
module load anaconda3/2019.07
conda activate transposon_annotation_reasonaTE
reasonaTE -mode pipeline -projectFolder projectFolder -projectName projectName
