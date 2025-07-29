#!/bin/bash
#FLUX: --job-name=trim
#FLUX: -c=24
#FLUX: --queue=phillips
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 skewer
outd="/projects/phillipslab/ateterina/CR_map/FINAL"
repair="/projects/phillipslab/ateterina/scripts/bbmap/repair.sh"
cd /projects/phillipslab/ateterina/CR_map/FINAL
cat Barcodes_Well_EcoR1_Stacks_names.txt |cut -f1 - >ALL_ECOI_BARCODES.txt
split -l 1  ALL_ECOI_BARCODES.txt indbarcode --additional-suffix=.txt
for i in {0..96};do
	barc=$(ls ind*);
	id=$(echo {A..H}{01..12}.barcode.fasta);
	arr=($barc);
	arr2=($id);
	echo ${arr2[$i]};cp ${arr[$i]} ${arr2[$i]};
done
for i in *barcode.fasta;do
	name=${i/.fasta//};
	sed -i "1 i\>$name" $i;
done
mkdir BARCODES
mv *barcode.fasta BARCODES/
rm indbarcode*
for DIR in A1 A2 B1 B2;do
	cd $outd/stacks/$DIR;
	for i in {A..H}{01..12};do
		echo "skewer removes barcodes from ...";
		echo $i;
		skewer -y $outd/BARCODES/$i.barcode.fasta -t 24 -l 36 -r 0.01 -d 0.01  -o ${i}.filt ${i}.1.fq ${i}.2.fq;
		echo "done!";
	done
	for i in *fastq;do
		 mv $i ${i/filt-trimmed-pair/fp};
	done
	mkdir -p RAW
	mv *fq RAW
done
