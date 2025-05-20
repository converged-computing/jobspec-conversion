# Flux batch script equivalent

# Resources
--nodes=1
--cores=4
--memory=62G
--time=80:00:00
--partition=small,amdsmall

# Job name
--jobname=BUSCO

# Software
module load python/2

# Application and arguments
src=/home/research/genome/assemblies_configs/
input=/home/research/genome/final_assembly/pilon_final_122418.fa
lineage=/home/research/genome/assemblies_configs/lineage/actinopterygii_odb9
busco=/home/software/busco/2.0/bin/BUSCO.py

python2 $busco -i $input -o 122418_final_assembly -l $lineage -f -m geno -sp zebrafish