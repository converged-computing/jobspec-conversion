#!/bin/bash
#FLUX: --job-name=runPhyML
#FLUX: --queue=broadwl
#FLUX: -t=14400
#FLUX: --urgency=16

module load julia/1.7.2
projdir="/scratch/midway2/bend/projects/Doran_etal_2022"
sourcefiles=(ls $projdir/data/sims/MSAs/*)
inputfile="${sourcefiles[$SLURM_ARRAY_TASK_ID]}"
name=$(basename $inputfile .phy)
outputdir="${projdir}/_research/runPhyML/${name}"
mkdir -p $outputdir
if [[ $name == *-b20* ]]; then
    model="-m WAG"
else 
    model="-m JC69"
fi
echo "projdir: " $projdir
echo "inputfile: " $inputfile
echo "name: " $name
echo "outputdir: " $outputdir
start=`date +%s`
srun julia $projdir/scripts/slurm/runners/runPhyML.jl \
        --inputfile $inputfile \
        --outputdir $outputdir \
        $model > $outputdir/runPhyML.out
end=`date +%s`
timeelapsed=$((end-start))
echo "time_elapsed: " $timeelapsed
echo "time_elapsed: " $timeelapsed >> $outputdir/runPhyML.out
