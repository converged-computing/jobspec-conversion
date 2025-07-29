#!/bin/bash
#SBATCH --job-name=HiSat2
#SBATCH --account=priority-jenniferlachowiec
#SBATCH --output=example-%j.out
#SBATCH --error=example-%j.err
#SBATCH --mail-user=brodysturgis@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=120
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-3

source ~/.bashrc
module load Anaconda3/2022.05
conda activate brody
for file_r1 in $(ls /home/group/jenniferlachowiec/2023/202302_csativa_flowers/data/raw_rnaseq/*.1.fastq.gz)
do
  file_r2=`echo $file_r1 | sed 's/.1.fastq.gz/.2.fastq.gz/'`
  samFile=`basename $file_r1 | sed 's/.1.fastq.gz/.sam/'`
  logFile=`basename $file_r1 | sed 's/.1.fastq.gz/.log/'`
  hisat2 -p 120 -x /home/group/jenniferlachowiec/2023/202302_csativa_flowers/data/reference/camelina_index -1 $file_r1 -2 $file_r2 -S /home/group/jenniferlachowiec/2023/202302_csativa_flowers/results/hisat2/$samFile --summary-file /home/group/jenniferlachowiec/2023/202302_csativa_flowers/results/hisat2/$logFile
done
