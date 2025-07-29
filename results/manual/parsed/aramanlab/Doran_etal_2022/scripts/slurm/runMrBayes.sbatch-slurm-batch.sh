#!/bin/bash
#FLUX: --job-name=runMrBayes
#FLUX: -c=4
#FLUX: --queue=broadwl
#FLUX: --urgency=16

ulimit -u 10000
module load julia/1.7.2
module load mpich/3.2
projdir="/scratch/midway2/bend/projects/Doran_etal_2022"
sourcefiles=(ls $projdir/data/sims/MSAs/*)
inputfile="${sourcefiles[$SLURM_ARRAY_TASK_ID]}"
name=$(basename $inputfile .phy)
outputdir="${projdir}/_research/runMrBayes_rerun/${name}"
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
julia $projdir/scripts/slurm/runners/runMrBayes.jl \
        --inputfile $inputfile \
        --outputdir $outputdir \
        --nproc $SLURM_CPUS_PER_TASK \
        $model \
        --nboot 100 > $outputdir/runMrBayes.out
end=`date +%s`
timeelapsed=$((end-start))
echo "time_elapsed: " $timeelapsed
echo "time_elapsed: " $timeelapsed >> $outputdir/runMrBayes.out
