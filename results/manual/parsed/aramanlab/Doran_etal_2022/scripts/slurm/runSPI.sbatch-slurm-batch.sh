#!/bin/bash
#SBATCH --job-name=runSPI
#SBATCH --output=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runSPI/runSPI_%A_%a.out
#SBATCH --error=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runSPI/runSPI_%A_%a.err
#SBATCH --mail-user=bend@uchicago.edu
#SBATCH --mail-type=START,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=2G
#SBATCH --time=00:05:00
#SBATCH --array=1-288%20

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
