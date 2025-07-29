#!/bin/bash
#SBATCH --job-name=runFastTree
#SBATCH --output=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runFastTree/runFastTree_%A_%a.out
#SBATCH --error=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runFastTree/runFastTree_%A_%a.err
#SBATCH --mail-user=bend@uchicago.edu
#SBATCH --mail-type=START,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=18:00:00
#SBATCH --array=1-288%20

module load julia/1.7.2
projdir="/scratch/midway2/bend/projects/Doran_etal_2022"
sourcefiles=(ls $projdir/data/sims/MSAs/*)
inputfile="${sourcefiles[$SLURM_ARRAY_TASK_ID]}"
name=$(basename $inputfile .phy)
outputdir="${projdir}/_research/runFastTree/${name}"
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
srun julia $projdir/scripts/slurm/runners/runFastTree.jl \
        --inputfile $inputfile \
        --outputdir $outputdir \
        $model \
        --nboot 100 > $outputdir/runFastTree.out
end=`date +%s`
timeelapsed=$((end-start))
echo "time_elapsed: " $timeelapsed
echo "time_elapsed: " $timeelapsed >> $outputdir/runFastTree.out
