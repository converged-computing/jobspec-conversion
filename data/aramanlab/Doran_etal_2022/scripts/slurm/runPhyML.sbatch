#!/bin/sh

#SBATCH --job-name=runPhyML
#SBATCH --output=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runPhyML/runPhyML_%A_%a.out
#SBATCH --error=/scratch/midway2/bend/projects/Doran_etal_2022/_research/logs/runPhyML/runPhyML_%A_%a.err
#SBATCH --partition=broadwl
#SBATCH --array=10,58,154,202  # 1-288%20 # 
#SBATCH --cpus-per-task=1 # phyml does not have multithreading (MPI is only available for full bootstraps)
#SBATCH --time=0-04:00:00
#SBATCH --mem-per-cpu=32G  # NOTE DO NOT USE THE --mem=OPTION 
#SBATCH --mail-type=START,END
#SBATCH --mail-user=bend@uchicago.edu

# When running a large number of tasks simultaneously, it may be
# necessary to increase the user process limit.
# ulimit -u 10000

module load julia/1.7.2
# mpich/3.2

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
