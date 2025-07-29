#!/bin/bash
#SBATCH --job-name=TensorFlow
#SBATCH --output=Job.%N.%j.out
#SBATCH --error=Job.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=00:06:00

module load Anaconda3/5.0.1-fasrc01
python -c "import datetime; print(\"Date and time is: \" + str(datetime.datetime.now()))"
