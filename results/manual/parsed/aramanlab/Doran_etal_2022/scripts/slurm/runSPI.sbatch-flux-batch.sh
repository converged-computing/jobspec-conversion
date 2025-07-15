#!/bin/bash
#FLUX: --job-name=runSPI
#FLUX: -c=10
#FLUX: --queue=broadwl
#FLUX: -t=300
#FLUX: --urgency=16

module load julia/1.7.2
projdir="/scratch/midway2/bend/projects/Doran_etal_2022"
sourcefiles=(ls $projdir/data/sims/MSAs/*)
inputfile="${sourcefiles[$SLURM_ARRAY_TASK_ID]}"
name=$(basename $inputfile .phy)
outputdir="${projdir}/_research/runSPI/${name}"
mkdir -p $outputdir
echo "projdir: " $projdir
echo "inputfile: " $inputfile
echo "name: " $name
echo "outputdir: " $outputdir
start=`date +%s`
srun julia --threads=$SLURM_CPUS_PER_TASK scripts/slurm/runners/runSPI.jl \
    -i $inputfile \
    -o $outputdir \
    --nboot 100 > $outputdir/runSPI.out
end=`date +%s`
timeelapsed=$((end-start))
echo "time_elapsed: " $timeelapsed
echo "time_elapsed: " $timeelapsed >> $outputdir/runSPI.out
