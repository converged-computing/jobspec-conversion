#!/bin/bash
#FLUX: --job-name=A-PRO
#FLUX: -c=68
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel/17.0.4
module load gnuparallel
module list
pwd
date
rm -r results_ASTRAL_PRO/; mkdir -p results_ASTRAL_PRO/
rm -r results_ASTRAL_PRO/results_HybPiper_paralog_sequences/; mkdir -p results_ASTRAL_PRO/results_HybPiper_paralog_sequences/
rm -r paralog_retrieval/; mkdir -p paralog_retrieval/
parallel -j 68 bash 6b.ASTRAL_PRO_copy_samples.sh {} :::: 6c.ASTRAL_PRO_namelist.txt
cd paralog_retrieval/
parallel -j 68 "python ../../HybPiper/paralog_retriever.py ../6c.ASTRAL_PRO_namelist.txt {} > {}.paralogs.fasta" :::: ../6d.ASTRAL_PRO_genelist.txt 2> ../6e.ASTRAL_PRO_paralog_counts.txt
cp *.fasta ../results_ASTRAL_PRO/results_HybPiper_paralog_sequences/
cd ..
rm -r paralog_retrieval/
rm -r results_ASTRAL_PRO/results_mafft_preliminary/; mkdir -p results_ASTRAL_PRO/results_mafft_preliminary/
rm -r results_ASTRAL_PRO/results_trimal_preliminary/; mkdir -p results_ASTRAL_PRO/results_trimal_preliminary/
rm -r results_ASTRAL_PRO/results_iqtree_gene_trees_preliminary/; mkdir -p results_ASTRAL_PRO/results_iqtree_gene_trees_preliminary/
rm -r results_ASTRAL_PRO/results_mafft_final/; mkdir -p results_ASTRAL_PRO/results_mafft_final/
rm -r results_ASTRAL_PRO/results_trimal_final/; mkdir -p results_ASTRAL_PRO/results_trimal_final/
rm -r results_ASTRAL_PRO/results_iqtree_gene_trees_final/; mkdir -p results_ASTRAL_PRO/results_iqtree_gene_trees_final/
rm -r results_ASTRAL_PRO/results_treeshrink/; mkdir -p results_ASTRAL_PRO/results_treeshrink/
mkdir -p sequences_one/ sequences_two/ sequences_three/ sequences_four/ sequences_five/ sequences_six/ sequences_seven/ sequences_combined/
cp results_ASTRAL_PRO/results_HybPiper_paralog_sequences/*paralogs.fasta sequences_one/
cp PAFTOL_sequence_data/CRNC/*.FNA sequences_two/
cp PAFTOL_sequence_data/HYZL/*.FNA sequences_three/
cp PAFTOL_sequence_data/MYZV/*.FNA sequences_four/
cp PAFTOL_sequence_data/SRR6441723/*.FNA sequences_five/
cp PAFTOL_sequence_data/ERR4210213/*.FNA sequences_six/
cp PAFTOL_sequence_data/ERR2789774/*.FNA sequences_seven/
cd sequences_two; for f in *.FNA; do mv -- "$f" "${f%.FNA}.paralogs.fasta"; done; cd ..
cd sequences_three; for f in *.FNA; do mv -- "$f" "${f%.FNA}.paralogs.fasta"; done; cd ..
cd sequences_four; for f in *.FNA; do mv -- "$f" "${f%.FNA}.paralogs.fasta"; done; cd ..
cd sequences_five; for f in *.FNA; do mv -- "$f" "${f%.FNA}.paralogs.fasta"; done; cd ..
cd sequences_six; for f in *.FNA; do mv -- "$f" "${f%.FNA}.paralogs.fasta"; done; cd ..
cd sequences_seven; for f in *.FNA; do mv -- "$f" "${f%.FNA}.paralogs.fasta"; done; cd ..
find sequences_one/ sequences_two/ sequences_three/ sequences_four/ sequences_five/ sequences_six/ sequences_seven/ -type f -path '*/*.fasta' -exec basename {} ';' | sort -u -o file.list
while read -r name; do find sequences_two sequences_three sequences_four sequences_five sequences_six sequences_seven sequences_one -type f -path "*/$name" -exec cat {} + > "sequences_combined/$name"; done < file.list
cp sequences_combined/*.fasta results_ASTRAL_PRO/results_HybPiper_paralog_sequences/
rm -r sequences_two/ sequences_three/ sequences_four/ sequences_five/ sequences_six/ sequences_seven/ sequences_combined/ sequences_one/ file.list
sed -i.bak '/1G03190/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G07010/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G08490/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G17760/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G31780/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G43860/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G49540/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G55880/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/1G75330/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/2G21280/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/2G31955/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/2G39090/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G02660/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G06950/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G08650/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G12080/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G20780/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G48500/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G51050/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/3G53760/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/4G02790/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/4G29380/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/4G29830/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/4G33030/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G06830/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G10920/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G13680/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G14760/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G17290/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G18570/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G46180/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G48470/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G48600/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G61770/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G64050/d' 6d.ASTRAL_PRO_genelist.txt
sed -i.bak '/5G67530/d' 6d.ASTRAL_PRO_genelist.txt
sed $'s/[^[:print:]\t]//g' 6d.ASTRAL_PRO_genelist.txt > 6d.ASTRAL_PRO_genelist_any_special_characters_removed.txt
parallel -j 45 'mafft --quiet results_ASTRAL_PRO/results_HybPiper_paralog_sequences/{}.paralogs.fasta > results_ASTRAL_PRO/results_mafft_preliminary/{}.paralogs.mafft.fasta' :::: 6d.ASTRAL_PRO_genelist_any_special_characters_removed.txt
parallel -j 45 'trimal -in results_ASTRAL_PRO/results_mafft_preliminary/{}.paralogs.mafft.fasta -out results_ASTRAL_PRO/results_trimal_preliminary/{}.paralogs.trimal.fasta -resoverlap 0.75 -seqoverlap 0.90 -gt 0.90' :::: 6d.ASTRAL_PRO_genelist_any_special_characters_removed.txt
parallel -j 45 '~/iqtree-2.1.3-Linux/bin/iqtree2 -s results_ASTRAL_PRO/results_trimal_preliminary/{}.paralogs.trimal.fasta -B 1000 -nm 1000 -m GTR+F+R -nt AUTO --prefix results_ASTRAL_PRO/results_iqtree_gene_trees_preliminary/result_{}_iqtree' :::: 6d.ASTRAL_PRO_genelist_any_special_characters_removed.txt
rm results_ASTRAL_PRO/results_iqtree_gene_trees_preliminary/result_6128_iqtree.treefile
ls results_ASTRAL_PRO/results_iqtree_gene_trees_preliminary/*.treefile > 6d.ASTRAL_PRO_genelist_succesfull_temp1.txt
sed 's\results_ASTRAL_PRO/results_iqtree_gene_trees_preliminary/result_\\g' 6d.ASTRAL_PRO_genelist_succesfull_temp1.txt > 6d.ASTRAL_PRO_genelist_succesfull_temp2.txt
sed 's\_iqtree.treefile\\g' 6d.ASTRAL_PRO_genelist_succesfull_temp2.txt > 6d.ASTRAL_PRO_genelist_succesfull.txt
rm 6d.ASTRAL_PRO_genelist_succesfull_temp*.txt
sed -i.bak 's\6128\\g' 6d.ASTRAL_PRO_genelist_succesfull.txt
sed -i.bak '/^$/d' 6d.ASTRAL_PRO_genelist_succesfull.txt
rm -r results_ASTRAL_PRO/temp_treeshrink_ASTRAL_Pro/
mkdir -p results_ASTRAL_PRO/temp_treeshrink_ASTRAL_Pro/
cd results_ASTRAL_PRO/temp_treeshrink_ASTRAL_Pro/
while read gene
do
  mkdir -p ${gene}
  cp ../results_iqtree_gene_trees_preliminary/result_${gene}_iqtree.treefile ${gene}/
  mv ${gene}/result_${gene}_iqtree.treefile ${gene}/input.tree
  cp ../results_trimal_preliminary/${gene}.paralogs.trimal.fasta ${gene}/
  mv ${gene}/${gene}.paralogs.trimal.fasta ${gene}/input.fasta
done < ../../6d.ASTRAL_PRO_genelist_succesfull.txt
python ~/TreeShrink/run_treeshrink.py -i . -t input.tree -a input.fasta -f > treeshrinklog.txt
while read gene
do
  mv ${gene}/input.tree ${gene}/${gene}_treeshrink_input.tree
  mv ${gene}/input.fasta ${gene}/${gene}_treeshrink_input.fasta
  mv ${gene}/output.tree ${gene}/${gene}_treeshrink_output.tree
  mv ${gene}/output.fasta ${gene}/${gene}_treeshrink_output.fasta
  mv ${gene}/output.txt ${gene}/${gene}_treeshrink_output.txt
done < ../../6d.ASTRAL_PRO_genelist_succesfull.txt
cp */*_treeshrink_*put.* ../results_treeshrink/
cp treeshrinklog.txt ../results_treeshrink/
mv output_summary.txt treeshrink_output_summary.txt
cp treeshrink_output_summary.txt ../results_treeshrink/
cd ..
rm -r temp_treeshrink_ASTRAL_Pro/
cd ..
parallel -j 45 'mafft --quiet results_ASTRAL_PRO/results_treeshrink/{}_treeshrink_output.fasta > results_ASTRAL_PRO/results_mafft_final/{}.paralogs.mafft.fasta' :::: 6d.ASTRAL_PRO_genelist_succesfull.txt
parallel -j 45 'trimal -in results_ASTRAL_PRO/results_mafft_final/{}.paralogs.mafft.fasta -out results_ASTRAL_PRO/results_trimal_final/{}.paralogs.trimal.fasta -resoverlap 0.75 -seqoverlap 0.90 -gt 0.90' :::: 6d.ASTRAL_PRO_genelist_succesfull.txt
parallel -j 45 '~/iqtree-2.1.3-Linux/bin/iqtree2 -s results_ASTRAL_PRO/results_trimal_final/{}.paralogs.trimal.fasta -B 1000 -nm 1000 -m GTR+F+R -nt AUTO --prefix results_ASTRAL_PRO/results_iqtree_gene_trees_final/result_{}_iqtree' :::: 6d.ASTRAL_PRO_genelist_succesfull.txt
cat results_ASTRAL_PRO/results_iqtree_gene_trees_final/*.treefile > 6f.ASTRAL_PRO_input_gene_trees.tre
Rscript 6g.ASTRAL_PRO_paralogs_to_samples.R
java -D"java.library.path=/home/kasper.hendriks/A-pro/ASTRAL-MP/lib" -jar ~/A-pro/ASTRAL-MP/astral.1.1.6.jar -i 6f.ASTRAL_PRO_input_gene_trees.tre -a 6h.ASTRAL_PRO_paralogs_to_samples.txt -o 6i.ASTRAL_PRO_species_tree.tre -t 2 2>6i.ASTRAL_PRO_species_tree.log
