#!/bin/bash
#FLUX: --job-name=frigid-bicycle-0445
#FLUX: -n=5
#FLUX: --queue=wrighton-hi
#FLUX: -t=784800
#FLUX: --urgency=16

source /opt/Miniconda2/miniconda2/bin/activate DRAM
DRAM-v.py distill \
          --custom_distillate /home/projects/Sporulation_AMG/_sporulation_distillate_module.tsv \
          -i /home/projects/Sporulation_AMG/hmp/vMAG/annotations_DRAMv.tsv \
          -o /home/projects/Sporulation_AMG/hmp/vMAG/distillate_spor_5 \
          --max_auxiliary_score 5
gene_id	gene_description	module	sheet	header	subheader	potential_amg
K02313	dnaA;chromosomal replication initiator protein DnaA		MISC	Genetics	DNA replication	True
K02338	dnaN;DNA polymerase III subunit beta		MISC	Genetics	DNA replication	True
K06215	pdxS;pyridoxal biosynthesis lyase PdxS	Biosynthesis of pyridoxal phosphate	MISC	Additional metabolic pathways	Biosynthesis of cofactors	True
K06306	yaaH;spore germination protein YaaH	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06317	bofA;sigma-K factor-processing regulator BofA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06284	abrB;transition state regulatory protein AbrB		MISC	Regulation of gene expression	Transition state regulators	True
K02528	ksgA;ribosomal RNA small subunit methyltransferase A	rRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K06436	yabG;sporulation-specific protease YabG	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06423	sspF;small acid-soluble spore protein SspF	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K00919	ispE;4-diphosphocytidyl-2-c-methyl-d-erythritol kinase	Biosynthesis of isoprenoids	MISC	Lipid metabolism	Biosynthesis of lipids	True
K09685	purR;Pur operon repressor	Biosynthesis/ acquisition of purine nucleotides	MISC	Nucleotide metabolism	Biosynthesis/ acquisition of nucleotides	True
K09022	yabJ;enamine/imine deaminase	Biosynthesis/ acquisition of branched-chain amino acids	MISC	Amino acid/ nitrogen metabolism	Biosynthesis/ acquisition of amino acids	True
K06412	spoVG;septation protein SpoVG		MISC	Sporulation	Sporulation/ other	True
K01056	spoVC;peptidyl-tRNA hydrolase		MISC	Coping with stress	General stress proteins (controlled by SigB)	True
K03723	mfd;transcription-repair-coupling factor		MISC	Genetics	DNA repair/ recombination	True
K04769	spoVT;stage V sporulation protein T	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K13052	divIC;cell division protein DivIC	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07571	yabR;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06382	spoIIE;stage II sporulation protein E	Control of sigma factors	MISC	Regulation of gene expression	Sigma factors and their control	True
K07114	yabS;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K08884	yabT;serine/threonine protein kinase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K19411	mcsA;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K19405	mcsB;ATP:guanido phosphotransferase YacI	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03696	clpC;negative regulator of genetic competence ClpC/MecB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07067	disA;DNA integrity scanning protein DisA		MISC	Sporulation	Sporulation/ other	True
K03091	sigH;RNA polymerase sigma-H factor	Sigma factors	MISC	RNA synthesis and degradation	Transcription	True
K01448	cwlD;germination-specific N-acetylmuramoyl-L-alanine amidase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06294	gerD;spore germination protein GerD	Additional germination proteins	MISC	Sporulation	Germination	True
K06349	kbaA;kinB-signaling pathway activation protein	Proteins controlling the activity of the kinases	MISC	Sporulation	phosphorelay	True
K01207	nagZ;lipoprotein	Utilization of cell wall components	MISC	Cell envelope and cell division	Cell wall degradation/ turnover	True
K21469	amiE;hypothetical protein	Utilization of cell wall components	MISC	Cell envelope and cell division	Cell wall degradation/ turnover	True
K02810	murP;PTS system transporter subunit EIIBC	Utilization of cell wall components	MISC	Cell envelope and cell division	Cell wall degradation/ turnover	True
K01247	alkA;DNA-3-methyladenine glycosylase		MISC	Genetics	DNA repair/ recombination	True
K01449	cwlJ;cell wall hydrolase CwlJ	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06368	rapJ;response regulator aspartate phosphatase J	Protein phosphatases	MISC	Protein synthesis, modification and degradation	Protein modification	True
K01182	ycdG;oligo-1,6-glucosidase 2		MISC	Coping with stress	General stress proteins (controlled by SigB)	True
K09190	ycgG;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03293	ycgH;transporter	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K09967	ycgI;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K07074	ycgL;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K03305	dtpT;transporter	Peptide transporter	MISC	Transporters	Transporters/ other	True
K06295	gerKA;spore germination protein KA	Germinant receptors	MISC	Sporulation	Germination	True
K06297	gerKC;spore germination protein KC	Germinant receptors	MISC	Sporulation	Germination	True
K06296	gerKB;spore germination protein KB	Germinant receptors	MISC	Sporulation	Germination	True
K06361	rapC;response regulator aspartate phosphatase C		MISC	Genetics	Genetic competence	True
K06353	phrC;phosphatase RapC inhibitor		MISC	Genetics	Genetic competence	True
K05340	glcU;glucose uptake protein GlcU	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00034	gdh;glucose 1-dehydrogenase	Additional germination proteins	MISC	Sporulation	Germination	True
K06351	pxpB;kinase A inhibitor	Proteins controlling the activity of the kinases	MISC	Sporulation	phosphorelay	True
K06350	pxpC;kipi antagonist	Proteins controlling the activity of the kinases	MISC	Sporulation	phosphorelay	True
K01929	murF;UDP-N-acetylmuramoyl-tripeptide--D-alanyl-D- alanine ligase	Biosynthesis of peptidoglycan	MISC	Cell envelope and cell division	Cell wall synthesis	True
K06367	rapI;response regulator aspartate phosphatase I	Protein phosphatases	MISC	Protein synthesis, modification and degradation	Protein modification	True
K03719	lrpA;AsnC family transcriptional regulator		MISC	Sporulation	phosphorelay	True
K01077	phoB;alkaline phosphatase 3	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06324	cotA;spore coat protein A	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06366	rapH;response regulator aspartate phosphatase H	Phosphatases controlling the phosphorelay	MISC	Sporulation	phosphorelay	True
K20389	phrH;inhibitor of regulatory cascade		MISC	Sporulation	phosphorelay	True
K06332	cotJA;spore coat associated protein CotJA	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06333	cotJB;spore coat protein CotJB	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06334	cotJC;spore coat peptide assembly protein CotJC	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K18197	yesW;rhamnogalacturonan endolyase YesW	Utilization of pectin	MISC	Carbon metabolism	Utilization of specific carbon sources	True
K22933	lplD;alpha-galacturonidase	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K14338	yetO;bifunctional P-450/NADPH-P450 reductase 1	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K00978	yfnH;glucose-1-phosphate cytidylyltransferase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K11639	citM;Mg(2+)/citrate complex secondary transporter	Transporter for organic acids	MISC	Transporters	Transporters/ other	True
K06309	yfkT;spore germination protein YfkT		MISC	Sporulation	Germination/ based on similarity	True
K06308	yfkR;spore germination protein YfkR		MISC	Sporulation	Germination/ based on similarity	True
K06307	yfkQ;hypothetical protein		MISC	Sporulation	Germination/ based on similarity	True
K07300	chaA;cation exchanger YfkE	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01567	pdaA;polysaccharide deacetylase PdaA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00627	acoC;dihydrolipoyllysine-residue acetyltransferase component of acetoin cleaving system	Utilization of acetoin	MISC	Carbon metabolism	Utilization of specific carbon sources	True
K06425	sspH;small acid-soluble spore protein H	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K06428	sspK;small acid-soluble spore protein K	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K07038	yfhP;hypothetical protein		MISC	Membrane proteins		True
K10780	fabL;enoyl-[acyl-carrier-protein] reductase [NADPH] FabL	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06422	sspE;small acid-soluble spore protein gamma-type	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K06377	spo0M;sporulation-control protein spo0M		MISC	Sporulation	Sporulation/ other	True
K03781	katA;vegetative catalase		MISC	Coping with stress	Resistance against oxidative and electrophile stress	True
K18979	queG;epoxyqueuosine reductase	tRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K03216	cspR;tRNA (cytidine(34)-2'-O)-methyltransferase	tRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K07180	prkA;serine protein kinase PrkA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K09786	yhbH;stress response UPF0229 protein YhbH	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06180	yhcT;RNA pseudouridine synthase YhcT	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K00864	glpK;glycerol kinase	Utilization of glycerol/ glycerol-3-phosphate	MISC	Carbon metabolism	Utilization of specific carbon sources	True
K01835	pgcA;phosphoglucomutase	Biosynthesis of peptidoglycan	MISC	Cell envelope and cell division	Cell wall synthesis	True
K02480	yhcY;sensor histidine kinase	Protein kinases	MISC	Protein synthesis, modification and degradation	Protein modification	True
K02479	yhcZ;transcriptional regulator	Two-component system response regulators	MISC	Regulation of gene expression	Transcription factors and their control	True
K06415	spoVR;stage V sporulation protein R	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06419	sspB;small acid-soluble spore protein B	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K02495	hemZ;oxygen-independent coproporphyrinogen-III oxidase	Biosynthesis of heme/ siroheme	MISC	Additional metabolic pathways	Biosynthesis of cofactors	True
K07228	khtT;K(+)/H(+) antiporter subunit KhtT	Metal ion transporter	MISC	Transporters	Transporters/ other	True
K03698	yhaM;3'-5' exoribonuclease YhaM	Exoribonucleases	MISC	RNA synthesis and degradation	RNases	True
K09682	scoC;MarR family transcriptional regulator	Transcription factors/ other	MISC	Regulation of gene expression	Transcription factors and their control	True
K12555	pbpF;penicillin-binding protein 1F	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K18653	ntdA;NTD biosynthesis operon protein NtdA	Biosynthesis of antibacterial compounds	MISC	Additional metabolic pathways	Miscellaneous metabolic pathways	True
K06304	gerPF;spore germination protein	Additional germination proteins	MISC	Sporulation	Germination	True
K06303	gerPE;spore germination protein GerPE	Additional germination proteins	MISC	Sporulation	Germination	True
K06302	gerPD;spore germination protein GerPD	Additional germination proteins	MISC	Sporulation	Germination	True
K06301	gerPC;spore germination protein GerPC	Additional germination proteins	MISC	Sporulation	Germination	True
K06300	gerPB;spore germination protein	Additional germination proteins	MISC	Sporulation	Germination	True
K06299	gerPA;spore germination protein GerPA	Additional germination proteins	MISC	Sporulation	Germination	True
K01953	asnO;asparagine synthetase 3	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K02291	yisP;squalene/phytoene synthase		MISC	Sporulation	phosphorelay	True
K00860	yisZ;adenylyl-sulfate kinase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00958	yitA;sulfate adenylyltransferase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00390	yitB;phosphoadenosine phosphosulfate reductase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K05979	yitC;2-phosphosulfolactate phosphatase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K08097	yitD;phosphosulfolactate synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K08221	yitG;MFS transporter	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K15580	oppA;oligopeptide ABC transporter binding lipoprotein		MISC	Sporulation	phosphorelay	True
K15581	oppB;oligopeptide transport system permease protein OppB		MISC	Sporulation	phosphorelay	True
K15582	oppC;oligopeptide transport system permease protein OppC		MISC	Sporulation	phosphorelay	True
K15583	oppD;oligopeptide transport ATP-binding protein OppD		MISC	Sporulation	phosphorelay	True
K10823	oppF;oligopeptide transport ATP-binding protein OppF		MISC	Sporulation	phosphorelay	True
K08602	pepF;oligoendopeptidase F		MISC	Sporulation	phosphorelay	True
K06344	cotZ;spore coat protein Z	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06343	cotY;spore coat protein Y	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06342	cotX;spore coat protein X	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06341	cotW;spore coat protein W	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06340	cotV;spore coat protein V	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06339	cotT;spore coat protein	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K01686	uxuA;mannonate dehydratase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K08191	exuT;hexuronate transporter	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00041	uxaB;altronate oxidoreductase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01685	uxaA;altronate dehydratase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07090	yjnA;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06359	rapA;response regulator aspartate phosphatase A	Phosphatases controlling the phosphorelay	MISC	Sporulation	phosphorelay	True
K06352	phrA;phosphatase RapA inhibitor	Other protein controlling the activity of the phosphorelay	MISC	Sporulation	phosphorelay	True
K07217	yjqC;hypothetical protein	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06389	spoIISB;stage II sporulation protein SB		MISC	Sporulation	Sporulation/ other	True
K06388	spoIISA;stage II sporulation protein SA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K05916	hmp;flavohemoprotein		MISC	Electron transport and ATP synthesis	Electron transport/ other	True
K24620	thiU;HMP/thiamine-binding protein YkoF	Class I ECF transporter	MISC	Transporters	ECF transporter	True
K20534	ykoT;glycosyltransferase YkoT	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K01971	ligD;ATP-dependent DNA ligase YkoU	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K10979	ykoV;DNA repair protein YkoV	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06421	sspD;small acid-soluble spore protein D	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K03799	htpX;protease HtpX	Additional proteins involved in proteolysis	MISC	Protein synthesis, modification and degradation	Proteolysis	True
K13533	kinE;sporulation kinase E	The kinases	MISC	Sporulation	phosphorelay	True
K06376	spo0E;aspartyl-phosphate phosphatase Spo0E	Phosphatases controlling the phosphorelay	MISC	Sporulation	phosphorelay	True
K13532	kinD;sporulation kinase D	The kinases	MISC	Sporulation	phosphorelay	True
K06315	splA;transcriptional regulator SplA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03716	splB;spore photoproduct lyase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K02491	kinA;sporulation kinase A	The kinases	MISC	Sporulation	phosphorelay	True
K00841	patA;N-acetyl-LL-diaminopimelate aminotransferase	Biosynthesis of peptidoglycan	MISC	Cell envelope and cell division	Cell wall synthesis	True
K06437	yknT;sporulation protein cse15	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K18889	yknU;ABC transporter ATP-binding protein	Exporters	MISC	Transporters	ABC transporters	True
K18890	yknV;ABC transporter ATP-binding protein	Exporters	MISC	Transporters	ABC transporters	True
K07698	kinC;sporulation kinase C	The kinases	MISC	Sporulation	phosphorelay	True
K01462	defB;peptide deformylase	Conversion of S-methyl cysteine to cysteine	MISC	Additional metabolic pathways	Sulfur metabolism	True
K07175	ylaK;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K01425	ylaM;glutaminase	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K02259	ctaA;heme A synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07001	ylbK;NTE family protein YlbK		MISC	Poorly characterized/ putative enzymes		True
K08384	spoVD;stage V sporulation protein D	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03588	spoVE;stage V sporulation protein E	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K02563	murG;UDP-N-acetylglucosamine--N-acetylmuramyl- (pentapeptide) pyrophosphoryl-undecaprenol N-acetylglucosamine transferase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00075	murB;UDP-N-acetylenolpyruvoylglucosamine reductase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03589	divIB;cell division protein DivIB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03590	ftsA;cell division protein FtsA	Other genes	MISC	Cell envelope and cell division	Cell division	True
K03531	ftsZ;cell division protein FtsZ	Other genes	MISC	Cell envelope and cell division	Cell division	True
K06383	spoIIGA;sporulation sigma-E factor-processing peptidase		MISC	Sporulation	Sporulation/ other	True
K04074	divIVA;septum site-determining protein DivIVA	The Min system	MISC	Cell envelope and cell division	Cell division	True
K01537	yloB;calcium-transporting ATPase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K09777	remA;hypothetical protein	Transcription factors/ other	MISC	Regulation of gene expression	Transcription factors and their control	True
K12132	prkC;serine/threonine protein kinase	Additional germination proteins	MISC	Sporulation	Germination	True
K00949	yloS;thiamine pyrophosphokinase	Biosynthesis/ acquisition of thiamine	MISC	Additional metabolic pathways	Biosynthesis of cofactors	True
K06414	spoVM;stage V sporulation protein M	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K00059	fabG;3-oxoacyl-[acyl-carrier-protein] reductase FabG	Biosynthesis of fatty acids	MISC	Lipid metabolism	Biosynthesis of lipids	True
K03529	smc;chromosome partition protein Smc		MISC	Genetics	DNA condensation/ segregation	True
K03110	ftsY;signal recognition particle receptor FtsY	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03706	codY;GTP-sensing transcriptional pleiotropic repressor CodY	Transcription factors/ other	MISC	Regulation of gene expression	Transcription factors and their control	True
K11749	rasP;zinc metalloprotease RasP	Other genes	MISC	Cell envelope and cell division	Cell division	True
K06410	spoVFA;dipicolinate synthase subunit A	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06411	spoVFB;dipicolinate synthase subunit B	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00133	asd;aspartate-semialdehyde dehydrogenase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00928	dapG;aspartokinase 1	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01714	dapA;4-hydroxy-tetrahydrodipicolinate synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03466	spoIIIE;spore DNA translocase		MISC	Sporulation	Sporulation/ other	True
K09769	ymdB;hypothetical protein		MISC	Exponential and early post-exponential lifestyles	Biofilm formation	True
K06416	spoVS;stage V sporulation protein S		MISC	Sporulation	Sporulation/ other	True
K06328	cotE;spore coat protein E	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K00791	miaA;tRNA dimethylallyltransferase	tRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K06413	spoVK;stage V sporulation protein K	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01775	yncD;alanine racemase 2	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06326	cotC;spore coat protein C	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06310	yndD;hypothetical protein		MISC	Sporulation	Germination/ based on similarity	True
K06311	yndE;spore germination protein YndE		MISC	Sporulation	Germination/ based on similarity	True
K06312	yndF;spore germination protein YndF		MISC	Sporulation	Germination/ based on similarity	True
K01356	lexA;lexa repressor		MISC	Genetics	DNA repair/ recombination	True
K06335	cotM;spore coat protein M	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06433	sspP;small acid-soluble spore protein P	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K06432	sspO;small acid-soluble spore protein O	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K06431	sspN;small acid-soluble spore protein N	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K06434	tlp;small acid-soluble spore protein Tlp	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07097	nrnB;oligoribonuclease NrnB	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K01640	yngG;hydroxymethylglutaryl-CoA lyase YngG	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01961	yngH;biotin carboxylase 2	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00666	yngI;acyl-CoA synthetase YngI	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K23598	iseA;hypothetical protein	Autolysis	MISC	Cell envelope and cell division	Cell wall degradation/ turnover	True
K00931	proJ;glutamate 5-kinase	Biosynthesis/ acquisition of proline	MISC	Amino acid/ nitrogen metabolism	Biosynthesis/ acquisition of amino acids	True
K00286	proH;pyrroline-5-carboxylate reductase 1	Biosynthesis/ acquisition of proline	MISC	Amino acid/ nitrogen metabolism	Biosynthesis/ acquisition of amino acids	True
K00483	yoaI;4-hydroxyphenylacetate 3-monooxygenase	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K01569	oxdD;oxalate decarboxylase OxdD	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06369	rapK;response regulator aspartate phosphatase K		MISC	Genetics	Genetic competence	True
K18115	sqhC;sporulenol synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K04564	sodF;superoxide dismutase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K18672	cdaS;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03299	yojA;permease YojA		MISC	Membrane proteins		True
K03797	ctpA;carboxy-terminal processing protease CtpA	Additional proteins involved in proteolysis	MISC	Protein synthesis, modification and degradation	Proteolysis	True
K01843	kamA;L-lysine 2,3-aminomutase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K21935	yodP;N-acetyltransferase YodP	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01438	yodQ;metallohydrolase YodQ	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06323	cgeE;N-acetyltransferase CgeE	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06322	cgeD;spore maturation protein CgeD	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06321	cgeC;spore maturation protein CgeC	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06319	cgeA;spore maturation protein CgeA	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06320	cgeB;spore maturation protein CgeB	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06420	sspC;small acid-soluble spore protein C	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K03469	ypeP;hypothetical protein	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06429	sspL;small acid-soluble spore protein L	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K23786	exoR;5'-3' exonuclease		MISC	Genetics	DNA replication	True
K16168	bpsB;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K16167	bpsA;chalcone synthase	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06327	cotD;spore coat protein D	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06430	sspM;small acid-soluble spore protein M	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K03524	birA;bifunctional protein BirA	Biosynthesis of fatty acids	MISC	Lipid metabolism	Biosynthesis of lipids	True
K00974	cca;CCA-adding enzyme	tRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K00754	bshA;glycosyltransferase YpjH	Biosynthesis of bacillithiol	MISC	Additional metabolic pathways	Miscellaneous metabolic pathways	True
K01463	bshB1;deacetylase YpjG	Biosynthesis of bacillithiol	MISC	Additional metabolic pathways	Miscellaneous metabolic pathways	True
K01734	mgsA;methylglyoxal synthase	Glycolysis	MISC	Carbon metabolism	Carbon core metabolism	True
K00215	dapB;4-hydroxy-tetrahydrodipicolinate reductase	Biosynthesis of peptidoglycan	MISC	Cell envelope and cell division	Cell wall synthesis	True
K00940	ndk;nucleoside diphosphate kinase		MISC	Nucleotide metabolism	Nucleotide metabolism/ other	True
K03183	menH;demethylmenaquinone methyltransferase	Biosynthesis of menaquinone	MISC	Additional metabolic pathways	Biosynthesis of cofactors	True
K06398	spoIVA;stage IV sporulation protein A	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K05739	seaA;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06313	ypeB;sporulation protein YpeB	Additional germination proteins	MISC	Sporulation	Germination	True
K16511	ypbH;adapter protein MecA 2	Additional proteins involved in proteolysis	MISC	Protein synthesis, modification and degradation	Proteolysis	True
K06374	spmB;spore maturation protein B	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06373	spmA;spore maturation protein A	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07258	dacB;D-alanyl-D-alanine carboxypeptidase DacB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00794	ribH;6,7-dimethyl-8-ribityllumazine synthase	Biosynthesis/ acquisition of riboflavin/ FAD	MISC	Additional metabolic pathways	Biosynthesis of cofactors	True
K03100	sipS;signal peptidase I S		MISC	Protein synthesis, modification and degradation	Protein secretion	True
K01586	lysA;diaminopimelate decarboxylase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06408	spoVAF;stage V sporulation protein AF	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06407	spoVAEA;stage V sporulation protein AE	Additional germination proteins	MISC	Sporulation	Germination	True
K06406	spoVAD;stage V sporulation protein AD	Additional germination proteins	MISC	Sporulation	Germination	True
K06405	spoVAC;stage V sporulation protein AC	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06404	spoVAB;stage V sporulation protein AB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06403	spoVAA;stage V sporulation protein AA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06379	spoIIAB;anti-sigma F factor	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06378	spoIIAA;anti-sigma F factor antagonist	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K04763	ripX;tyrosine recombinase XerD		MISC	Genetics	DNA condensation/ segregation	True
K06384	spoIIM;stage II sporulation protein M	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K05606	yqjC;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03417	mmgF;methylisocitrate lyase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01720	mmgE;2-methylcitrate dehydratase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01647	mmgD;2-methylcitrate synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K18244	mmgC;acyl-CoA dehydrogenase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00074	mmgB;3-hydroxybutyryl-CoA dehydrogenase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00626	mmgA;acetyl-CoA acetyltransferase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07699	spo0A;stage 0 sporulation protein A		MISC	Sporulation	phosphorelay	True
K06399	spoIVB;peptidase S55	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06397	spoIIIAH;stage III sporulation protein AH	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06396	spoIIIAG;stage III sporulation protein AG	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06395	spoIIIAF;stage III sporulation protein AF	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06394	spoIIIAE;stage III sporulation protein AE	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06393	spoIIIAD;stage III sporulation protein AD	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06392	spoIIIAC;stage III sporulation protein AC	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06391	spoIIIAB;stage III sporulation protein AB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06390	spoIIIAA;stage III sporulation protein AA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01262	papA;peptidase YqhT	Utilization of peptides	MISC	Amino acid/ nitrogen metabolism	Utilization of nitrogen sources other than amino acids	True
K00283	gcvPB;glycine dehydrogenase subunit 2	Utilization of threonine/ glycine	MISC	Amino acid/ nitrogen metabolism	Utilization of amino acids	True
K00282	gcvPA;glycine dehydrogenase subunit 1	Utilization of threonine/ glycine	MISC	Amino acid/ nitrogen metabolism	Utilization of amino acids	True
K00605	gcvT;aminomethyltransferase	Utilization of threonine/ glycine	MISC	Amino acid/ nitrogen metabolism	Utilization of amino acids	True
K06372	sinI;SinR antagonist SinI	Control of transcription factor (other than two-component system)	MISC	Regulation of gene expression	Transcription factors and their control	True
K19449	sinR;XRE family transcriptional regulator	Transcription factors/ other	MISC	Regulation of gene expression	Transcription factors and their control	True
K06336	tasA;spore coat protein N		MISC	Exponential and early post-exponential lifestyles	Biofilm formation	True
K19433	tapA;hypothetical protein		MISC	Exponential and early post-exponential lifestyles	Biofilm formation	True
K01308	yqgT;hypothetical protein	Endopeptidases	MISC	Cell envelope and cell division	Cell wall degradation/ turnover	True
K08222	yqgE;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K03526	ispG;4-hydroxy-3-methylbut-2-en-1-yl diphosphate synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01151	nfo;endonuclease IV		MISC	Genetics	DNA repair/ recombination	True
K03086	sigA;RNA polymerase sigma factor RpoD	Sigma factors	MISC	RNA synthesis and degradation	Transcription	True
K06438	yqfD;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03324	yqeW;hypothetical protein	Uptake of other small ions	MISC	Transporters	Transporters/ other	True
K06385	spoIIP;stage II sporulation protein P	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06012	gpr;germination protease	Additional germination proteins	MISC	Sporulation	Germination	True
K02239	comER;ComE operon protein 4	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06371	sda;sporulation inhibitor sda	Proteins controlling the activity of the kinases	MISC	Sporulation	phosphorelay	True
K01447	cwlH;N-acetylmuramoyl-L-alanine amidase CwlH	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00033	yqeC;6-phosphogluconate dehydrogenase YqeC	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06400	spoIVCA;DNA recombinase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03741	arsC;arsenate reductase ArsC		MISC	Coping with stress	Resistance against toxic metals	True
K03325	arsB;arsenite resistance protein ArsB	Metal ion transporter	MISC	Transporters	Transporters/ other	True
K03892	arsR;arsenical resistance operon repressor	Transcription factors/ other	MISC	Regulation of gene expression	Transcription factors and their control	True
K06363	rapE;response regulator aspartate phosphatase E	Phosphatases controlling the phosphorelay	MISC	Sporulation	phosphorelay	True
K06354	phrE;phosphatase RapE inhibitor	Other protein controlling the activity of the phosphorelay	MISC	Sporulation	phosphorelay	True
K06440	yraG;spore coat protein F	Spore coat protein/ based on similarity	MISC	Sporulation	Sporulation proteins	True
K00121	adhB;zinc-type alcohol dehydrogenase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06439	yraD;spore coat protein F	Spore coat protein/ based on similarity	MISC	Sporulation	Sporulation proteins	True
K17217	mccB;cystathionine gamma-lyase	Biosynthesis/ acquisition of cysteine	MISC	Amino acid/ nitrogen metabolism	Biosynthesis/ acquisition of amino acids	True
K17216	mccA;O-acetylserine dependent cystathionine beta-synthase	Biosynthesis/ acquisition of cysteine	MISC	Amino acid/ nitrogen metabolism	Biosynthesis/ acquisition of amino acids	True
K21468	pbpI;penicillin-binding protein 4B	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K10041	glnQ;glutamine transport ATP-binding protein GlnQ	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K10039	glnH;ABC transporter substrate-binding protein GlnH	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K10040	glnM;glutamine ABC transporter permease protein GlnM	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06409	spoVB;stage V sporulation protein B	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06318	bofC;general stress protein BofC	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03310	yrbD;sodium/proton-dependent alanine carrier protein YrbD	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06345	coxA;sporulation cortex protein CoxA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06370	safA;spoivd-associated factor A	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K03517	nadA;quinolinate synthase A	Biosynthesis of NAD(P)	MISC	Additional metabolic pathways	Biosynthesis of cofactors	True
K03979	obg;GTPase ObgE		MISC	Sporulation	phosphorelay	True
K06375	spo0B;sporulation initiation phosphotransferase B	The phosphotransferases	MISC	Sporulation	phosphorelay	True
K06402	spoIVFB;stage IV sporulation protein FB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06401	spoIVFA;stage IV sporulation protein FA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03609	minD;septum site-determining protein MinD	The Min system	MISC	Cell envelope and cell division	Cell division	True
K03610	minC;septum site-determining protein MinC	The Min system	MISC	Cell envelope and cell division	Cell division	True
K03569	mreB;rod shape-determining protein MreB		MISC	Cell envelope and cell division	Cell shape	True
K06380	spoIIB;stage II sporulation protein B		MISC	Sporulation	Sporulation/ other	True
K06417	spoVID;stage VI sporulation protein D	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K04076	lonB;Lon protease 2	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03829	ysnE;N-acetyltransferase YsnE		MISC	Poorly characterized/ putative enzymes		True
K07095	ysnB;metallophosphoesterase		MISC	Proteins of unknown function		True
K02428	ysnA;non-canonical purine NTP pyrophosphatase		MISC	Poorly characterized/ putative enzymes		True
K00989	rph;ribonuclease PH	Exoribonucleases	MISC	RNA synthesis and degradation	RNases	True
K06298	gerM;spore germination protein GerM	Additional germination proteins	MISC	Sporulation	Germination	True
K01776	racE;glutamate racemase	Biosynthesis of peptidoglycan	MISC	Cell envelope and cell division	Cell wall synthesis	True
K01994	gerE;spore germination protein GerE	Additional germination proteins	MISC	Sporulation	Germination	True
K06426	sspI;small acid-soluble spore protein I	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K02647	ysfB;hypothetical protein	Transcription factor/ other/ based on similarity	MISC	Regulation of gene expression	Transcription factors and their control	True
K03346	dnaB;replication initiation and membrane attachment protein		MISC	Genetics	DNA replication	True
K00134	gapB;glyceraldehyde-3-phosphate dehydrogenase 2	Gluconeogenesis	MISC	Carbon metabolism	Carbon core metabolism	True
K07636	phoR;alkaline phosphatase synthesis sensor protein PhoR	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07658	phoP;alkaline phosphatase synthesis transcriptional regulatory protein PhoP	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06881	nrnA;bifunctional oligoribonuclease/PAP phosphatase NrnA	Exoribonucleases	MISC	RNA synthesis and degradation	RNases	True
K06418	sspA;small acid-soluble spore protein A	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K05020	opuD;glycine betaine transporter OpuD	Uptake of compatible solutes	MISC	Transporters	Transporters/ other	True
K16188	ytpB;tetraprenyl-beta-curcumene synthase		MISC	Coping with stress	Cell envelope stress proteins (controlled by SigM, V, W, X, Y)	True
K01048	ytpA;phospholipase YtpA		MISC	Coping with stress	Cell envelope stress proteins (controlled by SigM, V, W, X, Y)	True
K02051	ytlA;ABC transporter substrate-binding protein YtlA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K02049	ytlC;ABC transporter ATP-binding protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K02050	ytlD;ABC transporter permease	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03574	rppH;8-oxo-dGTP diphosphatase YtkD	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00425	ythA;cytochrome bd menaquinol oxidase subunit I	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K00426	ythB;cytochrome bd menaquinol oxidase subunit II	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K00963	ytdA;UTP--glucose-1-phosphate uridylyltransferase	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K00012	ytcA;UDP-glucose 6-dehydrogenase YtcA	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06337	cotS;spore coat protein S	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06338	cotSA;spore coat protein SA	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06331	cotI;spore coat protein I	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K00688	glgP;glycogen phosphorylase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00703	glgA;glycogen synthase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00975	glgD;glycogen biosynthesis protein GlgD	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00700	glgB;1,4-alpha-glucan branching enzyme GlgB	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07192	floT;hypothetical protein		MISC	Sporulation	Sporulation/ other	True
K00456	yubC;cysteine dioxygenase	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K00686	tgl;protein-glutamine gamma-glutamyltransferase	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K01187	yugT;oligo-1,6-glucosidase 3	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K03699	yugS;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06973	yugP;membrane protease YugP	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K10716	yugO;potassium channel protein YugO	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K09779	yuzA;hypothetical protein	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K14155	patB;cystathionine beta-lyase	Biosynthesis/ acquisition of methionine/ S-adenosylmethionine	MISC	Amino acid/ nitrogen metabolism	Biosynthesis/ acquisition of amino acids	True
K07697	kinB;sporulation kinase B	The kinases	MISC	Sporulation	phosphorelay	True
K06347	kapB;kinase-associated lipoprotein B	Proteins controlling the activity of the kinases	MISC	Sporulation	phosphorelay	True
K06348	kapD;3'-5' exonuclease KapD		MISC	Sporulation	phosphorelay	True
K00259	ald;alanine dehydrogenase	Utilization of alanine/ serine	MISC	Amino acid/ nitrogen metabolism	Utilization of amino acids	True
K01255	yuiE;cytosol aminopeptidase		MISC	Poorly characterized/ putative enzymes		True
K03885	yumB;NADH dehydrogenase-like protein YumB	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K07734	paiB;protease synthase and sporulation protein PAI 2	Transcription factors/ other	MISC	Regulation of gene expression	Transcription factors and their control	True
K22441	paiA;protease synthase and sporulation negative regulatory protein PAI 1	Metabolism of polyamines	MISC	Additional metabolic pathways	Miscellaneous metabolic pathways	True
K21472	lytH;L-Ala--D-Glu endopeptidase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01466	pucH;allantoinase		MISC	Nucleotide metabolism	Utilization of nucleotides	True
K16838	pucL;urate oxidase with peroxide reductase N-terminal domain		MISC	Nucleotide metabolism	Utilization of nucleotides	True
K06424	sspG;small acid-soluble spore protein G	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K00318	fadM;proline dehydrogenase 1	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06288	gerAA;spore germination protein A1	Germinant receptors	MISC	Sporulation	Germination	True
K06289	gerAB;spore germination protein A2	Germinant receptors	MISC	Sporulation	Germination	True
K06290	gerAC;spore germination protein A3	Germinant receptors	MISC	Sporulation	Germination	True
K06427	sspJ;small acid-soluble spore protein J	Small acid-soluble spore proteins	MISC	Sporulation	Sporulation proteins	True
K01118	azoR2;FMN-dependent NADH-azoreductase 2	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03664	smpB;SsrA-binding protein	Translation/ other	MISC	Protein synthesis, modification and degradation	Translation	True
K22299	rghR;HTH-type transcriptional repressor RghR		MISC	Sporulation	phosphorelay	True
K15633	pgm;2,3-bisphosphoglycerate-independent phosphoglycerate mutase	Glycolysis	MISC	Carbon metabolism	Carbon core metabolism	True
K01803	tpi;triosephosphate isomerase	Glycolysis	MISC	Carbon metabolism	Carbon core metabolism	True
K00927	pgk;phosphoglycerate kinase	Substrate-level phosphorylation	MISC	Electron transport and ATP synthesis	ATP synthesis	True
K02103	araR;transcriptional repressor	Utilization of arabinan/ arabinose/ arabitol	MISC	Carbon metabolism	Utilization of specific carbon sources	True
K15771	mdxF;maltodextrin transport system permease protein MdxF	Importers	MISC	Transporters	ABC transporters	True
K13292	lgt;prolipoprotein diacylglyceryl transferase	Additional germination proteins	MISC	Sporulation	Germination	True
K09811	ftsX;cell division protein FtsX		MISC	Sporulation	phosphorelay	True
K09812	ftsE;cell division ATP-binding protein FtsE		MISC	Sporulation	phosphorelay	True
K16699	tuaH;teichuronic acid biosynthesis glycosyltransferase TuaH	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K16698	tuaG;teichuronic acid biosynthesis glycosyltransferase TuaG	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K16706	tuaF;teichuronic acid biosynthesis protein TuaF	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K23989	lytD;beta-N-acetylglucosaminidase	Autolysis	MISC	Cell envelope and cell division	Cell wall degradation/ turnover	True
K06291	gerBA;spore germination protein B1	Germinant receptors	MISC	Sporulation	Germination	True
K06292	gerBB;spore germination protein B2	Germinant receptors	MISC	Sporulation	Germination	True
K06293	gerBC;spore germination protein B3	Germinant receptors	MISC	Sporulation	Germination	True
K03893	ywrK;arsenical pump membrane protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06325	cotB;spore coat protein B	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06330	cotH;inner spore coat protein H	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K07240	ywrA;transporter		MISC	Sporulation	Sporulation/ other	True
K05982	ywqL;endonuclease V	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06362	rapD;response regulator aspartate phosphatase D		MISC	Genetics	Genetic competence	True
K06283	spoIIID;stage III sporulation protein D	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06435	usd;protein usd	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06386	spoIIQ;stage II sporulation protein Q	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06131	clsA;cardiolipin synthase	Biosynthesis of phospholipids	MISC	Lipid metabolism	Biosynthesis of lipids	True
K06360	rapB;response regulator aspartate phosphatase B	Phosphatases controlling the phosphorelay	MISC	Sporulation	phosphorelay	True
K06381	spoIID;stage II sporulation protein D	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07566	tsaC;tRNA threonylcarbamoyladenosine biosynthesis protein YwlC		MISC	Genetics	Newly identified competence genes	True
K06387	spoIIR;stage II sporulation protein R	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K11686	racA;chromosome-anchoring protein RacA	Other genes	MISC	Cell envelope and cell division	Cell division	True
K02490	spo0F;sporulation initiation phosphotransferase F	The phosphotransferases	MISC	Sporulation	phosphorelay	True
K13281	ywjD;UV DNA damage endonuclease	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06364	rapF;response regulator aspartate phosphatase F		MISC	Genetics	Genetic competence	True
K00797	speE;spermidine synthase	Metabolism of polyamines	MISC	Additional metabolic pathways	Miscellaneous metabolic pathways	True
K21464	pbpG;penicillin-binding protein 2D	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06314	rsfA;prespore-specific transcriptional regulator RsfA	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01790	spsL;spore coat polysaccharide biosynthesis protein SpsL	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00067	spsK;spore coat polysaccharide biosynthesis protein SpsK	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01710	spsJ;dTDP-glucose 4,6-dehydratase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K00973	spsI;dTDP-glucose pyrophosphorylase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K07257	spsF;spore coat polysaccharide biosynthesis protein SpsF	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K06305	gerQ;spore coat protein GerQ	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K00128	ywdH;aldehyde dehydrogenase YwdH		MISC	Poorly characterized/ putative enzymes		True
K14393	ywcA;symporter	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K02761	ywbA;permease IIC component YwbA	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K16012	cydD;ATP-binding/permease protein CydD	Regulatory ABC transporters	MISC	Transporters	ABC transporters	True
K00019	yxjF;oxidoreductase	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01029	scoB;succinyl-CoA:3-ketoacid coenzyme A transferase subunit B	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K01028	scoA;succinyl-CoA:3-ketoacid coenzyme A transferase subunit A	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03300	citH;citrate transporter	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K06902	yxiO;MFS transporter		MISC	Membrane proteins		True
K05592	deaD;ATP-dependent RNA helicase DbpA		MISC	RNA synthesis and degradation	DEAD-box RNA helicases	True
K00756	pdp;pyrimidine-nucleoside phosphorylase		MISC	Nucleotide metabolism	Utilization of nucleotides	True
K06608	iolR;HTH-type transcriptional regulator IolR	Utilization of inositol	MISC	Carbon metabolism	Utilization of specific carbon sources	True
K06365	rapG;response regulator aspartate phosphatase G	Protein phosphatases	MISC	Protein synthesis, modification and degradation	Protein modification	True
K06329	cotF;spore coat protein F	Spore coat proteins	MISC	Sporulation	Sporulation proteins	True
K06888	yyaL;hypothetical protein	Newly identified sporulation proteins (based on transcription profiling)	MISC	Sporulation	Sporulation proteins	True
K01142	exoA;exodeoxyribonuclease	Sporulation proteins/ other	MISC	Sporulation	Sporulation proteins	True
K03497	parB;stage 0 sporulation protein J		MISC	Sporulation	Sporulation/ other	True
K03496	parA;sporulation initiation inhibitor protein Soj		MISC	Sporulation	Sporulation/ other	True
K03495	gidA;tRNA uridine 5-carboxymethylaminomethyl modification enzyme MnmG	tRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K03650	thdF;tRNA modification GTPase MnmE	tRNA modification and maturation	MISC	Protein synthesis, modification and degradation	Translation	True
K06346	jag;protein jag		MISC	Sporulation	Sporulation/ other	True
K03217	yidC1;membrane protein insertase MisCA		MISC	Sporulation	Sporulation/ other	True
K02343	 DNA polymerase III subunits gamma and tau	sporulation	MISC	sporulation	sporulation	True
K09747	DNA binding protein	sporulation	MISC	sporulation	sporulation	True
K00991	 2-C-methyl-D-erythritol 4-phosphate cytidylyltransferase	sporulation	MISC	sporulation	sporulation	True
K01770	 2-C-methyl-D-erythritol 2,4-cyclodiphosphate synthase	sporulation	MISC	sporulation	sporulation	True
K03431	 Phosphoglucosamine mutase	sporulation	MISC	sporulation	sporulation	True
K00820	 Glucosamine--fructose-6-phosphate aminotransferase [isomerizing]	sporulation	MISC	sporulation	sporulation	True
K02412	 ATP synthase subunit beta FliI	sporulation	MISC	sporulation	sporulation	True
K00876	putative uridine kinase	sporulation	MISC	sporulation	sporulation	True
K00131	 Glyceraldehyde-3-phosphate dehydrogenase (NADP(+)) (GADPH)	sporulation	MISC	sporulation	sporulation	True
K01420	Transcriptional regulator, Crp family	sporulation	MISC	sporulation	sporulation	True
K03798	putative ATP-dependent peptidase, M41 family	sporulation	MISC	sporulation	sporulation	True
K03657	putative DNA helicase, UvrD/REP type	sporulation	MISC	sporulation	sporulation	True
K07301	putative Ca2+/Na+ antiporter	sporulation	MISC	sporulation	sporulation	True
K02335	 DNA polymerase I (POLI)	sporulation	MISC	sporulation	sporulation	True
K00859	 Dephospho-CoA kinase (Dephosphocoenzyme A kinase)	sporulation	MISC	sporulation	sporulation	True
K08309	putative lytic transglycosylase-like protein	sporulation	MISC	sporulation	sporulation	True
K05515	putative peptidoglycan glycosyltransferase	sporulation	MISC	sporulation	sporulation	True
K03311	 Branched chain amino acid transport system carrier protein	sporulation	MISC	sporulation	sporulation	True
K07447	putative Holliday junction resolvase	sporulation	MISC	sporulation	sporulation	True
K03537	putative small acid-soluble spore protein SASP	sporulation	MISC	sporulation	sporulation	True
K00965	putative galactose-1-phosphate uridylyltransferase	sporulation	MISC	sporulation	sporulation	True
K16203	putative amino acid amidase	sporulation	MISC	sporulation	sporulation	True
K01297	putative muramoyltetrapeptide carboxypeptidase,S66 family	sporulation	MISC	sporulation	sporulation	True
K01126	 Glycerophosphoryl diester phosphodiesterase	sporulation	MISC	sporulation	sporulation	True
K01921	 D-alanine--D-alanine ligase (D-alanylalanine synthetase) (D-Ala-D-Ala ligase)	sporulation	MISC	sporulation	sporulation	True
K09936	putative membrane protein	sporulation	MISC	sporulation	sporulation	True
K04759	 Ferrous iron transport protein B	sporulation	MISC	sporulation	sporulation	True
K04758	 Ferrous iron transport protein	sporulation	MISC	sporulation	sporulation	True
K00640	 Serine acetyltransferase (SAT)	sporulation	MISC	sporulation	sporulation	True
K01304	 Pyrrolidone-carboxylate peptidase	sporulation	MISC	sporulation	sporulation	True
K21583	Glycine/sarcosine/betaine reductase complex,protein B, alpha and beta subunits	sporulation	MISC	sporulation	sporulation	True
K03312	 Sodium/glutamate symporter	sporulation	MISC	sporulation	sporulation	True
K09861	conserved hypothetical protein, UPF0246 family	sporulation	MISC	sporulation	sporulation	True
K01736	 Chorismate synthase (5-enolpyruvylshikimate-3-phosphate phospholyase)	sporulation	MISC	sporulation	sporulation	True
K14170	 Bifunctional P-protein, chorismate mutase/prephenate dehydratase	sporulation	MISC	sporulation	sporulation	True
K03790	putative Acyl-CoA N-acyltransferase	sporulation	MISC	sporulation	sporulation	True
K13275	 Intracellular serine protease	sporulation	MISC	sporulation	sporulation	True
K11105	putative Na(+)/H(+) antiporter	sporulation	MISC	sporulation	sporulation	True
K06901	Xanthine/uracil/thiamine/ascorbate permease family protein	sporulation	MISC	sporulation	sporulation	True
K00806	 Undecaprenyl pyrophosphate synthetase	sporulation	MISC	sporulation	sporulation	True
K01893	 Asparaginyl-tRNA synthetase (Asparagine--tRNA ligase) (AsnRS)	sporulation	MISC	sporulation	sporulation	True
K02770	 PTS system, fructose-specific IIABC component	sporulation	MISC	sporulation	sporulation	True
K00882	 Fructose 1-phosphate kinase	sporulation	MISC	sporulation	sporulation	True
K00177	putative flavodoxin/ferredoxin oxidoreductase gamma subunit	sporulation	MISC	sporulation	sporulation	True
K00366	putative nitrite/sulphite reductase	sporulation	MISC	sporulation	sporulation	True
K03595	 GTP-binding protein Era	sporulation	MISC	sporulation	sporulation	True
K01489	 Cytidine deaminase (Cytidine aminohydrolase) (CDA)	sporulation	MISC	sporulation	sporulation	True
K00901	putative diacylglycerol kinase	sporulation	MISC	sporulation	sporulation	True
K07042	putative metal-dependent hydrolase	sporulation	MISC	sporulation	sporulation	True
K06217	PhoH-like protein	sporulation	MISC	sporulation	sporulation	True
K05770	putative transmembrane signaling protein,TspO/MBR family	sporulation	MISC	sporulation	sporulation	True
K25026	putative glucokinase, ROK family	sporulation	MISC	sporulation	sporulation	True
K03294	putative amino acid/polyamine transporter	sporulation	MISC	sporulation	sporulation	True
K11751	putative membrane-associated 5'-nucleotidase/phosphoesterase	sporulation	MISC	sporulation	sporulation	True
K22278	putative oligosaccharide deacetylase	sporulation	MISC	sporulation	sporulation	True
K05810	conserved hypothetical protein	sporulation	MISC	sporulation	sporulation	True
K07738	 Transcriptional regulator, repressor NrdR family	sporulation	MISC	sporulation	sporulation	True
K01928	 UDP-N-acetylmuramyl-tripeptide synthetase	sporulation	MISC	sporulation	sporulation	True
K20118	 PTS system, glucose-specific IIBC component	sporulation	MISC	sporulation	sporulation	True
K03980	 Transmembrane virulence factor, MviN family protein	sporulation	MISC	sporulation	sporulation	True
K03594	putative bacterioferritin	sporulation	MISC	sporulation	sporulation	True
K01464	D-hydantoinase (Dihydropyrimidinase)	sporulation	MISC	sporulation	sporulation	True
K24206	putative purine permease	sporulation	MISC	sporulation	sporulation	True
K06015	putative D-aminoacylase	sporulation	MISC	sporulation	sporulation	True
K01751	 Diaminopropionate ammonia-lyase	sporulation	MISC	sporulation	sporulation	True
K07507	putative magnesium transport ATPase, MgtC/SapB family	sporulation	MISC	sporulation	sporulation	True
K06949	 putative EngC-like GTPase	sporulation	MISC	sporulation	sporulation	True
K09762	 putative sporulation transcription regulator whiA	sporulation	MISC	sporulation	sporulation	True
K01934	5-formyltetrahydrofolate cyclo-ligase	sporulation	MISC	sporulation	sporulation	True
K07171	 Endoribonuclease toxin	sporulation	MISC	sporulation	sporulation	True
K07723	putative antitoxin EndoAI	sporulation	MISC	sporulation	sporulation	True
K00997	 Holo-[acyl-carrier-protein] synthase	sporulation	MISC	sporulation	sporulation	True
K02112	 ATP synthase subunit beta (ATPase subunit beta) (ATP synthase F1 sector subunit beta)	sporulation	MISC	sporulation	sporulation	True
K07238	putative zinc/iron permease	sporulation	MISC	sporulation	sporulation	True
K01258	putative peptidase T, M20B family	sporulation	MISC	sporulation	sporulation	True
K01585	putative arginine decarboxylase	sporulation	MISC	sporulation	sporulation	True
K19689	Aminopeptidase	sporulation	MISC	sporulation	sporulation	True
K01759	putative glyoxalase	sporulation	MISC	sporulation	sporulation	True
