#!/bin/bash
#SBATCH --job-name=runMrBayes
#SBATCH --output=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runMrBayes/runMrBayes_%A_%a.out
#SBATCH --error=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runMrBayes/runMrBayes_%A_%a.err
#SBATCH --mail-user=bend@uchicago.edu
#SBATCH --mail-type=START,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --array=193-288%30

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
