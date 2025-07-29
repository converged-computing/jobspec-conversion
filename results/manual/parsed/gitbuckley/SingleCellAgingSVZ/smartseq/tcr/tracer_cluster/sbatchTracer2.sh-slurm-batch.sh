#!/bin/bash
#SBATCH --job-name=tracerConda
#SBATCH --account=abrunet1
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:01

date
module load anaconda
source activate tracer_teichlab_2018-03-08
cd /srv/gsfs0/projects/brunet/Buckley/5.BenNSCProject/3.Tcell2/
tracer assemble -c 5.Tracer/CONFIG \
                0.Raw/${F}_R1_001.fastq \
                0.Raw/${F}_R2_001.fastq \
                $F \
                5.Tracer/Output_Conda_Mar15 
date
echo "Finished"
