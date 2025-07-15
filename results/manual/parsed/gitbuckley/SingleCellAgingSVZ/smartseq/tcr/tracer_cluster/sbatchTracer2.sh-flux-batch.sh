#!/bin/bash
#FLUX: --job-name=tracerConda
#FLUX: --urgency=16

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
