#!/bin/bash
#FLUX: --job-name=kmc-matrix
#FLUX: -t=604800
#FLUX: --priority=16

module load kmc/3.1
<<COMM
while read line
do
srr_id=`echo "${line}" | sed 's/\/directory\/\(.*\)_contigs.fasta/\1/g'`
mkdir output_${srr_id}
kmc -k30 -t8 -fa ${line} ${srr_id}.out output_${srr_id}
kmc_dump ${srr_id}.out ${srr_id}_freq.txt.tmp
awk '$2="1"' ${srr_id}_freq.txt.tmp > ${srr_id}_freq.txt
sed -i '1i kmer '"$srr_id"'' ${srr_id}_freq.txt
rm ${srr_id}_freq.txt.tmp
rm -rf ${srr_id}.out*
rm -rf output_${srr_id}
done <list_contigs_path.txt
COMM
cat > create_matrix.py <<EOF
import sys
import re
import pandas as pd
import numpy as np
import dask.dataframe as dd
input_file = open("srr_ids.txt")
lines = input_file.readlines()
input_file = open("srr_ids.txt")
length = len(input_file.readlines())
dfs = []
for i in range(0,length):
    srr_id = lines[i].strip()
    # SRR1002816_freq.txt
    df = dd.read_csv(str(srr_id) + "_freq.txt", sep=" ")
    # dfn = ddf.from_pandas(df3, npartitions=8)
    df[srr_id] = df[srr_id].astype(np.int8)
    df["kmer"] = df["kmer"].astype('category')
    dfs.append(df)
df_fin = dd.concat(dfs)
df_fin = df_fin.groupby("kmer").sum().replace(0,0).reset_index().compute()
df_fin.to_csv(sys.argv[1], sep='\t', index=False)
input_file.close()
EOF
python create_matrix.py newport_matrix_kmer.csv
