#!/bin/bash
#SBATCH --job-name=kmc
#SBATCH --output=out_kmc_%j.log
#SBATCH --mail-user=pveltsos@ku.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20gb
#SBATCH --time=05:59:00
#SBATCH --partition=sixhour

echo "Running"
cd /home/p860v026/temp/$1
mkdir tmp
ls *.fasta.gz > FILES
pwd; hostname; date
kmc -k21 -t16 -m4 -ci1 -fm -cs1000000 @FILES kmc_$1 tmp =  = 
kmc_tools transform kmc_$1 histogram kmc_$1\_k21.hist -cx1000000
module load R/3.6
genomescope.R -i kmc_$1\_k21.hist -k 21 -p 2 -o genomescope_kmc_$1_\k21
tar -zcvf genomescope_kmc_$1_\k21.tar.gz genomescope_kmc_$1_\k21
