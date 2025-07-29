#!/bin/bash
#SBATCH --job-name=notes2parquet
#SBATCH --output=slurm-%A-%a.out
#SBATCH --error=slurm-%A-%a.err
#SBATCH --mail-user=ashah282@uic.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --partition=cpu-t3
#SBATCH --array=5

printf 'Load modules\n'
module load R/4.2.1-foss-2022a
task="convert"
if [[ $task == "prepare" ]]
then
	# Slurm settings above will be used to help chunk the data
	# These mini-batches help with processing speed
	# Diagnoses
	# These need to be converted from ICD-9 to ICD-10
	# The raw file with mixed ICD codes should be called 'diagnosis-raw.csv'
	# The output file will then be 'diagnosis.csv'
	Rscript R/convert-icdCodes.R $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_COUNT
fi
if [[ $task == "split" ]]
then 
	# Years setup (2010 to 2023 is 14...)
	years=($(seq 2010 2023))
	year=${years[$SLURM_ARRAY_TASK_ID - 1]}
	# Past to R script with variable for years
	# Remember to update partition if using large files (e.g. procedure-records)
	# Can also select which variables are to be evaluated in Rscript
	printf "Splitting data for: $year\n"
	Rscript R/split-ccts2csv.R $year
fi
if [[ $task == "convert" ]]
then
	# Data types below = 9 overall
	types=(
		'demographics' # 1
		'diagnosis' # 2
		'labs' # 3
		'medications' # 4
		'notes' # 5
		'procedure-dates' # 6
		'procedure-reports' # 7
		'visits' # 8
		'vitals' # 9
	)
	# Type is the part of the script that will be analyzed
	type=${types[$SLURM_ARRAY_TASK_ID - 1])}
	# Rscript to run
	Rscript R/split-csv2parquet.R $type
fi
