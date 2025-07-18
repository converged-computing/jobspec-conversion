#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=17940
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_baseline_debug.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 77.0 M
-----------------------------------------------------
77.0 M    Trainable params
0         Non-trainable params
77.0 M    Total params
307.845   Total estimated model params size (MB)
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 49
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:00<00:00,  2.54it/s]St. Mary's College ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.2222222222222222
National Assembly of Pakistan ['Siumut']
em = False, f1 = 0
Ssei ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
House of Representatives of Japan ['Democratic Party']
em = False, f1 = 0
Notre Dame ['INSEP']
em = False, f1 = 0
Copenhagen City Council ['Vibeke Storm Rasmussen']
em = False, f1 = 0
MEP ['Speaker of the Knesset']
em = False, f1 = 0
JS Kabylie ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0
Yvonne ['Philipp Mißfelder']
em = False, f1 = 0
NBC ['University of Sussex']
em = False, f1 = 0
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/91 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/91 [00:00<?, ?it/s] 
Epoch 0:   1%|          | 1/91 [00:00<00:41,  2.16it/s]
Epoch 0:   1%|          | 1/91 [00:00<00:41,  2.16it/s, loss=nan]
Epoch 0:   2%|▏         | 2/91 [00:00<00:22,  3.87it/s, loss=nan][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:   3%|▎         | 3/91 [00:00<00:18,  4.77it/s, loss=nan]
Epoch 0:   3%|▎         | 3/91 [00:00<00:18,  4.77it/s, loss=7.39]
Epoch 0:   4%|▍         | 4/91 [00:00<00:14,  5.92it/s, loss=7.39]
Epoch 0:   5%|▌         | 5/91 [00:00<00:12,  6.94it/s, loss=7.39]
Epoch 0:   7%|▋         | 6/91 [00:00<00:11,  7.37it/s, loss=7.39]
Epoch 0:   7%|▋         | 6/91 [00:00<00:11,  7.36it/s, loss=6.98]
Epoch 0:   8%|▊         | 7/91 [00:00<00:10,  8.12it/s, loss=6.98]
Epoch 0:   9%|▉         | 8/91 [00:00<00:09,  8.82it/s, loss=6.98]
Epoch 0:  10%|▉         | 9/91 [00:01<00:09,  8.48it/s, loss=6.98]
Epoch 0:  10%|▉         | 9/91 [00:01<00:09,  8.48it/s, loss=7.12]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.55it/s][A
Epoch 0:  13%|█▎        | 12/91 [00:01<00:09,  8.22it/s, loss=7.12]
Validating:  76%|███████▌  | 62/82 [00:00<00:00, 164.31it/s][A
Epoch 0:  80%|████████  | 73/91 [00:01<00:00, 46.77it/s, loss=7.12]St. John's College ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.2222222222222222
Knesset ['Siumut']
em = False, f1 = 0
Ssei ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
House of Representatives of Japan ['Democratic Party']
em = False, f1 = 0
École Polytechnique ['INSEP']
em = False, f1 = 0
Copenhagen City Council ['Vibeke Storm Rasmussen']
em = False, f1 = 0
MEP ['Speaker of the Knesset']
em = False, f1 = 0
JS Kabylie ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0
Yvonne ['Philipp Mißfelder']
em = False, f1 = 0
NBC ['University of Sussex']
em = False, f1 = 0
Rothschild ['Alexander Ivanov']
em = False, f1 = 0
Marta Lewicka ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
Büyükşehir Bey ['Kadir Topbaş']
em = False, f1 = 0
Sergei ['Yuriy Maleyev']
em = False, f1 = 0
FC Barcelona ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0
Hans-Joachim ['Andreas Baum']
em = False, f1 = 0
Registrar of Social Security ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
Parliament of Finland ['Centre Party']
em = False, f1 = 0
MEP ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0
National Academy of Sciences ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0
NBC Universal ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar ['London and Continental Railways']
em = False, f1 = 0
Sr. ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
Leicester Tigers ['Atlanta Beat']
em = False, f1 = 0
St. John's ['Cambridge High School']
em = False, f1 = 0
scar lvarez ['Stefanos Manos']
em = False, f1 = 0
Saint-Sauveur-sur-Mer ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
NBC News ['Roll Call']
em = False, f1 = 0
BBC Worldwide ['University of Sheffield']
em = False, f1 = 0
Max Planck Society ['Peter Gruss']
em = False, f1 = 0
England ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0
eljko ['Albin Kurti']
em = False, f1 = 0
England ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0.33333333333333337
National Assembly of Pakistan ['Indian National Congress']
em = False, f1 = 0.28571428571428575
Ynglings ['Case Western Reserve University']
em = False, f1 = 0
NBC News ['University of York']
em = False, f1 = 0
St. John's University ['Stanford University', 'University of California, Los Angeles']
em = False, f1 = 0.4
NBC News ['University of Michigan']
em = False, f1 = 0
NBC ['University of Warwick']
em = False, f1 = 0
Darren ['Mark McGregor']
em = False, f1 = 0
Ford Motor Company ['Merrill Lynch']
em = False, f1 = 0
Miss Philippines Earth ['President of the Philippines']
em = False, f1 = 0.3333333333333333
Michael ['Daniel Carp']
em = False, f1 = 0
Universidad de Chile ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0.8571428571428571
ONGC ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
IFK Göteborg ['Ineos Grenadier']
em = False, f1 = 0
Qi Lu ['Microsoft Corporation']
em = False, f1 = 0
Ched Evans ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0
Sergei ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo ['Beacon Capital Partners']
em = False, f1 = 0
Justice of the Peace ['Vice President of Ghana']
em = False, f1 = 0.28571428571428575
David A. McKinley ['Craig Fugate']
em = False, f1 = 0
MEP ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0
CPC ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0
Sveriges Riksbank ['general secretary']
em = False, f1 = 0
England ['Manchester United F.C.']
em = False, f1 = 0
UNESCO ['United States Copyright Office']
em = False, f1 = 0
Galliano ['Christian Dior S.A.']
em = False, f1 = 0
Universidad de Chile ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
North Carolina State University ['Regis Jesuit High School']
em = False, f1 = 0
Sony Pictures ['Birkbeck, University of London']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
Olimpia Roma ['Yamaha Motor Racing']
em = False, f1 = 0
FK Radniki Ni ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0
FC Utrecht ['AFC Bournemouth']
em = False, f1 = 0
Max Hollein ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania General Assembly ['Ed Rendell']
em = False, f1 = 0
John ['Justin King']
em = False, f1 = 0
Jeremy ['Jean-Marie Le Pen']
em = False, f1 = 0
Luca Giordano ['Ottmar Hitzfeld']
em = False, f1 = 0
Malaysian Academy of Sciences ['United Malays National Organisation']
em = False, f1 = 0
Real Madrid ['Scuderia Ferrari']
em = False, f1 = 0
YB Raj Khatiwada ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape ['AOL']
em = False, f1 = 0
Ajax ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
ZANU-PF ['President of Zimbabwe']
em = False, f1 = 0
MEP ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0
Sony Pictures ['Durham University']
em = False, f1 = 0
EMI ['University of Cambridge']
em = False, f1 = 0
Al-Ahly ['Blackburn Rovers F.C.']
em = False, f1 = 0
Team GB ['San Diego Padres']
em = False, f1 = 0
SV Werder Bremen ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
RC Lens ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0
National Assembly of France ['Socialist Party']
em = False, f1 = 0
David ['Johannes Vogel']
em = False, f1 = 0
MEP ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
Justice of the Peace ['state treasurer']
em = False, f1 = 0
Tadeusz Kocielny ['Donald Tusk']
em = False, f1 = 0
Hapoel Tel Aviv ['Chelsea F.C.']
em = False, f1 = 0
Silvio Berlusconi ['Alessandro Cosimi']
em = False, f1 = 0
National Assembly of Romania ['National Liberal Party']
em = False, f1 = 0.28571428571428575
National Assembly of France ['Horizon Monaco']
em = False, f1 = 0
IFSC ['Olegario Vázquez Raña']
em = False, f1 = 0
Justice of the Peace ['Prime Minister of Turkey']
em = False, f1 = 0.28571428571428575
Italian Academy of Sciences ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Kimbrough County ['West Texas A&M University']
em = False, f1 = 0
National Assembly of Serbia ['NOW – Pilz List']
em = False, f1 = 0
Belinda ['Yahoo']
em = False, f1 = 0
Granada Television ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
New York Cosmos ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
Chartered Accountant ['chief technology officer']
em = False, f1 = 0
Xiamen University ['Regent University']
em = False, f1 = 0.5
Fratelli ['RCS MediaGroup']
em = False, f1 = 0
Team USA ['FC Twente']
em = False, f1 = 0
Vtková ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
Associated Press ['IT University of Copenhagen']
em = False, f1 = 0
eljko ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
José Luis Rodrguez ['Quique Sánchez Flores']
em = False, f1 = 0
Sveriges Riksbank ['State Secretary']
em = False, f1 = 0
Turin City Council ['Sergio Chiamparino']
em = False, f1 = 0
New Zealand ['FC Gold Pride']
em = False, f1 = 0
FC Twente ['Netherlands national association football team', 'FC Twente']
em = True, f1 = 1.0
NBC ['US Airways']
em = False, f1 = 0
NBC News ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
sterreichische Galerie ['Stanford University School of Medicine']
em = False, f1 = 0
Y Combinator ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
eljko ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
Srensen ['Dag-Eilev Fagermo']
em = False, f1 = 0
Team Ghana ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0.6666666666666666
Italian Academy of Sciences ['The People of Freedom']
em = False, f1 = 0.28571428571428575
UNESCO ['Agnes Gund']
em = False, f1 = 0
Italian Academy of Sciences ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Xenophon ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Univision ['Televisión Española']
em = False, f1 = 0
QC ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
Connacht ['Munster Rugby']
em = False, f1 = 0
lvaro Pérez ['Tibisay Lucena']
em = False, f1 = 0
Norwegian Academy of Science and Letters ["People's Party"]
em = False, f1 = 0
HC Spartak Moscow ['Stevenage F.C.']
em = False, f1 = 0
Y Combinator ['Christopher Poole']
em = False, f1 = 0
Sr. ['Chief Whip']
em = False, f1 = 0
England ['Dagenham & Redbridge F.C.']
em = False, f1 = 0
EMI Finland ['University of Jyväskylä']
em = False, f1 = 0
Svendsen ['Michel Wolter']
em = False, f1 = 0
NBC ['MSNBC']
em = False, f1 = 0
SourceForge Inc ['Vera Augustin Research']
em = False, f1 = 0
People's Artist ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0
The Rabbit Foundation ['S. I. Newhouse']
em = False, f1 = 0
NBCUniversal ['Rudolf Staechelin']
em = False, f1 = 0
NBC News ['Burnet Institute']
em = False, f1 = 0
tefan ['Emil Săndoi']
em = False, f1 = 0
EMI ['Iniva']
em = False, f1 = 0
Sergei Mikhailovich Ivanov ['Valentina Matviyenko']
em = False, f1 = 0
Team GB ['Derby County F.C.']
em = False, f1 = 0
Kyto ['Keiji Yamada']
em = False, f1 = 0
FC Seoul ['Chicago Bulls']
em = False, f1 = 0
Team Canada ['England and Wales cricket team']
em = False, f1 = 0.28571428571428575
Universidad de Chile ['Middlesbrough F.C.']
em = False, f1 = 0
Sr. ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0
CSKA Moscow ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
RC Lens ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
NBC ["Brigham and Women's Hospital"]
em = False, f1 = 0
CPI ['President of Mauritius']
em = False, f1 = 0
NBC ['Harvard Medical School']
em = False, f1 = 0
National Assembly of Spain ['Democratic Union of Catalonia']
em = False, f1 = 0.25
Batangas City Council ['Vilma Santos']
em = False, f1 = 0
Petrobras ['First Quantum Minerals']
em = False, f1 = 0
International Federation of Associations of Swiss Architects ['Institutional Republican Party']
em = False, f1 = 0
National Assembly of France ['Democratic Convergence of Catalonia']
em = False, f1 = 0.25
Wisconsin State Assembly ['Conservative Party']
em = False, f1 = 0
EMI ['Colorado State University']
em = False, f1 = 0
Northamptonshire ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0
Yuriy ['Karel Schwarzenberg']
em = False, f1 = 0
NBC ['East Carolina Pirates football']
em = False, f1 = 0
M.I.A. ['United States representative']
em = False, f1 = 0
Democrat ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0
Göttingen ['Wolfgang Lück']
em = False, f1 = 0
Team USA ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
lvaro ['Danny De Bie']
em = False, f1 = 0
Maccabi Tel Aviv ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
Sergei ['Volodymyr Lytvyn']
em = False, f1 = 0
François-Joseph Lefebvre ['Lucette Michaux-Chevry']
em = False, f1 = 0
National Assembly of Romania ['independent politician']
em = False, f1 = 0
University of the West Indies ['The Park School of Buffalo']
em = False, f1 = 0.25
Democrat ['United States representative']
em = False, f1 = 0
David ['Joe Bossano']
em = False, f1 = 0
MEP ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
Russian Academy of Sciences ['A Just Russia']
em = False, f1 = 0
Paulista de So Paulo ['Gilberto Kassab']
em = False, f1 = 0
Paulista de So Paulo ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Party of Korea ['Liberty Korea Party']
em = False, f1 = 0.5714285714285715
National Assembly of Thailand ['New Democratic Party']
em = False, f1 = 0
Northamptonshire ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0
Hart Blanton ['University of Connecticut']
em = False, f1 = 0
Rand Museum ['Alice Walton']
em = False, f1 = 0
House of Representatives of the Philippines ['Left, Ecology and Freedom']
em = False, f1 = 0
Combined Universities ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
Esteghlal ['Club Brugge K.V.']
em = False, f1 = 0
Kongregate Group ['GameStop']
em = False, f1 = 0
FC Barcelona ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
The New York Times ['University of Strathclyde']
em = False, f1 = 0
NBC News ['Washington University in St.\xa0Louis']
em = False, f1 = 0
Kre Schultz ['Novo Nordisk']
em = False, f1 = 0
Eurosport Group ['TF1 Group']
em = False, f1 = 0.5
Democrat ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0
Italian Academy of Sciences ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Qatari ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0
efovi ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
Sr. ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0
NBC News ['United States Department of Justice']
em = False, f1 = 0
Wisconsin State Assembly ['New Democratic Party']
em = False, f1 = 0
National Assembly of Romania ['Social Democratic Party']
em = False, f1 = 0
Australian Senate ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0.22222222222222224
Joo José dos Santos ['Yeda Crusius']
em = False, f1 = 0
England ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0
Clemente Clemente ['Harvard University']
em = False, f1 = 0
National Assembly of France ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.22222222222222224
Liaoning City Council ['Chen Zhenggao']
em = False, f1 = 0
LA Weekly ['Village Voice Media']
em = False, f1 = 0
Xie ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
European Parliament ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Australia ['England and Wales cricket team']
em = False, f1 = 0
Sporting Clube de Portugal ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0
National Security Advisor ['Minister of Defence']
em = False, f1 = 0
Sony Pictures ['RAI']
em = False, f1 = 0
MEP ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
Registrar of Societies ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Al-Ahly ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
National Assembly of Romania ['Democratic Liberal Party']
em = False, f1 = 0
NBC News ['Oregon Ducks']
em = False, f1 = 0
Y Combinator ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
Vytautas ivkovs ['Reinoldijus Šarkinas']
em = False, f1 = 0
European Parliament ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Sr. ['dean of Liverpool']
em = False, f1 = 0
Changhua County Executive ['Cho Po-yuan']
em = False, f1 = 0
Sinclair Broadcast Group ['Denison University']
em = False, f1 = 0
David A. Smith ['Hélène Langevin-Joliot']
em = False, f1 = 0
Team GB ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0.25
NBC News ['Queens Museum']
em = False, f1 = 0
NBCUniversal ['University of Chile']
em = False, f1 = 0
Mike ['Les Miles']
em = False, f1 = 0
NBC ['Hamilton College', 'Vassar College']
em = False, f1 = 0
NBC News ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
NBC ['University of Münster']
em = False, f1 = 0
Waseda University ['Sendai University Meisei High School']
em = False, f1 = 0.28571428571428575
Nordic Council of Ministers ['Norwegian Labour Party']
em = False, f1 = 0
MEP ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
Yves Leclerc ['Institute for Advanced Study']
em = False, f1 = 0
European Parliament ['Democratic Convergence of Catalonia']
em = False, f1 = 0
University of Oyo ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
National Assembly of Pakistan ['Pakistan Muslim League (Q)']
em = False, f1 = 0.25
Marcin ukasiewicz ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
Sr. ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
St. Patrick's ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
Miss Philippines Earth ['United States representative']
em = False, f1 = 0
Viva Records ['ETH Zurich']
em = False, f1 = 0
XI Punjab ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0
Sr. ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0
Democrat ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0
St. Patrick's ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0
algiris Kalev ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
Jean-Baptiste Lefèvre ['Jean-Louis Garcia']
em = False, f1 = 0
Registrar of Companies ['White House Chief of Staff']
em = False, f1 = 0.25
Registrar of Societies ['chairperson']
em = False, f1 = 0
National Assembly of Lithuania ['SYRIZA']
em = False, f1 = 0
Cardiff Blues ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0
NBC ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
Sr. ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0
Registrar of the Republic ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0.25
MEP ['permanent representative of Spain to the European Union']
em = False, f1 = 0
FC Barcelona B ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Lithuanian National Assembly ["People's Party"]
em = False, f1 = 0
Team USA ['Santa Clara Broncos']
em = False, f1 = 0
Granada ['University College London']
em = False, f1 = 0
comte de l'Ordre des Arts et des Lettres ['Secretary for Relations with States']
em = False, f1 = 0
NBC News ['Lunar and Planetary Institute']
em = False, f1 = 0
ONGC ['Pakistan national cricket team']
em = False, f1 = 0
Indian National Congress ['Indian National Congress']
em = True, f1 = 1.0
NBC ['University of Southampton']
em = False, f1 = 0
Bergen Metro ['Norwegian National Rail Administration']
em = False, f1 = 0
ICICI Bank ['University of Arizona']
em = False, f1 = 0
Editura Ionescu ['University of Windsor']
em = False, f1 = 0
Secretary of the Treasury ['Rick Perry']
em = False, f1 = 0
Sr. ['president']
em = False, f1 = 0
Justice of the Peace ['member of the European Parliament']
em = False, f1 = 0.28571428571428575
EMI ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Hawaii State Executive Council ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Sony Pictures Television ['Massachusetts General Hospital']
em = False, f1 = 0
The New York Times ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0
Heinz-Heinz ['Reiner Hollich']
em = False, f1 = 0
Minnesota House of Representatives ['Republican Party']
em = False, f1 = 0
RC Lens ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
lvaro de la Cruz ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
Armenian Artists ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0.3333333333333333
New England Patriots ['New England Patriots']
em = True, f1 = 1.0
Chamber of Deputies ['Alternative Democratic Pole']
em = False, f1 = 0
Italian Senate ['The People of Freedom']
em = False, f1 = 0
Team GB ['Ineos Grenadier']
em = False, f1 = 0
St. John's University ['South Garland High School']
em = False, f1 = 0
Democrat ['White House Cabinet Secretary']
em = False, f1 = 0
Olimpia ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
National Academy of Sciences ['Kadima']
em = False, f1 = 0
CBE ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
National Assembly of France ['Socialist Party']
em = False, f1 = 0
Romanian Academy ['Social Democratic Party']
em = False, f1 = 0
MEP ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
NBC ['University of Bath']
em = False, f1 = 0
Sporting Clube de Portugal ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0
National Security Advisor ['Mayor of Tehran']
em = False, f1 = 0
House of Representatives of Japan ['Liberal Democratic Party']
em = False, f1 = 0
Microsoft ['Osnabrück University']
em = False, f1 = 0
Président de la République ['director', 'president']
em = False, f1 = 0
National Assembly of Pakistan ['Bahujan Samaj Party']
em = False, f1 = 0
Serie B ['Leeds United F.C.']
em = False, f1 = 0
European Parliament ['Democratic Party', 'Union of the Centre']
em = False, f1 = 0
FC Honolulu ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
Seoul National University ['Hanyang University']
em = False, f1 = 0.4
Italian Academy of Sciences ['Democratic Convergence of Catalonia']
em = False, f1 = 0.25
Hermann Müller ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Hermann Göring ['Jürgen Klopp']
em = False, f1 = 0
Republican Party ['independent politician']
em = False, f1 = 0
National Assembly of France ['Union for a Popular Movement']
em = False, f1 = 0
The Bullards ['Hull City A.F.C.']
em = False, f1 = 0
Esteghlal ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Energia ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
Team USA ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0.25
Yvonne ['Anni Sinnemäki']
em = False, f1 = 0
Yenisei ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
St. Mary's College ['Erasmus University Rotterdam']
em = False, f1 = 0
Syed Ali Khan ['Mufti Mohammad Sayeed']
em = False, f1 = 0
The New York Times ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers, Inc ['Berkshire Hathaway']
em = False, f1 = 0
National Assembly of Italy ['Democratic Party']
em = False, f1 = 0
The New York Times ['The Rockefeller University']
em = False, f1 = 0
St. John's College ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0
Scotland ['Sunderland A.F.C.']
em = False, f1 = 0
National Assembly of Pakistan ['Malaysian Islamic Party']
em = False, f1 = 0
Helmut Schmidt ['Florian Pronold']
em = False, f1 = 0
O'Brien ['Martin Russell']
em = False, f1 = 0
National Assembly of Romania ['Democratic Liberal Party']
em = False, f1 = 0
jpest ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0
Westfield Wheaton Corporation ['Westfield Group']
em = False, f1 = 0.4
NBC News ['Freie Universität Berlin']
em = False, f1 = 0
Milan City Council ['Letizia Moratti']
em = False, f1 = 0
FC Barcelona ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
New Zealand ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0
Miss America ['president']
em = False, f1 = 0
Federal Building Development Corporation ['General Services Administration']
em = False, f1 = 0
Romanian National Hero ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
Sony Pictures ['Kyushu University']
em = False, f1 = 0
UNESCO ['Monash University']
em = False, f1 = 0
NBC ['California State University, Monterey Bay']
em = False, f1 = 0
lvaro ['Ernesto Valverde']
em = False, f1 = 0
Azerbaijan State University ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0
David ['Jan du Plessis']
em = False, f1 = 0
Philippe de Bourges ['Serge Lepeltier']
em = False, f1 = 0
Volkswagen Group ['Borussia Dortmund']
em = False, f1 = 0
Jean-Pierre Lefèvre ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
National Assembly of China ['Democrats']
em = False, f1 = 0
Universidad de Chile ['Astana']
em = False, f1 = 0
Sr. ['secretary of state']
em = False, f1 = 0
Harvard University ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV LLC ['Teracom']
em = False, f1 = 0
Charlotte Hornets LLC ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
FC Barcelona ['Arsenal F.C.']
em = False, f1 = 0.5
Chennai Super Kings ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = True, f1 = 1.0
Universidad de Chile ['Brazil Olympic football team']
em = False, f1 = 0
Giuseppe Garibaldi ['Luigi Albore Mascia']
em = False, f1 = 0
Michael J. O'Connor ['John Maeda']
em = False, f1 = 0
National Assembly of France ["Conservative People's Party"]
em = False, f1 = 0
NBCUniversal ['Rutgers Scarlet Knights football']
em = False, f1 = 0
Taoiseach ['Teachta Dála', 'Minister for Social Protection']
em = False, f1 = 0
CSKA Moscow ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
NBC Universal ['University of Pennsylvania']
em = False, f1 = 0
FC Olimpia ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
Cork City ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Mike McCoy ['John Fox']
em = False, f1 = 0
Pakistan Muslim League ['Muttahida Qaumi Movement']
em = False, f1 = 0
st nad Labem ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
CPI ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0
KS ód ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0
St. John's College ['Rowville Secondary College']
em = False, f1 = 0.3333333333333333
NBC Sports ['University of Exeter']
em = False, f1 = 0
NBC Universal ['Google']
em = False, f1 = 0
Universidad de Chile ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0
Rhys Jones ['Dafydd Elis-Thomas']
em = False, f1 = 0
Team USA ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0.28571428571428575
St. Mary's ['Washington Freedom']
em = False, f1 = 0
Boise City Council ['David H. Bieter']
em = False, f1 = 0
Wishnutama ['Trans TV']
em = False, f1 = 0
NBC News ['bp']
em = False, f1 = 0
Giuseppe ['Giuseppe Merisi']
em = False, f1 = 0.6666666666666666
European Parliament ['Democratic Convergence of Catalonia']
em = False, f1 = 0
National Assembly of Serbia ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.22222222222222224
Ferrari ['Fiat S.p.A.']
em = False, f1 = 0
FC Barcelona B ['Real Madrid CF']
em = False, f1 = 0
Musée d'Art Moderne ['Eutelsat']
em = False, f1 = 0
Ferrari ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
FC Barcelona ['Golden State Warriors']
em = False, f1 = 0
Sacred Heart Academy ['St. Xavier High School']
em = False, f1 = 0
NBC Sports ['Apple Inc.']
em = False, f1 = 0
Regierungspräsident ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
Sveriges Riksbank ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0
FC Utrecht ['Arsenal F.C.']
em = False, f1 = 0.5
Sr. ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0
Sr-Trm ['Minister of Children and Family Affairs']
em = False, f1 = 0
Sr. ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0
National Assembly of France ['Authenticity and Modernity Party']
em = False, f1 = 0
Pau ['Martine Lignières-Cassou']
em = False, f1 = 0
Delhi Dynamos ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
EMI ['University of Bristol']
em = False, f1 = 0
PEN ['John R. Saul']
em = False, f1 = 0
Team GB ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0.3333333333333333
Justice of Appeal ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0.2222222222222222
Sahrawi Arab Democratic Republic ['Abdelkader Taleb Omar']
em = False, f1 = 0
Australian Senate ['Liberal National Party of Queensland']
em = False, f1 = 0
NBC News ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
Auckland Council ['Len Brown']
em = False, f1 = 0
Pandolfi ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 0: 100%|██████████| 91/91 [00:09<00:00,  9.45it/s, loss=7.12]
                                                            [A
Epoch 0:   0%|          | 0/91 [00:00<?, ?it/s, loss=7.12]         
Epoch 1:   0%|          | 0/91 [00:00<?, ?it/s, loss=7.12]
Epoch 1:   1%|          | 1/91 [00:00<00:40,  2.21it/s, loss=7.12]
Epoch 1:   2%|▏         | 2/91 [00:00<00:22,  3.97it/s, loss=7.12]
Epoch 1:   3%|▎         | 3/91 [00:00<00:17,  4.97it/s, loss=7.04]
Epoch 1:   4%|▍         | 4/91 [00:00<00:14,  6.16it/s, loss=7.04]
Epoch 1:   5%|▌         | 5/91 [00:00<00:11,  7.19it/s, loss=7.04]
Epoch 1:   7%|▋         | 6/91 [00:00<00:11,  7.60it/s, loss=6.93]
Epoch 1:   8%|▊         | 7/91 [00:00<00:10,  8.35it/s, loss=6.93]
Epoch 1:   9%|▉         | 8/91 [00:00<00:09,  9.03it/s, loss=6.93]
Epoch 1:  10%|▉         | 9/91 [00:01<00:09,  8.66it/s, loss=6.79]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.59it/s][A
Epoch 1:  67%|██████▋   | 61/91 [00:01<00:00, 40.35it/s, loss=6.79]
Validating:  77%|███████▋  | 63/82 [00:00<00:00, 169.05it/s][AUniversity of the West Indies ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.4
Democratic Party ['Siumut']
em = False, f1 = 0
Yokohama Shimbun ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
École Normale Supérieure ['INSEP']
em = False, f1 = 0
Christian Frederiksen ['Vibeke Storm Rasmussen']
em = False, f1 = 0
MEP ['Speaker of the Knesset']
em = False, f1 = 0
JS Kabylie ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0
Yashwantrao ['Philipp Mißfelder']
em = False, f1 = 0
NBC News ['University of Sussex']
em = False, f1 = 0
Rothschild Group ['Alexander Ivanov']
em = False, f1 = 0
Yves Saint Laurent ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
Recep Tayyip Erdogan ['Kadir Topbaş']
em = False, f1 = 0
Sergei Ivanovich Kostyakov ['Yuriy Maleyev']
em = False, f1 = 0
FC Barcelona B ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0
Andreas Kühn ['Andreas Baum']
em = False, f1 = 0.5
Democrat of Finland ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
Green Party of Finland ['Centre Party']
em = False, f1 = 0.3333333333333333
MEP ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0
Democratic Party ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0.5
NBC Universal ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar International Limited ['London and Continental Railways']
em = False, f1 = 0
Democrat ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
Accrington Stanley ['Atlanta Beat']
em = False, f1 = 0
University of Michigan ['Cambridge High School']
em = False, f1 = 0
Yves de la Gardie ['Stefanos Manos']
em = False, f1 = 0
Yves Saint Laurent ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
The New York Times ['Roll Call']
em = False, f1 = 0
Granada Television ['University of Sheffield']
em = False, f1 = 0
Wolfgang von Goethe ['Peter Gruss']
em = False, f1 = 0
Accrington Stanley ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0
eljko orevi ['Albin Kurti']
em = False, f1 = 0
SV Werder Bremen ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0
National Assembly of Pakistan ['Indian National Congress']
em = False, f1 = 0.28571428571428575
Yves Saint Laurent ['Case Western Reserve University']
em = False, f1 = 0
NBC News ['University of York']
em = False, f1 = 0
University of Southern California ['Stanford University', 'University of California, Los Angeles']
em = False, f1 = 0.6666666666666665
NBC News ['University of Michigan']
em = False, f1 = 0
NBC News ['University of Warwick']
em = False, f1 = 0
Darren ['Mark McGregor']
em = False, f1 = 0
Ford ['Merrill Lynch']
em = False, f1 = 0
Miss Philippines Philippines ['President of the Philippines']
em = False, f1 = 0.3333333333333333
John C. McKinley ['Daniel Carp']
em = False, f1 = 0
FC Barcelona B ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
ONGC FC ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
IFK Göteborg ['Ineos Grenadier']
em = False, f1 = 0
Xiao Xia ['Microsoft Corporation']
em = False, f1 = 0
Ched Evans ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0
Irina Yushchenko ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo Center, Inc ['Beacon Capital Partners']
em = False, f1 = 0
Justice of the Peace ['Vice President of Ghana']
em = False, f1 = 0.28571428571428575
Yuriy Yaroslavsky ['Craig Fugate']
em = False, f1 = 0
Chancellor of the Exchequer ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0.2222222222222222
Democrat ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0
MEP ['general secretary']
em = False, f1 = 0
Darren Fletcher ['Manchester United F.C.']
em = False, f1 = 0
UNESCO ['United States Copyright Office']
em = False, f1 = 0
Galliano & Galliano ['Christian Dior S.A.']
em = False, f1 = 0
FC Barcelona B ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
University of Miami ['Regis Jesuit High School']
em = False, f1 = 0
NBC Universal ['Birkbeck, University of London']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
Olimpia Milano ['Yamaha Motor Racing']
em = False, f1 = 0
FK eljezniar Sarajevo ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0
FC Utrecht ['AFC Bournemouth']
em = False, f1 = 0
Yves Saint Laurent-de-Ville ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania General Assembly ['Ed Rendell']
em = False, f1 = 0
John McKay ['Justin King']
em = False, f1 = 0
Yashwantrao ['Jean-Marie Le Pen']
em = False, f1 = 0
Maurizio Giacometti ['Ottmar Hitzfeld']
em = False, f1 = 0
Malaysian National Assembly ['United Malays National Organisation']
em = False, f1 = 0.28571428571428575
FC Barcelona ['Scuderia Ferrari']
em = False, f1 = 0
UNESCO ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape ['AOL']
em = False, f1 = 0
Ajax ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
ZANU PF ['President of Zimbabwe']
em = False, f1 = 0
MEP ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0
NBC News ['Durham University']
em = False, f1 = 0
Y Combinator ['University of Cambridge']
em = False, f1 = 0
Al-Ahly ['Blackburn Rovers F.C.']
em = False, f1 = 0
SK eljezniar ['San Diego Padres']
em = False, f1 = 0
SV Werder Bremen ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
RC Strasbourg ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0
National Assembly of France ['Socialist Party']
em = False, f1 = 0
Yvonne Yves ['Johannes Vogel']
em = False, f1 = 0
Democrat ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
Justice of the Peace ['state treasurer']
em = False, f1 = 0
Tadeusz Kociuszko ['Donald Tusk']
em = False, f1 = 0
Hapoel Jerusalem ['Chelsea F.C.']
em = False, f1 = 0
Giuseppe Giacomo Giacometti ['Alessandro Cosimi']
em = False, f1 = 0
Romanian Academy of Sciences ['National Liberal Party']
em = False, f1 = 0
National Assembly of France ['Horizon Monaco']
em = False, f1 = 0
Yuriy Yakovlev ['Olegario Vázquez Raña']
em = False, f1 = 0
AKP Member of Parliament ['Prime Minister of Turkey']
em = False, f1 = 0.25
Italian Democratic Party ['The People of Freedom']
em = False, f1 = 0
Kimbrough University ['West Texas A&M University']
em = False, f1 = 0.3333333333333333
Democratic Party of Serbia ['NOW – Pilz List']
em = False, f1 = 0
NBC News ['Yahoo']
em = False, f1 = 0
The New York Times ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
FC Barcelona B ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
MEP ['chief technology officer']
em = False, f1 = 0
Xinjiang University ['Regent University']
em = False, f1 = 0.5
Fratelli Fabbri ['RCS MediaGroup']
em = False, f1 = 0
FC Dallas ['FC Twente']
em = False, f1 = 0.5
Vtzslav tpány ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
The New York Times ['IT University of Copenhagen']
em = False, f1 = 0
Jean-Pierre d'Alembert ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
lvaro Cárdenas ['Quique Sánchez Flores']
em = False, f1 = 0
Sveriges Riksrat ['State Secretary']
em = False, f1 = 0
Silvio Berlusconi ['Sergio Chiamparino']
em = False, f1 = 0
FC St. Gallen ['FC Gold Pride']
em = False, f1 = 0.3333333333333333
FC Wout Brama ['Netherlands national association football team', 'FC Twente']
em = False, f1 = 0.4
NBC News ['US Airways']
em = False, f1 = 0
NBC News ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
Yves Saint Laurent-de-Ville ['Stanford University School of Medicine']
em = False, f1 = 0
Y Combinator ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
FC Universitatea Craiova ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
Sven-Göran Eriksson ['Dag-Eilev Fagermo']
em = False, f1 = 0
FC Universitatea Craiova ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
UNESCO ['Agnes Gund']
em = False, f1 = 0
Italian Democratic Party ['The People of Freedom']
em = False, f1 = 0
MIT Media Lab ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Unión Espaa ['Televisión Española']
em = False, f1 = 0
MEP ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
Conor Murray ['Munster Rugby']
em = False, f1 = 0
lvaro lvarez ['Tibisay Lucena']
em = False, f1 = 0
Social Democratic Party of Norway ["People's Party"]
em = False, f1 = 0.28571428571428575
FC St. Petersburg ['Stevenage F.C.']
em = False, f1 = 0.4
4chan Group ['Christopher Poole']
em = False, f1 = 0
MEP ['Chief Whip']
em = False, f1 = 0
Grasshoppers ['Dagenham & Redbridge F.C.']
em = False, f1 = 0
Finland ['University of Jyväskylä']
em = False, f1 = 0
lvaro Cáceres ['Michel Wolter']
em = False, f1 = 0
Xerox ['MSNBC']
em = False, f1 = 0
SourceForge, Inc ['Vera Augustin Research']
em = False, f1 = 0
CBE ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0
The Kennel Club ['S. I. Newhouse']
em = False, f1 = 0
NBCUniversal ['Rudolf Staechelin']
em = False, f1 = 0
The New York Times ['Burnet Institute']
em = False, f1 = 0
tefan Bălcescu ['Emil Săndoi']
em = False, f1 = 0
Y Combinator ['Iniva']
em = False, f1 = 0
Sergei Sergeyevich Ivanov ['Valentina Matviyenko']
em = False, f1 = 0
SK eljezniar ['Derby County F.C.']
em = False, f1 = 0
Shigeru Ishii ['Keiji Yamada']
em = False, f1 = 0
SK Rapid Wien ['Chicago Bulls']
em = False, f1 = 0
CSKA Moscow ['England and Wales cricket team']
em = False, f1 = 0
FC Barcelona B ['Middlesbrough F.C.']
em = False, f1 = 0.4
United States Secretary of State ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0.1818181818181818
FC St. Petersburg ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
RC Lens ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
NBC News ["Brigham and Women's Hospital"]
em = False, f1 = 0
Democrat ['President of Mauritius']
em = False, f1 = 0
The New York Times ['Harvard Medical School']
em = False, f1 = 0
National Assembly of Spain ['Democratic Union of Catalonia']
em = False, f1 = 0.25
Gregorio Aguinaldo ['Vilma Santos']
em = False, f1 = 0
Petronas ['First Quantum Minerals']
em = False, f1 = 0
Argentine Association for the Advancement of Science ['Institutional Republican Party']
em = False, f1 = 0
National Assembly of France ['Democratic Convergence of Catalonia']
em = False, f1 = 0.25
Democratic Party ['Conservative Party']
em = False, f1 = 0.5
stgötland ['Colorado State University']
em = False, f1 = 0
SV Werder Bremen II ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0
scar lvarez ['Karel Schwarzenberg']
em = False, f1 = 0
NBC News ['East Carolina Pirates football']
em = False, f1 = 0
Democrat ['United States representative']
em = False, f1 = 0
United States Attorney ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0.6666666666666666
Wolfgang von Karajan ['Wolfgang Lück']
em = False, f1 = 0.4
FC Barcelona ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
Mauricio lvarez ['Danny De Bie']
em = False, f1 = 0
JS Kabylie ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
Sergey Ivanovich Kostyuk ['Volodymyr Lytvyn']
em = False, f1 = 0
Jean-Pierre Lefebvre ['Lucette Michaux-Chevry']
em = False, f1 = 0
National Assembly of Romania ['independent politician']
em = False, f1 = 0
University of the West Indies ['The Park School of Buffalo']
em = False, f1 = 0.25
Justice of the Peace ['United States representative']
em = False, f1 = 0
Graeme ['Joe Bossano']
em = False, f1 = 0
Democrat ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
Russian Academy of Sciences ['A Just Russia']
em = False, f1 = 0
Antônio Carlos de Oliveira ['Gilberto Kassab']
em = False, f1 = 0
Antônio Carlos de Oliveira ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Progressive Party ['Liberty Korea Party']
em = False, f1 = 0.3333333333333333
Sri Lanka Freedom Party ['New Democratic Party']
em = False, f1 = 0.28571428571428575
Accrington Stanley ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0
NBC News ['University of Connecticut']
em = False, f1 = 0
Rand Art Museum ['Alice Walton']
em = False, f1 = 0
Democratic Party of Puerto Rico ['Left, Ecology and Freedom']
em = False, f1 = 0
R.A. Dickey ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
Al-Shorta ['Club Brugge K.V.']
em = False, f1 = 0
Kongregate Group ['GameStop']
em = False, f1 = 0
FC Barcelona B ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
NBC News ['University of Strathclyde']
em = False, f1 = 0
NBC News ['Washington University in St.\xa0Louis']
em = False, f1 = 0
Kre Schultz ['Novo Nordisk']
em = False, f1 = 0
Eurosport Group ['TF1 Group']
em = False, f1 = 0.5
Justice of the Peace ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0.2
Italian Democratic Party ['The People of Freedom']
em = False, f1 = 0
Abdullah bin Abdullah Al Thani ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0.6666666666666666
efovi ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
Justice of the Peace ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0.25
The New York Times ['United States Department of Justice']
em = False, f1 = 0
Democratic Party ['New Democratic Party']
em = False, f1 = 0.8
Romanian National Assembly ['Social Democratic Party']
em = False, f1 = 0
National Assembly for Wales ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0
Luiz José Lula da Silva ['Yeda Crusius']
em = False, f1 = 0
FC Barcelona B ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0.4
UNESCO ['Harvard University']
em = False, f1 = 0
National Assembly of France ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.22222222222222224
Liaoning City Council ['Chen Zhenggao']
em = False, f1 = 0
LA Weekly ['Village Voice Media']
em = False, f1 = 0
Xu ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
National Assembly of Spain ['Democratic Convergence of Catalonia']
em = False, f1 = 0.25
FC St. Petersburg ['England and Wales cricket team']
em = False, f1 = 0
FC Porto ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0.5
 ['Minister of Defence']
em = False, f1 = 0
Xerox ['RAI']
em = False, f1 = 0
M.C. ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
comte della Repubblica ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Al-Ahly ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
National Assembly of Romania ['Democratic Liberal Party']
em = False, f1 = 0
The New York Times ['Oregon Ducks']
em = False, f1 = 0
Y Combinator ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
eljko ivkovi ['Reinoldijus Šarkinas']
em = False, f1 = 0
National Assembly of Romania ['Democratic Convergence of Catalonia']
em = False, f1 = 0.25
Justice of the Peace ['dean of Liverpool']
em = False, f1 = 0.3333333333333333
Liu Xiaoyuan ['Cho Po-yuan']
em = False, f1 = 0
Nexstar Media Group, Inc ['Denison University']
em = False, f1 = 0
David A. Sullivan ['Hélène Langevin-Joliot']
em = False, f1 = 0
Yokohama FC ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
The New York Times ['Queens Museum']
em = False, f1 = 0
UNESCO ['University of Chile']
em = False, f1 = 0
Mike McKay ['Les Miles']
em = False, f1 = 0
NBC ['Hamilton College', 'Vassar College']
em = False, f1 = 0
NBC News ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
Yves Saint Laurent ['University of Münster']
em = False, f1 = 0
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
Social Democratic Party of Norway ['Norwegian Labour Party']
em = False, f1 = 0.25
MEP ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
Yves Saint Laurent ['Institute for Advanced Study']
em = False, f1 = 0
Democratic Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0.3333333333333333
University of Lagos ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
Pakistan Peoples Party ['Pakistan Muslim League (Q)']
em = False, f1 = 0.28571428571428575
Józef wicicki ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
Democrat ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
St. Patrick's Athletic ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
Registrar of Publications ['United States representative']
em = False, f1 = 0
Universidad de Chile ['ETH Zurich']
em = False, f1 = 0
SK Rapid Wien ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0
Democrat of the Year ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0.25
Justice of the Peace ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.2222222222222222
FC St. Gallen ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0.3333333333333333
FC Barcelona B ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
Jean-Pierre Lefèvre ['Jean-Louis Garcia']
em = False, f1 = 0
Democrat ['White House Chief of Staff']
em = False, f1 = 0
Democrat of Finland ['chairperson']
em = False, f1 = 0
Lithuanian National Assembly ['SYRIZA']
em = False, f1 = 0
Accrington Stanley ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0
Lucas Richman ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
Democrat ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0
Electoral Elect ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0
Electoral Elect ['permanent representative of Spain to the European Union']
em = False, f1 = 0
FC Olimpia Basel ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Lithuanian Democratic Party ["People's Party"]
em = False, f1 = 0.4
SV Werder Bremen ['Santa Clara Broncos']
em = False, f1 = 0
Y Combinator ['University College London']
em = False, f1 = 0
MEP ['Secretary for Relations with States']
em = False, f1 = 0
The New York Times ['Lunar and Planetary Institute']
em = False, f1 = 0
JS Kabylie ['Pakistan national cricket team']
em = False, f1 = 0
Indian National Congress ['Indian National Congress']
em = True, f1 = 1.0
MIT Media Lab ['University of Southampton']
em = False, f1 = 0
Bergen Metro ['Norwegian National Rail Administration']
em = False, f1 = 0
Amar Gupta ['University of Arizona']
em = False, f1 = 0
Editura coala d'Arte ['University of Windsor']
em = False, f1 = 0
Carlos Alberto González Navarro ['Rick Perry']
em = False, f1 = 0
United States Attorney ['president']
em = False, f1 = 0
Justice of the Peace ['member of the European Parliament']
em = False, f1 = 0.28571428571428575
Xerox ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Kahn ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Yenisey Kravchenko ['Massachusetts General Hospital']
em = False, f1 = 0
UNESCO ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0
Markus Schreiber ['Reiner Hollich']
em = False, f1 = 0
Democratic Party ['Republican Party']
em = False, f1 = 0.5
RC Lens ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
lvaro Aguilar ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
Armenian National Radio ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0.28571428571428575
SK Rapid Wien ['New England Patriots']
em = False, f1 = 0
National Assembly of Brazil ['Alternative Democratic Pole']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
rnsköldsvik ['Ineos Grenadier']
em = False, f1 = 0
St. John's University ['South Garland High School']
em = False, f1 = 0
Democrat of the Year ['White House Cabinet Secretary']
em = False, f1 = 0
FC Barcelona B ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
National Assembly of Pakistan ['Kadima']
em = False, f1 = 0
Justice of the Peace ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
National Assembly of France ['Socialist Party']
em = False, f1 = 0
Romanian National Assembly ['Social Democratic Party']
em = False, f1 = 0
MEP ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
NBC News ['University of Bath']
em = False, f1 = 0
FC Porto ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0.5
 ['Mayor of Tehran']
em = False, f1 = 0
Democratic Party ['Liberal Democratic Party']
em = False, f1 = 0.8
Y Combinator ['Osnabrück University']
em = False, f1 = 0
comte d'Orsay ['director', 'president']
em = False, f1 = 0
Pakistan Peoples Party ['Bahujan Samaj Party']
em = False, f1 = 0.3333333333333333
Luca Becchio ['Leeds United F.C.']
em = False, f1 = 0
Italian Democratic Party ['Democratic Party', 'Union of the Centre']
em = False, f1 = 0.8
SK Rapid Wien ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
Seoul National University ['Hanyang University']
em = False, f1 = 0.4
Accensi Accensi ['Democratic Convergence of Catalonia']
em = False, f1 = 0
scar lvarez ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Maurizio Graziani ['Jürgen Klopp']
em = False, f1 = 0
Republican Party ['independent politician']
em = False, f1 = 0
National Assembly of France ['Union for a Popular Movement']
em = False, f1 = 0
FC Barcelona B ['Hull City A.F.C.']
em = False, f1 = 0
Al-Ahli ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Energia ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
SK Rapid Wien ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
Yuriy Yakovlev ['Anni Sinnemäki']
em = False, f1 = 0
Yenisei Yeni ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
The Netherlands Academy of Arts and Sciences ['Erasmus University Rotterdam']
em = False, f1 = 0
Syed Abdullah ['Mufti Mohammad Sayeed']
em = False, f1 = 0
The New York Times ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers LLC ['Berkshire Hathaway']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
NBC News ['The Rockefeller University']
em = False, f1 = 0
University of Amsterdam ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.4444444444444444
SK Rapid Wien ['Sunderland A.F.C.']
em = False, f1 = 0
Islamic Republic of Iran Party ['Malaysian Islamic Party']
em = False, f1 = 0.5
Gerhard Schröder ['Florian Pronold']
em = False, f1 = 0
Sé ['Martin Russell']
em = False, f1 = 0
National Assembly of Romania ['Democratic Liberal Party']
em = False, f1 = 0
University of Prague ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0.6666666666666666
Westfield Wheaton LLC ['Westfield Group']
em = False, f1 = 0.4
Yves Saint Laurent-de-Ville ['Freie Universität Berlin']
em = False, f1 = 0
Silvio Berlusconi ['Letizia Moratti']
em = False, f1 = 0
FC Barcelona B ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
FC St. Gallen ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0.4
Democrat of the Year ['president']
em = False, f1 = 0
Federal Building Development Corporation ['General Services Administration']
em = False, f1 = 0
Romanian People's Deputy of Romania ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
Yoh Iwasa Productions ['Kyushu University']
em = False, f1 = 0
UNESCO ['Monash University']
em = False, f1 = 0
NBC News ['California State University, Monterey Bay']
em = False, f1 = 0
lvaro lvarez ['Ernesto Valverde']
em = False, f1 = 0
Azerbaijan University ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0
Yves de la Gardie ['Jan du Plessis']
em = False, f1 = 0
Jacques-Louis David ['Serge Lepeltier']
em = False, f1 = 0
sterreichischer Rundfunk ['Borussia Dortmund']
em = False, f1 = 0
François-Joseph Lafontaine ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
People's Democratic Party ['Democrats']
em = False, f1 = 0
FC Barcelona B ['Astana']
em = False, f1 = 0
Justice of the Peace ['secretary of state']
em = False, f1 = 0.3333333333333333
Harvard University ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV LLC ['Teracom']
em = False, f1 = 0
Charlotte Hornets LLC ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
FC Barcelona B ['Arsenal F.C.']
em = False, f1 = 0.4
FC Dinamo Tbilisi ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0
FC Barcelona B ['Brazil Olympic football team']
em = False, f1 = 0
Silvio Berlusconi ['Luigi Albore Mascia']
em = False, f1 = 0
David A. Sullivan ['John Maeda']
em = False, f1 = 0
Social Democratic Party of Belgium ["Conservative People's Party"]
em = False, f1 = 0.25
NBC News ['Rutgers Scarlet Knights football']
em = False, f1 = 0
Taoiseach ['Teachta Dála', 'Minister for Social Protection']
em = False, f1 = 0
CSKA Moscow ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
NBC Universal ['University of Pennsylvania']
em = False, f1 = 0
FC Universitatea Craiova ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
rneath ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Mike McCoy ['John Fox']
em = False, f1 = 0
Bangladesh Nationalist Party ['Muttahida Qaumi Movement']
em = False, f1 = 0
eljko orevi ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
CBE ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0
KS ód ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0
St. John's College ['Rowville Secondary College']
em = False, f1 = 0.3333333333333333
Y Combinator ['University of Exeter']
em = False, f1 = 0
NBC Universal ['Google']
em = False, f1 = 0
FC Barcelona ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0.4
David Jones ['Dafydd Elis-Thomas']
em = False, f1 = 0
FC St. Petersburg ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0.4
Erin McLeod ['Washington Freedom']
em = False, f1 = 0
John C. McKinley ['David H. Bieter']
em = False, f1 = 0
UNESCO ['Trans TV']
em = False, f1 = 0
NBC News ['bp']
em = False, f1 = 0
Giuseppe Giacometti ['Giuseppe Merisi']
em = False, f1 = 0.5
Governing Council of the European Union ['Democratic Convergence of Catalonia']
em = False, f1 = 0.22222222222222224
Serbian Progressive Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.25
Ferrari Corporation ['Fiat S.p.A.']
em = False, f1 = 0
FC Universitatea Craiova ['Real Madrid CF']
em = False, f1 = 0
Yves Saint Laurent ['Eutelsat']
em = False, f1 = 0
Accademia di Belle Arti di Roma ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
FC Barcelona B ['Golden State Warriors']
em = False, f1 = 0
St. Mary's College ['St. Xavier High School']
em = False, f1 = 0.28571428571428575
NBC News ['Apple Inc.']
em = False, f1 = 0
Hans-Joachim Schröder ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
Sveriges Riksrat ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0
SV Werder Bremen ['Arsenal F.C.']
em = False, f1 = 0
Chancellor of the Peace ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0.3333333333333333
MEP ['Minister of Children and Family Affairs']
em = False, f1 = 0
U.S. Attorney ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0
National Assembly of France ['Authenticity and Modernity Party']
em = False, f1 = 0
Jean-Pierre Lefebvre ['Martine Lignières-Cassou']
em = False, f1 = 0
CSKA Moscow ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
Y Combinator ['University of Bristol']
em = False, f1 = 0
PEN International ['John R. Saul']
em = False, f1 = 0
SK Rapid Wien ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0
Justice of the Peace ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0.2222222222222222
Ahmed Al-Mahdi Al-Sahrawi ['Abdelkader Taleb Omar']
em = False, f1 = 0
Labour Party ['Liberal National Party of Queensland']
em = False, f1 = 0.28571428571428575
The New York Times ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
Peter O'Neill ['Len Brown']
em = False, f1 = 0
FIAT Italy ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 1: 100%|██████████| 91/91 [00:11<00:00,  8.07it/s, loss=6.79]
                                                            [A
Epoch 1:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.79]         
Epoch 2:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.79]
Epoch 2:   1%|          | 1/91 [00:00<00:43,  2.07it/s, loss=6.79]
Epoch 2:   2%|▏         | 2/91 [00:00<00:23,  3.78it/s, loss=6.79]
Epoch 2:   3%|▎         | 3/91 [00:00<00:18,  4.75it/s, loss=6.63]
Epoch 2:   4%|▍         | 4/91 [00:00<00:14,  5.90it/s, loss=6.63]
Epoch 2:   5%|▌         | 5/91 [00:00<00:12,  6.91it/s, loss=6.63]
Epoch 2:   7%|▋         | 6/91 [00:00<00:11,  7.33it/s, loss=6.43]
Epoch 2:   8%|▊         | 7/91 [00:00<00:10,  8.07it/s, loss=6.43]
Epoch 2:   9%|▉         | 8/91 [00:00<00:09,  8.77it/s, loss=6.43]
Epoch 2:  10%|▉         | 9/91 [00:01<00:09,  8.46it/s, loss=6.21]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.54it/s][A
Epoch 2:  67%|██████▋   | 61/91 [00:01<00:00, 39.35it/s, loss=6.21]
Validating:  73%|███████▎  | 60/82 [00:00<00:00, 158.32it/s][AUniversity College London ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.4444444444444444
Democratic Party for Freedom and Democracy ['Siumut']
em = False, f1 = 0
Ministry of Foreign Affairs ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0.5
Democratic Party of Japan ['Democratic Party']
em = False, f1 = 0.6666666666666666
Université Laval ['INSEP']
em = False, f1 = 0
stgaard ['Vibeke Storm Rasmussen']
em = False, f1 = 0
Registrar of Companies of Israel ['Speaker of the Knesset']
em = False, f1 = 0.25
JS Kabylie ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0
Yashwantrao ['Philipp Mißfelder']
em = False, f1 = 0
NBC News ['University of Sussex']
em = False, f1 = 0
Rothschild Group ['Alexander Ivanov']
em = False, f1 = 0
Universidad Católica ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
smet nönü ['Kadir Topbaş']
em = False, f1 = 0
eljko eljko ['Yuriy Maleyev']
em = False, f1 = 0
Argentinos Juniors ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0
Yves-Alexandre Lehmann ['Andreas Baum']
em = False, f1 = 0
Ministry of Foreign Affairs ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0.36363636363636365
Finnish People's Party ['Centre Party']
em = False, f1 = 0.4
jpest ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0
Democratic Party of the Left ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0.3333333333333333
NBC News ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar Group ['London and Continental Railways']
em = False, f1 = 0
Democrat ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
Northampton Town ['Atlanta Beat']
em = False, f1 = 0
University of Heidelberg ['Cambridge High School']
em = False, f1 = 0
Yves de la Gardie ['Stefanos Manos']
em = False, f1 = 0
Yves Saint Laurent ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
NBC News ['Roll Call']
em = False, f1 = 0
Jeremy Corbyn ['University of Sheffield']
em = False, f1 = 0
Max Planck ['Peter Gruss']
em = False, f1 = 0
Accrington Stanley ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0
eljko orevi ['Albin Kurti']
em = False, f1 = 0
Accrington Stanley ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0
Pakistan Peoples Party ['Indian National Congress']
em = False, f1 = 0
stfold AB ['Case Western Reserve University']
em = False, f1 = 0
Associated Press ['University of York']
em = False, f1 = 0
University College London ['Stanford University', 'University of California, Los Angeles']
em = False, f1 = 0.4
NBC News ['University of Michigan']
em = False, f1 = 0
NBC ['University of Warwick']
em = False, f1 = 0
Darren O'Connor ['Mark McGregor']
em = False, f1 = 0
NBC News ['Merrill Lynch']
em = False, f1 = 0
Registrar of the Philippines ['President of the Philippines']
em = False, f1 = 0.6666666666666666
Yuri Gagarin ['Daniel Carp']
em = False, f1 = 0
Argentinos Juniors ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
ONGC ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
IFK Göteborg ['Ineos Grenadier']
em = False, f1 = 0
Xiamen University ['Microsoft Corporation']
em = False, f1 = 0
Accrington Stanley ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0
Yuriy Yakovlev ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo University ['Beacon Capital Partners']
em = False, f1 = 0
Justice of the Peace ['Vice President of Ghana']
em = False, f1 = 0.28571428571428575
Yashwantrao ['Craig Fugate']
em = False, f1 = 0
Chancellor of the Peace ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0.2222222222222222
Ministry of Foreign Affairs ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0.25
Ministry of Foreign Affairs and Trade ['general secretary']
em = False, f1 = 0
Accrington Stanley ['Manchester United F.C.']
em = False, f1 = 0
Universidad de Chile ['United States Copyright Office']
em = False, f1 = 0
Associated Press ['Christian Dior S.A.']
em = False, f1 = 0
Argentinos Juniors ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
University of North Carolina ['Regis Jesuit High School']
em = False, f1 = 0
Yves Saint Laurent ['Birkbeck, University of London']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
Serie B ['Yamaha Motor Racing']
em = False, f1 = 0
eljezniar ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0
Accrington Stanley ['AFC Bournemouth']
em = False, f1 = 0
Yves Saint Laurent ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania State Senate ['Ed Rendell']
em = False, f1 = 0
David Davidson ['Justin King']
em = False, f1 = 0
Yves de la Gardie ['Jean-Marie Le Pen']
em = False, f1 = 0
Maurizio Giacometti ['Ottmar Hitzfeld']
em = False, f1 = 0
UMNO ['United Malays National Organisation']
em = False, f1 = 0
FC Barcelona ['Scuderia Ferrari']
em = False, f1 = 0
Yash Raj ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape Communications ['AOL']
em = False, f1 = 0
Mauricio Maas ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
ZANU PF ['President of Zimbabwe']
em = False, f1 = 0
Electoral Commission ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0
NBC News ['Durham University']
em = False, f1 = 0
Granada Television ['University of Cambridge']
em = False, f1 = 0
Al-Ahly ['Blackburn Rovers F.C.']
em = False, f1 = 0
Accrington Stanley ['San Diego Padres']
em = False, f1 = 0
1860 Munich ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
RC Lens ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0
UMP ['Socialist Party']
em = False, f1 = 0
Yuriy Yakovlev ['Johannes Vogel']
em = False, f1 = 0
Chancellor of the Peace ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
Justice of the Peace ['state treasurer']
em = False, f1 = 0
Polski ['Donald Tusk']
em = False, f1 = 0
CSKA Sofia ['Chelsea F.C.']
em = False, f1 = 0
Silvio Berlusconi ['Alessandro Cosimi']
em = False, f1 = 0
Democratic Party ['National Liberal Party']
em = False, f1 = 0.4
UMP ['Horizon Monaco']
em = False, f1 = 0
Yuriy Yakovlev ['Olegario Vázquez Raña']
em = False, f1 = 0
Ministry of Foreign Affairs ['Prime Minister of Turkey']
em = False, f1 = 0.25
Democratic Party of Italy ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Kimbrough County ['West Texas A&M University']
em = False, f1 = 0
Serbian Progressive Party ['NOW – Pilz List']
em = False, f1 = 0
NBC News ['Yahoo']
em = False, f1 = 0
Granada Television ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
Accrington Stanley ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
Sean O'Brien ['chief technology officer']
em = False, f1 = 0
Xiamen University ['Regent University']
em = False, f1 = 0.5
Fratelli ['RCS MediaGroup']
em = False, f1 = 0
Accrington Stanley ['FC Twente']
em = False, f1 = 0
eská tpánek ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
Associated Newspapers ['IT University of Copenhagen']
em = False, f1 = 0
lvaro Cárdenas ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
lvaro Cárdenas ['Quique Sánchez Flores']
em = False, f1 = 0
stgötland ['State Secretary']
em = False, f1 = 0
Silvio Berlusconi ['Sergio Chiamparino']
em = False, f1 = 0
New York City FC ['FC Gold Pride']
em = False, f1 = 0.28571428571428575
SV Werder Bremen ['Netherlands national association football team', 'FC Twente']
em = False, f1 = 0
NBC News ['US Airways']
em = False, f1 = 0
The New York Times ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
sterreichischer Rundfunk ['Stanford University School of Medicine']
em = False, f1 = 0
Jeremy Corbyn ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
Manchester United ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
stlund st ['Dag-Eilev Fagermo']
em = False, f1 = 0
Accrington Stanley ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
Democratic Party of Italy ['The People of Freedom']
em = False, f1 = 0.28571428571428575
UNESCO ['Agnes Gund']
em = False, f1 = 0
Democratic Party of Italy ['The People of Freedom']
em = False, f1 = 0.28571428571428575
UNESCO ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Buenos Aires ['Televisión Española']
em = False, f1 = 0
comte d'Ordre national du Québec ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
Ayr United ['Munster Rugby']
em = False, f1 = 0
Nicolás del Castillo ['Tibisay Lucena']
em = False, f1 = 0
Christian Democratic Party ["People's Party"]
em = False, f1 = 0.4
CSKA Sofia ['Stevenage F.C.']
em = False, f1 = 0
BT Group ['Christopher Poole']
em = False, f1 = 0
Registrar of Societies ['Chief Whip']
em = False, f1 = 0
Accrington Stanley ['Dagenham & Redbridge F.C.']
em = False, f1 = 0
Finland ['University of Jyväskylä']
em = False, f1 = 0
scar lvarez ['Michel Wolter']
em = False, f1 = 0
NBC News ['MSNBC']
em = False, f1 = 0
Xerox ['Vera Augustin Research']
em = False, f1 = 0
People's Deputy ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0
The Kennel Club ['S. I. Newhouse']
em = False, f1 = 0
NBCUniversal ['Rudolf Staechelin']
em = False, f1 = 0
NBC News ['Burnet Institute']
em = False, f1 = 0
tefan Bălcescu ['Emil Săndoi']
em = False, f1 = 0
Granada Television ['Iniva']
em = False, f1 = 0
Yuriy Yeltsin ['Valentina Matviyenko']
em = False, f1 = 0
Accrington Stanley ['Derby County F.C.']
em = False, f1 = 0
Yko Takahashi ['Keiji Yamada']
em = False, f1 = 0
SV Werder Bremen ['Chicago Bulls']
em = False, f1 = 0
Accrington Stanley ['England and Wales cricket team']
em = False, f1 = 0
Argentinos Juniors ['Middlesbrough F.C.']
em = False, f1 = 0
Electoral College of Victoria ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0.2
West Ham United F.C. ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0.2
RC Lens ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
NBC News ["Brigham and Women's Hospital"]
em = False, f1 = 0
Ministry of Foreign Affairs and Trade ['President of Mauritius']
em = False, f1 = 0.2222222222222222
The New York Times ['Harvard Medical School']
em = False, f1 = 0
Argentine Democratic Party ['Democratic Union of Catalonia']
em = False, f1 = 0.28571428571428575
Gregorio Aguinaldo ['Vilma Santos']
em = False, f1 = 0
Russia ['First Quantum Minerals']
em = False, f1 = 0
Argentine Democratic Party ['Institutional Republican Party']
em = False, f1 = 0.3333333333333333
UMP ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Labour Party ['Conservative Party']
em = False, f1 = 0.5
stfold FF ['Colorado State University']
em = False, f1 = 0
Accrington Stanley ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0
Yuriy Yakovlev ['Karel Schwarzenberg']
em = False, f1 = 0
RTÉ ['East Carolina Pirates football']
em = False, f1 = 0
Registrar of Societies ['United States representative']
em = False, f1 = 0
United States Secretary of the Navy ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0.5
Günther Schröder ['Wolfgang Lück']
em = False, f1 = 0
FC Barcelona B ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
lvaro lvarez ['Danny De Bie']
em = False, f1 = 0
JS Kabylie ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
Yuriy Kozlov ['Volodymyr Lytvyn']
em = False, f1 = 0
François Xavier ['Lucette Michaux-Chevry']
em = False, f1 = 0
Democratic Party of Romania ['independent politician']
em = False, f1 = 0
University of the West Indies ['The Park School of Buffalo']
em = False, f1 = 0.25
Chancellor of the Peace ['United States representative']
em = False, f1 = 0
Graeme Davidson ['Joe Bossano']
em = False, f1 = 0
Chartered Accountant ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
Democratic Party of Ukraine ['A Just Russia']
em = False, f1 = 0
Paulista lvares ['Gilberto Kassab']
em = False, f1 = 0
Paulista lvares ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Party of Korea ['Liberty Korea Party']
em = False, f1 = 0.5714285714285715
Sri Lanka Freedom Party ['New Democratic Party']
em = False, f1 = 0.28571428571428575
Accrington Stanley ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0
Associated Press ['University of Connecticut']
em = False, f1 = 0
Rand Art Museum ['Alice Walton']
em = False, f1 = 0
Democratic Party ['Left, Ecology and Freedom']
em = False, f1 = 0
West Ham United F.C. ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
Al-Hilal ['Club Brugge K.V.']
em = False, f1 = 0
Kongregate Group ['GameStop']
em = False, f1 = 0
Argentinos Juniors ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
Granada Television ['University of Strathclyde']
em = False, f1 = 0
NBC ['Washington University in St.\xa0Louis']
em = False, f1 = 0
stfold ['Novo Nordisk']
em = False, f1 = 0
FIA ['TF1 Group']
em = False, f1 = 0
Office of the Attorney General ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0.18181818181818182
Democratic Party of Italy ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Qatar ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0
efovi ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
Sean O'Connor ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0
The New York Times ['United States Department of Justice']
em = False, f1 = 0
Democratic Party of Australia ['New Democratic Party']
em = False, f1 = 0.5714285714285715
Democratic Party of Romania ['Social Democratic Party']
em = False, f1 = 0.5714285714285715
Labour Party ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0.3333333333333333
Maurcio Gonçalves ['Yeda Crusius']
em = False, f1 = 0
Accrington Stanley ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0
UNESCO ['Harvard University']
em = False, f1 = 0
Democratic Party ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.28571428571428575
Liaoning Xiaoping ['Chen Zhenggao']
em = False, f1 = 0
Los Angeles Times ['Village Voice Media']
em = False, f1 = 0
Yuriy Ivanov ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Accrington Stanley ['England and Wales cricket team']
em = False, f1 = 0
So Paulo FC ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0.4
 ['Minister of Defence']
em = False, f1 = 0
Universidad Católica ['RAI']
em = False, f1 = 0
Seanad Éireann ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
comte della Repubblica ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Al-Ahly ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
Democratic Party of Romania ['Democratic Liberal Party']
em = False, f1 = 0.5714285714285715
NBC News ['Oregon Ducks']
em = False, f1 = 0
The Netherlands ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
eljko eljko ['Reinoldijus Šarkinas']
em = False, f1 = 0
Democratic Party of the Left ['Democratic Convergence of Catalonia']
em = False, f1 = 0.5
Electoral College ['dean of Liverpool']
em = False, f1 = 0
Xiao Xiaoping ['Cho Po-yuan']
em = False, f1 = 0
Cumulus Media ['Denison University']
em = False, f1 = 0
Jeremy Corbyn ['Hélène Langevin-Joliot']
em = False, f1 = 0
Accrington Stanley ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
Granada Television ['Queens Museum']
em = False, f1 = 0
Buenos Aires ['University of Chile']
em = False, f1 = 0
Darren O'Brien ['Les Miles']
em = False, f1 = 0
NBC News ['Hamilton College', 'Vassar College']
em = False, f1 = 0
NBC News ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
Yves Saint Laurent ['University of Münster']
em = False, f1 = 0
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
stfold ['Norwegian Labour Party']
em = False, f1 = 0
Electoral Commission ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
Yves Saint Laurent ['Institute for Advanced Study']
em = False, f1 = 0
Democratic Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0.3333333333333333
University of Lagos ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
Pakistan Peoples Party ['Pakistan Muslim League (Q)']
em = False, f1 = 0.28571428571428575
ukasz Kocielny ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
Office of the Secretary of the Navy ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
Port Vale ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
Registrar of Societies ['United States representative']
em = False, f1 = 0
Universidad Católica ['ETH Zurich']
em = False, f1 = 0
Aston Villa ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0
Democrat ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0.33333333333333337
Registrar of Companies ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.2222222222222222
Accrington Stanley ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0
stanbul BB ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
François-Joseph Lefèvre ['Jean-Louis Garcia']
em = False, f1 = 0
Ministry of Foreign Affairs and Trade ['White House Chief of Staff']
em = False, f1 = 0.1818181818181818
Ministry of Foreign Affairs ['chairperson']
em = False, f1 = 0
Democratic Party of Lithuania ['SYRIZA']
em = False, f1 = 0
Accrington Stanley ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0
NBC News ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
Chartered Accountant ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0
Electoral Argentine ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0
Electoral Elect ['permanent representative of Spain to the European Union']
em = False, f1 = 0
IFK Göteborg ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Lithuanian People's Party ["People's Party"]
em = False, f1 = 0.8
SV Werder Bremen ['Santa Clara Broncos']
em = False, f1 = 0
Granada Television ['University College London']
em = False, f1 = 0
comte d'Ordre national du Québec ['Secretary for Relations with States']
em = False, f1 = 0
The New York Times ['Lunar and Planetary Institute']
em = False, f1 = 0
ONGC ['Pakistan national cricket team']
em = False, f1 = 0
DMK ['Indian National Congress']
em = False, f1 = 0
NBC ['University of Southampton']
em = False, f1 = 0
Bergen Commuter Rail ['Norwegian National Rail Administration']
em = False, f1 = 0.28571428571428575
BJP ['University of Arizona']
em = False, f1 = 0
Romanian Democratic Party ['University of Windsor']
em = False, f1 = 0
lvaro Uribe ['Rick Perry']
em = False, f1 = 0
United States Secretary of the Navy ['president']
em = False, f1 = 0
Registrar of Societies ['member of the European Parliament']
em = False, f1 = 0.28571428571428575
Jeremy Corbyn ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Honolulu ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Yuriy Yakovlev ['Massachusetts General Hospital']
em = False, f1 = 0
Yves Saint Laurent ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0
Eberhard Schröder ['Reiner Hollich']
em = False, f1 = 0
Democratic Party ['Republican Party']
em = False, f1 = 0.5
RC Lens ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
lvaro lvarez ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
Yuriy Yelchin ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0
lsk SK ['New England Patriots']
em = False, f1 = 0
Democratic Party ['Alternative Democratic Pole']
em = False, f1 = 0.4
Democratic Party of Italy ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Accrington Stanley ['Ineos Grenadier']
em = False, f1 = 0
University College Dublin ['South Garland High School']
em = False, f1 = 0
Advisory Committee on the Status of Women ['White House Cabinet Secretary']
em = False, f1 = 0
Argentinos Juniors ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
AKP ['Kadima']
em = False, f1 = 0
Justice of the Peace ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
UMP ['Socialist Party']
em = False, f1 = 0
Democratic Party of Romania ['Social Democratic Party']
em = False, f1 = 0.5714285714285715
Seanad Éireann ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
NBC ['University of Bath']
em = False, f1 = 0
So Paulo FC ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0.4
 ['Mayor of Tehran']
em = False, f1 = 0
Democratic Party of Japan ['Liberal Democratic Party']
em = False, f1 = 0.5714285714285715
Yenisey Krasnodar ['Osnabrück University']
em = False, f1 = 0
comte d'Orsay ['director', 'president']
em = False, f1 = 0
Pakistan Peoples Party ['Bahujan Samaj Party']
em = False, f1 = 0.3333333333333333
Serie B ['Leeds United F.C.']
em = False, f1 = 0
Democratic Party of Italy ['Democratic Party', 'Union of the Centre']
em = False, f1 = 0.6666666666666666
Universidad Católica ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
Seoul National University ['Hanyang University']
em = False, f1 = 0.4
Democratic Party of Italy ['Democratic Convergence of Catalonia']
em = False, f1 = 0.5
Maurizio Graziani ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Maurizio Di Luca ['Jürgen Klopp']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
UMP ['Union for a Popular Movement']
em = False, f1 = 0
Accrington Stanley ['Hull City A.F.C.']
em = False, f1 = 0
Al-Ahli ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Yushchenko ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
Accrington Stanley ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
Yuriy Yakovlev ['Anni Sinnemäki']
em = False, f1 = 0
 ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
University of the Netherlands ['Erasmus University Rotterdam']
em = False, f1 = 0.3333333333333333
BJP ['Mufti Mohammad Sayeed']
em = False, f1 = 0
The New York Times ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers ['Berkshire Hathaway']
em = False, f1 = 0
Democratic Party of Italy ['Democratic Party']
em = False, f1 = 0.6666666666666666
NBC News ['The Rockefeller University']
em = False, f1 = 0
University of Stellenbosch ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.4444444444444444
Accrington Stanley ['Sunderland A.F.C.']
em = False, f1 = 0
Bangladesh Awami League ['Malaysian Islamic Party']
em = False, f1 = 0
Yves Lehmann ['Florian Pronold']
em = False, f1 = 0
hÉireann ['Martin Russell']
em = False, f1 = 0
Democratic Party of Romania ['Democratic Liberal Party']
em = False, f1 = 0.5714285714285715
University of Szeged ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0.6666666666666666
Westfield Wheaton ['Westfield Group']
em = False, f1 = 0.5
Yves Saint Laurent-de-Ville ['Freie Universität Berlin']
em = False, f1 = 0
Silvio Berlusconi ['Letizia Moratti']
em = False, f1 = 0
Argentinos Juniors ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
Argyle ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0
Democrat ['president']
em = False, f1 = 0
United States Department of the Treasury ['General Services Administration']
em = False, f1 = 0
Electoral Elect ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
YES ['Kyushu University']
em = False, f1 = 0
UNESCO ['Monash University']
em = False, f1 = 0
Associated Press ['California State University, Monterey Bay']
em = False, f1 = 0
lvaro lvarez ['Ernesto Valverde']
em = False, f1 = 0
University of Tbilisi ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0.15384615384615383
Yves de la Gardie ['Jan du Plessis']
em = False, f1 = 0
François Mitterrand ['Serge Lepeltier']
em = False, f1 = 0
SK Rapid Wien ['Borussia Dortmund']
em = False, f1 = 0
François-Joseph Lefèvre ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
Democratic Party of the Left ['Democrats']
em = False, f1 = 0
Argentinos Juniors ['Astana']
em = False, f1 = 0
Office of the Secretary of the Navy ['secretary of state']
em = False, f1 = 0.5
University of Toronto ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV LLC ['Teracom']
em = False, f1 = 0
Charlotte Hornets LLC ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
FC Barcelona ['Arsenal F.C.']
em = False, f1 = 0.5
SK S.C. ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0
Universidad Católica ['Brazil Olympic football team']
em = False, f1 = 0
Silvio Berlusconi ['Luigi Albore Mascia']
em = False, f1 = 0
Judith A. Sullivan ['John Maeda']
em = False, f1 = 0
UMP ["Conservative People's Party"]
em = False, f1 = 0
The New York Times ['Rutgers Scarlet Knights football']
em = False, f1 = 0
Seanad Éireann ['Teachta Dála', 'Minister for Social Protection']
em = False, f1 = 0
CSKA Sofia ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
NBC News ['University of Pennsylvania']
em = False, f1 = 0
FC Porto ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
Shamrock Rovers ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Darren McDermott ['John Fox']
em = False, f1 = 0
Bangladesh Nationalist Party ['Muttahida Qaumi Movement']
em = False, f1 = 0
Yuriy Yakovlev ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
Government of India ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0.3333333333333333
KS ód ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0
St. Mary's College ['Rowville Secondary College']
em = False, f1 = 0.3333333333333333
Granada Television ['University of Exeter']
em = False, f1 = 0
NBC News ['Google']
em = False, f1 = 0
Argentinos Juniors ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0
David Jones ['Dafydd Elis-Thomas']
em = False, f1 = 0
Accrington Stanley ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0
Dundee United ['Washington Freedom']
em = False, f1 = 0
Norm McKay ['David H. Bieter']
em = False, f1 = 0
UNESCO ['Trans TV']
em = False, f1 = 0
Associated Press ['bp']
em = False, f1 = 0
Maurizio Giacometti ['Giuseppe Merisi']
em = False, f1 = 0
People's Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Serbian Progressive Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.25
FIA ['Fiat S.p.A.']
em = False, f1 = 0
Universidad Católica ['Real Madrid CF']
em = False, f1 = 0
UNESCO ['Eutelsat']
em = False, f1 = 0
Accademia Nazionale di Belle Arti ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
Argentinos Juniors ['Golden State Warriors']
em = False, f1 = 0
University College London ['St. Xavier High School']
em = False, f1 = 0
NBC News ['Apple Inc.']
em = False, f1 = 0
Hans-Joachim Schröder ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
strm ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0
SK Brann ['Arsenal F.C.']
em = False, f1 = 0
Registrar of Societies ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0.3333333333333333
Ministry of Foreign Affairs and Trade ['Minister of Children and Family Affairs']
em = False, f1 = 0.5
Chief of Police ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0.16666666666666666
UMP ['Authenticity and Modernity Party']
em = False, f1 = 0
François-Joseph Pau ['Martine Lignières-Cassou']
em = False, f1 = 0
Yokohama FC ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
Yves Saint Laurent ['University of Bristol']
em = False, f1 = 0
PEN International ['John R. Saul']
em = False, f1 = 0
SK Rapid Wien ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0
Chancellor of the Peace ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0.2222222222222222
Mohamed Al-Hassan ['Abdelkader Taleb Omar']
em = False, f1 = 0
Labour Party ['Liberal National Party of Queensland']
em = False, f1 = 0.28571428571428575
NBC News ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
Auckland City Council ['Len Brown']
em = False, f1 = 0
Accademia Italiana ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 2: 100%|██████████| 91/91 [00:11<00:00,  8.14it/s, loss=6.21]
                                                            [A
Epoch 2:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.21]         
Epoch 3:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.21]
Epoch 3:   1%|          | 1/91 [00:00<00:42,  2.10it/s, loss=6.21]
Epoch 3:   2%|▏         | 2/91 [00:00<00:23,  3.84it/s, loss=6.21]
Epoch 3:   3%|▎         | 3/91 [00:00<00:18,  4.83it/s, loss=5.96]
Epoch 3:   4%|▍         | 4/91 [00:00<00:14,  5.99it/s, loss=5.96]
Epoch 3:   5%|▌         | 5/91 [00:00<00:12,  7.02it/s, loss=5.96]
Epoch 3:   7%|▋         | 6/91 [00:00<00:11,  7.43it/s, loss=5.82]
Epoch 3:   8%|▊         | 7/91 [00:00<00:10,  8.18it/s, loss=5.82]
Epoch 3:   9%|▉         | 8/91 [00:00<00:09,  8.88it/s, loss=5.82]
Epoch 3:  10%|▉         | 9/91 [00:01<00:09,  8.53it/s, loss=5.61]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.56it/s][A
Epoch 3:  67%|██████▋   | 61/91 [00:01<00:00, 39.80it/s, loss=5.61]
Validating:  77%|███████▋  | 63/82 [00:00<00:00, 167.41it/s][AUniversity of the West of England ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.5454545454545454
People's Party for Freedom and Democracy ['Siumut']
em = False, f1 = 0
interior ministry ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
École nationale supérieure des mines ['INSEP']
em = False, f1 = 0
Denmark ['Vibeke Storm Rasmussen']
em = False, f1 = 0
interior ministry ['Speaker of the Knesset']
em = False, f1 = 0
Yokohama FC ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0.4
Yuriy Yakovlev ['Philipp Mißfelder']
em = False, f1 = 0
Jeremy Corbyn ['University of Sussex']
em = False, f1 = 0
Deutsche Bahn ['Alexander Ivanov']
em = False, f1 = 0
 ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
smet nönü ['Kadir Topbaş']
em = False, f1 = 0
Yuriy Ivanov ['Yuriy Maleyev']
em = False, f1 = 0.5
Argentine Primera B ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0
Nicolaus Copernicus ['Andreas Baum']
em = False, f1 = 0
interior ministry ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Centre Party']
em = False, f1 = 0.25
interior ministry ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0.25
United States of America ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar ['London and Continental Railways']
em = False, f1 = 0
Electoral Commissioner ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
Accrington Stanley ['Atlanta Beat']
em = False, f1 = 0
ETH Zurich ['Cambridge High School']
em = False, f1 = 0
Yuriy Yushchenko ['Stefanos Manos']
em = False, f1 = 0
RC Lens ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
Yvette Nicolet ['Roll Call']
em = False, f1 = 0
Labour Party ['University of Sheffield']
em = False, f1 = 0
Max Planck ['Peter Gruss']
em = False, f1 = 0
England Saxons ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0
eljko orevi ['Albin Kurti']
em = False, f1 = 0
England Saxons ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0.28571428571428575
Bangladesh Nationalist Party ['Indian National Congress']
em = False, f1 = 0
st nad Labe ['Case Western Reserve University']
em = False, f1 = 0
Yvette Nicole Brown ['University of York']
em = False, f1 = 0
Emmanuel College ['Stanford University', 'University of California, Los Angeles']
em = False, f1 = 0
United States Congress ['University of Michigan']
em = False, f1 = 0
United States Department of Justice ['University of Warwick']
em = False, f1 = 0.25
Darren O'Brien ['Mark McGregor']
em = False, f1 = 0
United States Congress ['Merrill Lynch']
em = False, f1 = 0
Prime Minister of the Philippines ['President of the Philippines']
em = False, f1 = 0.5714285714285715
U.S. Secretary of Transportation ['Daniel Carp']
em = False, f1 = 0
Argentinos Juniors ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
ONGC ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
IFK Göteborg ['Ineos Grenadier']
em = False, f1 = 0
Xinjiang ['Microsoft Corporation']
em = False, f1 = 0
YMCA ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0
Yuriy Yakovlev ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo Corporation ['Beacon Capital Partners']
em = False, f1 = 0
interior ministry ['Vice President of Ghana']
em = False, f1 = 0
Federal Emergency Management Agency ['Craig Fugate']
em = False, f1 = 0
interior ministry ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0
People's Representative of Singapore ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0.4444444444444445
interior ministry ['general secretary']
em = False, f1 = 0
England Saxons ['Manchester United F.C.']
em = False, f1 = 0
Buenos Aires ['United States Copyright Office']
em = False, f1 = 0
Jeremy Corbyn ['Christian Dior S.A.']
em = False, f1 = 0
Argentinos Juniors ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
University of Virginia ['Regis Jesuit High School']
em = False, f1 = 0
Yuriy Yelchin ['Birkbeck, University of London']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
Luca S.C. ['Yamaha Motor Racing']
em = False, f1 = 0
eljezniar ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0
England Saxons ['AFC Bournemouth']
em = False, f1 = 0
sterreichische Physik ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania State Senate ['Ed Rendell']
em = False, f1 = 0
Jeremy Corbyn ['Justin King']
em = False, f1 = 0
Yves Saint-Léger ['Jean-Marie Le Pen']
em = False, f1 = 0
Nicolaas Kübler ['Ottmar Hitzfeld']
em = False, f1 = 0
Democratic Party of Malaysia ['United Malays National Organisation']
em = False, f1 = 0
FC Barcelona ['Scuderia Ferrari']
em = False, f1 = 0
BJP ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape ['AOL']
em = False, f1 = 0
Mauricio Maas ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
interior ministry ['President of Zimbabwe']
em = False, f1 = 0
Electoral Commission ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0
United States Department of the Treasury ['Durham University']
em = False, f1 = 0
Jeremy Corbyn ['University of Cambridge']
em = False, f1 = 0
Yves Saint Laurent ['Blackburn Rovers F.C.']
em = False, f1 = 0
England Saxons ['San Diego Padres']
em = False, f1 = 0
SV Werder Bremen ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
RC Strasbourg ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0
Democratic Party ['Socialist Party']
em = False, f1 = 0.5
Jeremy Corbyn ['Johannes Vogel']
em = False, f1 = 0
interior ministry ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
interior ministry ['state treasurer']
em = False, f1 = 0
Polska ['Donald Tusk']
em = False, f1 = 0
UE Lleida ['Chelsea F.C.']
em = False, f1 = 0
Livorno ['Alessandro Cosimi']
em = False, f1 = 0
Democratic Party ['National Liberal Party']
em = False, f1 = 0.4
UMP ['Horizon Monaco']
em = False, f1 = 0
International Shooting Sport Federation ['Olegario Vázquez Raña']
em = False, f1 = 0
interior ministry ['Prime Minister of Turkey']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
North Carolina State University ['West Texas A&M University']
em = False, f1 = 0.25
Democratic Party ['NOW – Pilz List']
em = False, f1 = 0
Jeremy Corbyn ['Yahoo']
em = False, f1 = 0
Yvette Cooper ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
England Saxons ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
interior ministry ['chief technology officer']
em = False, f1 = 0
Mainland China ['Regent University']
em = False, f1 = 0
Gruppo Editore Italiana ['RCS MediaGroup']
em = False, f1 = 0
England Saxons ['FC Twente']
em = False, f1 = 0
eská tpán ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
United States Congress ['IT University of Copenhagen']
em = False, f1 = 0
lvaro Cárdenas ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
lvaro Uribe ['Quique Sánchez Flores']
em = False, f1 = 0
interior ministry ['State Secretary']
em = False, f1 = 0
Turin City Council ['Sergio Chiamparino']
em = False, f1 = 0
England and Wales ['FC Gold Pride']
em = False, f1 = 0
SV Werder Bremen ['Netherlands national association football team', 'FC Twente']
em = False, f1 = 0
NBC News ['US Airways']
em = False, f1 = 0
Jeremy Corbyn ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
Electoral Commission ['Stanford University School of Medicine']
em = False, f1 = 0
Jeremy Corbyn ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
England Saxons ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
sgeir stgaard ['Dag-Eilev Fagermo']
em = False, f1 = 0
England and Wales ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
UNESCO ['Agnes Gund']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
20 June 2014 ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Buenos Aires ['Televisión Española']
em = False, f1 = 0
comte d'État ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
Carlton ['Munster Rugby']
em = False, f1 = 0
Nicolás del Ro ['Tibisay Lucena']
em = False, f1 = 0
Democratic Party ["People's Party"]
em = False, f1 = 0.5
Yokohama FC ['Stevenage F.C.']
em = False, f1 = 0.5
Ofcom ['Christopher Poole']
em = False, f1 = 0
interior ministry ['Chief Whip']
em = False, f1 = 0
England Saxons ['Dagenham & Redbridge F.C.']
em = False, f1 = 0
 ['University of Jyväskylä']
em = False, f1 = 0
Christian Democratic Party ['Michel Wolter']
em = False, f1 = 0
United States Department of Justice ['MSNBC']
em = False, f1 = 0
Microsoft Corporation ['Vera Augustin Research']
em = False, f1 = 0
People's Deputy of China ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0.4444444444444445
The Nature Conservancy ['S. I. Newhouse']
em = False, f1 = 0
NBCUniversal ['Rudolf Staechelin']
em = False, f1 = 0
Democratic Party of New York ['Burnet Institute']
em = False, f1 = 0
tefan erban ['Emil Săndoi']
em = False, f1 = 0
Jeremy Corbyn ['Iniva']
em = False, f1 = 0
Yuriy Yeltsin ['Valentina Matviyenko']
em = False, f1 = 0
England Saxons ['Derby County F.C.']
em = False, f1 = 0
Yko Takahashi ['Keiji Yamada']
em = False, f1 = 0
SK Slavia Prague ['Chicago Bulls']
em = False, f1 = 0
England Saxons ['England and Wales cricket team']
em = False, f1 = 0.28571428571428575
Argentinos Juniors ['Middlesbrough F.C.']
em = False, f1 = 0
interior ministry ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0
England Saxons ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
RC Lens ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
United States Congress ["Brigham and Women's Hospital"]
em = False, f1 = 0
interior ministry ['President of Mauritius']
em = False, f1 = 0
Yvette Nicolet ['Harvard Medical School']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Union of Catalonia']
em = False, f1 = 0
Batangas ['Vilma Santos']
em = False, f1 = 0
Russia ['First Quantum Minerals']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Institutional Republican Party']
em = False, f1 = 0.2222222222222222
Democratic Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0.3333333333333333
Democratic Party ['Conservative Party']
em = False, f1 = 0.5
stfold ['Colorado State University']
em = False, f1 = 0
England and Wales ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0.7499999999999999
Yuriy Yushchenko ['Karel Schwarzenberg']
em = False, f1 = 0
United States Senate ['East Carolina Pirates football']
em = False, f1 = 0
interior ministry ['United States representative']
em = False, f1 = 0
interior ministry ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0
Nicolaus Copernicus ['Wolfgang Lück']
em = False, f1 = 0
lvaro Obregón ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
lvaro Cárdena ['Danny De Bie']
em = False, f1 = 0
JS Kabylie ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
Yuriy Kozlov ['Volodymyr Lytvyn']
em = False, f1 = 0
Emmanuel Macron ['Lucette Michaux-Chevry']
em = False, f1 = 0
Party of Regions ['independent politician']
em = False, f1 = 0
University of the West Indies ['The Park School of Buffalo']
em = False, f1 = 0.25
Chief of the Navy ['United States representative']
em = False, f1 = 0
Jeremy Corbyn ['Joe Bossano']
em = False, f1 = 0
interior ministry ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
Party of Regions ['A Just Russia']
em = False, f1 = 0
So Paulo ['Gilberto Kassab']
em = False, f1 = 0
So Paulo ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Party ['Liberty Korea Party']
em = False, f1 = 0.4
Democratic Progressive Party ['New Democratic Party']
em = False, f1 = 0.6666666666666666
England Saxons ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0
Jeremy Corbyn ['University of Connecticut']
em = False, f1 = 0
The Art Institute of Chicago ['Alice Walton']
em = False, f1 = 0
Democratic Party ['Left, Ecology and Freedom']
em = False, f1 = 0
England Saxons ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
stanbul ['Club Brugge K.V.']
em = False, f1 = 0
Kongregate ['GameStop']
em = False, f1 = 0
lvaro Uribe ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
Jeremy Corbyn ['University of Strathclyde']
em = False, f1 = 0
United States Department of Justice ['Washington University in St.\xa0Louis']
em = False, f1 = 0
re Schultz ['Novo Nordisk']
em = False, f1 = 0
FIA ['TF1 Group']
em = False, f1 = 0
Secretary of the Navy ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0.2
Democratic Party ['The People of Freedom']
em = False, f1 = 0
Qatari ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0
interior ministry ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
Secretary of the Navy ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0.5
United States Congress ['United States Department of Justice']
em = False, f1 = 0.5
Democratic Party ['New Democratic Party']
em = False, f1 = 0.8
Party of Regions ['Social Democratic Party']
em = False, f1 = 0.3333333333333333
Conservative Party ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0.3333333333333333
Maurcio Alves ['Yeda Crusius']
em = False, f1 = 0
England Saxons ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0
 ['Harvard University']
em = False, f1 = 0
People's Party for Freedom and Democracy ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.2
Liaoning City Council ['Chen Zhenggao']
em = False, f1 = 0
News Corporation ['Village Voice Media']
em = False, f1 = 0
Yuriy Ivanov ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
England and Wales ['England and Wales cricket team']
em = False, f1 = 0.7499999999999999
guila ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0
interior ministry ['Minister of Defence']
em = False, f1 = 0
Buenos Aires ['RAI']
em = False, f1 = 0
Seanad ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
comte di Stato Italiane ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Saudi Arabia ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
Party of Regions ['Democratic Liberal Party']
em = False, f1 = 0.3333333333333333
Yvette Nicole Brown ['Oregon Ducks']
em = False, f1 = 0
UEFA ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
Yuriy Yuriyev ['Reinoldijus Šarkinas']
em = False, f1 = 0
People's Party of Romania ['Democratic Convergence of Catalonia']
em = False, f1 = 0.25
interior ministry ['dean of Liverpool']
em = False, f1 = 0
Changhua County ['Cho Po-yuan']
em = False, f1 = 0
Media General ['Denison University']
em = False, f1 = 0
Jeremy Corbyn ['Hélène Langevin-Joliot']
em = False, f1 = 0
England and Wales ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
Jeremy Corbyn ['Queens Museum']
em = False, f1 = 0
Buenos Aires ['University of Chile']
em = False, f1 = 0
Darren O'Brien ['Les Miles']
em = False, f1 = 0
Democrat ['Hamilton College', 'Vassar College']
em = False, f1 = 0
Yvette Nicole Brown ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
 ['University of Münster']
em = False, f1 = 0
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
Democratic Party of Norway ['Norwegian Labour Party']
em = False, f1 = 0.28571428571428575
interior ministry ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
UNESCO ['Institute for Advanced Study']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
University of the West Indies ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.5714285714285715
Bangladesh Nationalist Party ['Pakistan Muslim League (Q)']
em = False, f1 = 0
ukasz Kociuszko ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
Secretary of the Navy ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
England Saxons ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
Electoral Commissioner ['United States representative']
em = False, f1 = 0
Buenos Aires ['ETH Zurich']
em = False, f1 = 0
England Saxons ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0
Chief of Staff ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0.18181818181818182
interior ministry ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.25
England and Wales ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0
stanbul ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
Jacques-Louis David ['Jean-Louis Garcia']
em = False, f1 = 0
interior ministry ['White House Chief of Staff']
em = False, f1 = 0
interior ministry ['chairperson']
em = False, f1 = 0
Democratic Party of Lithuania ['SYRIZA']
em = False, f1 = 0
England Saxons ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0.28571428571428575
NBC ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
Chief of the Navy ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0.18181818181818182
interior ministry ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0
interior ministry ['permanent representative of Spain to the European Union']
em = False, f1 = 0
SK Rapid Wien ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Democratic Party of Lithuania ["People's Party"]
em = False, f1 = 0.3333333333333333
Yokohama FC ['Santa Clara Broncos']
em = False, f1 = 0
Jeremy Corbyn ['University College London']
em = False, f1 = 0
comte d'Or ['Secretary for Relations with States']
em = False, f1 = 0
Jeremy Corbyn ['Lunar and Planetary Institute']
em = False, f1 = 0
Yash Raj ['Pakistan national cricket team']
em = False, f1 = 0
Democratic Progressive Party ['Indian National Congress']
em = False, f1 = 0
United States Congress ['University of Southampton']
em = False, f1 = 0
Bergen Commuter Rail ['Norwegian National Rail Administration']
em = False, f1 = 0.28571428571428575
BJP ['University of Arizona']
em = False, f1 = 0
tefan cel Mare ['University of Windsor']
em = False, f1 = 0
Texans ['Rick Perry']
em = False, f1 = 0
Secretary of the Navy ['president']
em = False, f1 = 0
interior ministry ['member of the European Parliament']
em = False, f1 = 0
Jeremy Corbyn ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Honolulu ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Yuriy Yakovlev ['Massachusetts General Hospital']
em = False, f1 = 0
Electoral Commission ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0
Maurizio Bianchi ['Reiner Hollich']
em = False, f1 = 0
Democratic Party ['Republican Party']
em = False, f1 = 0.5
RC Lens ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
lvaro Cárdenas ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
Yuriy Yelchin ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0
lvaro Uribe ['New England Patriots']
em = False, f1 = 0
People's Party of Brazil ['Alternative Democratic Pole']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
England Saxons ['Ineos Grenadier']
em = False, f1 = 0
University of Virginia ['South Garland High School']
em = False, f1 = 0
Chief of the Navy ['White House Cabinet Secretary']
em = False, f1 = 0
Argentinos Juniors ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Kadima']
em = False, f1 = 0
interior ministry ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
Democratic Party ['Socialist Party']
em = False, f1 = 0.5
Party of Regions ['Social Democratic Party']
em = False, f1 = 0.3333333333333333
interior ministry ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
United States Congress ['University of Bath']
em = False, f1 = 0
guila ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0
interior ministry ['Mayor of Tehran']
em = False, f1 = 0
Democratic Party ['Liberal Democratic Party']
em = False, f1 = 0.8
Yuriy Yakovlev ['Osnabrück University']
em = False, f1 = 0
comte d'Etat ['director', 'president']
em = False, f1 = 0
Bangladesh Nationalist Party ['Bahujan Samaj Party']
em = False, f1 = 0.3333333333333333
Serie A ['Leeds United F.C.']
em = False, f1 = 0
Democratic Party ['Democratic Party', 'Union of the Centre']
em = True, f1 = 1.0
lvaro Uribe ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
University of South Korea ['Hanyang University']
em = False, f1 = 0.3333333333333333
Democratic Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0.3333333333333333
lvaro Uribe ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Maurizio Cataldi ['Jürgen Klopp']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
Democratic Party ['Union for a Popular Movement']
em = False, f1 = 0
England and Wales ['Hull City A.F.C.']
em = False, f1 = 0
AQAP ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Yuriy Yakovlev ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
England Saxons ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
Yves Saint-Laurent ['Anni Sinnemäki']
em = False, f1 = 0
 ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
15 June 1894 ['Erasmus University Rotterdam']
em = False, f1 = 0
Yash Chopra ['Mufti Mohammad Sayeed']
em = False, f1 = 0
Jeremy Corbyn ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers Inc. ['Berkshire Hathaway']
em = False, f1 = 0
People's Party of Italy ['Democratic Party']
em = False, f1 = 0.3333333333333333
NBC News ['The Rockefeller University']
em = False, f1 = 0
University of the Netherlands ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.4444444444444444
Accrington Stanley ['Sunderland A.F.C.']
em = False, f1 = 0
Bangladesh Nationalist Party ['Malaysian Islamic Party']
em = False, f1 = 0.3333333333333333
Yves Lehmann ['Florian Pronold']
em = False, f1 = 0
hEoin ['Martin Russell']
em = False, f1 = 0
Party of Regions ['Democratic Liberal Party']
em = False, f1 = 0.3333333333333333
ár nad Labem ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0
Westfield Wheaton ['Westfield Group']
em = False, f1 = 0.5
Yves Saint Laurent ['Freie Universität Berlin']
em = False, f1 = 0
Maurizio Giacometti ['Letizia Moratti']
em = False, f1 = 0
FC Barcelona ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
Granada CF ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0
Secretary of the Navy ['president']
em = False, f1 = 0
United States Department of Energy ['General Services Administration']
em = False, f1 = 0
interior ministry ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
Yokohama ['Kyushu University']
em = False, f1 = 0
UNESCO ['Monash University']
em = False, f1 = 0
United States Senate ['California State University, Monterey Bay']
em = False, f1 = 0
lvaro Cárdenas ['Ernesto Valverde']
em = False, f1 = 0
University of Tehran ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0.15384615384615383
Rio Tinto ['Jan du Plessis']
em = False, f1 = 0
François Mitterrand ['Serge Lepeltier']
em = False, f1 = 0
VP ['Borussia Dortmund']
em = False, f1 = 0
Jacques-Louis David ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
People's Party of China ['Democrats']
em = False, f1 = 0
Argentinos Juniors ['Astana']
em = False, f1 = 0
Secretary of the Navy ['secretary of state']
em = False, f1 = 0.6666666666666666
MIT ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV LLC ['Teracom']
em = False, f1 = 0
Charlotte Hornets LLC ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
FC Barcelona ['Arsenal F.C.']
em = False, f1 = 0.5
SLFP ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0
Argentine Primera B ['Brazil Olympic football team']
em = False, f1 = 0
Silvio Berlusconi ['Luigi Albore Mascia']
em = False, f1 = 0
Judith A. McKay ['John Maeda']
em = False, f1 = 0
Democratic Party ["Conservative People's Party"]
em = False, f1 = 0.4
United States Department of Justice ['Rutgers Scarlet Knights football']
em = False, f1 = 0
Seanad Éireann ['Teachta Dála', 'Minister for Social Protection']
em = False, f1 = 0
CSKA Moscow ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
Yvette Nicolet ['University of Pennsylvania']
em = False, f1 = 0
RC Lens ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
hÉireann ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Darren McKinley ['John Fox']
em = False, f1 = 0
Bangladesh Nationalist Party ['Muttahida Qaumi Movement']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
interior ministry ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0
KS ód ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0
Emmanuel College ['Rowville Secondary College']
em = False, f1 = 0.4
Jeremy Corbyn ['University of Exeter']
em = False, f1 = 0
Yvette Nicolet ['Google']
em = False, f1 = 0
Argentinos Juniors ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0
Welsh Labour ['Dafydd Elis-Thomas']
em = False, f1 = 0
Carlton Football Club ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0.25
Scotland ['Washington Freedom']
em = False, f1 = 0
Boise State ['David H. Bieter']
em = False, f1 = 0
UNESCO ['Trans TV']
em = False, f1 = 0
United States Department of Justice ['bp']
em = False, f1 = 0
Maurizio Giacometti ['Giuseppe Merisi']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Democratic Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.28571428571428575
FIA ['Fiat S.p.A.']
em = False, f1 = 0
UE Lleida ['Real Madrid CF']
em = False, f1 = 0
François Hollande ['Eutelsat']
em = False, f1 = 0
UNESCO ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
FC Barcelona ['Golden State Warriors']
em = False, f1 = 0
Emmanuel College ['St. Xavier High School']
em = False, f1 = 0
NBC News ['Apple Inc.']
em = False, f1 = 0
stgötl ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
interior ministry ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0
SK Rapid Wien ['Arsenal F.C.']
em = False, f1 = 0
interior ministry ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0
interior ministry ['Minister of Children and Family Affairs']
em = False, f1 = 0
Chief of the Navy ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0.16666666666666666
People's Party for Freedom and Democracy ['Authenticity and Modernity Party']
em = False, f1 = 0.4
Pau ['Martine Lignières-Cassou']
em = False, f1 = 0
Yokohama FC ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
Jeremy Corbyn ['University of Bristol']
em = False, f1 = 0
PEN International ['John R. Saul']
em = False, f1 = 0
England ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0
interior ministry ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0
Sahrawi ['Abdelkader Taleb Omar']
em = False, f1 = 0
Conservative Party ['Liberal National Party of Queensland']
em = False, f1 = 0.28571428571428575
Democratic Party ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
Auckland City Council ['Len Brown']
em = False, f1 = 0
UNESCO ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 3: 100%|██████████| 91/91 [00:10<00:00,  9.01it/s, loss=5.61]
                                                            [A
Epoch 3:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.61]         
Epoch 4:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.61]
Epoch 4:   1%|          | 1/91 [00:00<00:40,  2.24it/s, loss=5.61]
Epoch 4:   2%|▏         | 2/91 [00:00<00:22,  4.03it/s, loss=5.61]
Epoch 4:   3%|▎         | 3/91 [00:00<00:17,  5.01it/s, loss=5.39]
Epoch 4:   4%|▍         | 4/91 [00:00<00:14,  6.20it/s, loss=5.39]
Epoch 4:   5%|▌         | 5/91 [00:00<00:11,  7.25it/s, loss=5.39]
Epoch 4:   7%|▋         | 6/91 [00:00<00:11,  7.64it/s, loss=5.2] 
Epoch 4:   8%|▊         | 7/91 [00:00<00:09,  8.40it/s, loss=5.2]
Epoch 4:   9%|▉         | 8/91 [00:00<00:09,  9.10it/s, loss=5.2]
Epoch 4:  10%|▉         | 9/91 [00:01<00:09,  8.71it/s, loss=5.07]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:30,  2.63it/s][A
Epoch 4:  67%|██████▋   | 61/91 [00:01<00:00, 40.61it/s, loss=5.07]
Validating:  76%|███████▌  | 62/82 [00:00<00:00, 167.94it/s][AEngland Saxons ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0
Electoral Commission ['Siumut']
em = False, f1 = 0
interior ministry ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
Democratic Party of Japan ['Democratic Party']
em = False, f1 = 0.6666666666666666
École nationale supérieure des sciences ['INSEP']
em = False, f1 = 0
Capital Region ['Vibeke Storm Rasmussen']
em = False, f1 = 0
interior ministry ['Speaker of the Knesset']
em = False, f1 = 0
Yokohama FC ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0.4
Young Union ['Philipp Mißfelder']
em = False, f1 = 0
Brexit ['University of Sussex']
em = False, f1 = 0
Y Combinator ['Alexander Ivanov']
em = False, f1 = 0
France 3 ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
smet nönü ['Kadir Topbaş']
em = False, f1 = 0
Yuriy Kozlov ['Yuriy Maleyev']
em = False, f1 = 0.5
Argentine Primera B ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0
Party of the Greens ['Andreas Baum']
em = False, f1 = 0
interior ministry ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
Democrat Party ['Centre Party']
em = False, f1 = 0.5
interior ministry ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0
Democratic Party ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0.5
United States of America ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar ['London and Continental Railways']
em = False, f1 = 0
Chartered Accountant ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
England Saxons ['Atlanta Beat']
em = False, f1 = 0
University of Virginia ['Cambridge High School']
em = False, f1 = 0
Drottningholm ['Stefanos Manos']
em = False, f1 = 0
RC Lens ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
United States of America ['Roll Call']
em = False, f1 = 0
England and Wales ['University of Sheffield']
em = False, f1 = 0
Max Planck Society ['Peter Gruss']
em = False, f1 = 0
England Saxons ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0
eljko eljko ['Albin Kurti']
em = False, f1 = 0
England Saxons ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0.28571428571428575
Bangladesh Nationalist Party ['Indian National Congress']
em = False, f1 = 0
Yves Saint Laurent ['Case Western Reserve University']
em = False, f1 = 0
Washington, D.C. ['University of York']
em = False, f1 = 0
University College London ['Stanford University', 'University of California, Los Angeles']
em = False, f1 = 0.4
Washington, D.C. ['University of Michigan']
em = False, f1 = 0
United States Department of Energy ['University of Warwick']
em = False, f1 = 0.25
Darren O'Connor ['Mark McGregor']
em = False, f1 = 0
Washington, D.C. ['Merrill Lynch']
em = False, f1 = 0
interior ministry ['President of the Philippines']
em = False, f1 = 0
Delta ['Daniel Carp']
em = False, f1 = 0
Argentine Primera B ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
FC Pune City ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
IFK Göteborg ['Ineos Grenadier']
em = False, f1 = 0
Xinhua ['Microsoft Corporation']
em = False, f1 = 0
England and Wales ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0.25
Yuriy Yeltsin ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo Corporation ['Beacon Capital Partners']
em = False, f1 = 0
interior ministry ['Vice President of Ghana']
em = False, f1 = 0
Federal Emergency Management Agency ['Craig Fugate']
em = False, f1 = 0
interior ministry ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0
People's Deputy of Singapore ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0.6666666666666665
interior ministry ['general secretary']
em = False, f1 = 0
England Saxons ['Manchester United F.C.']
em = False, f1 = 0
Buenos Aires ['United States Copyright Office']
em = False, f1 = 0
Brexit ['Christian Dior S.A.']
em = False, f1 = 0
Argentine Primera B ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
Washington University ['Regis Jesuit High School']
em = False, f1 = 0
Yves Saint Laurent ['Birkbeck, University of London']
em = False, f1 = 0
Conservative Party ['Democratic Party']
em = False, f1 = 0.5
FC Juventus ['Yamaha Motor Racing']
em = False, f1 = 0
Serbia & Montenegro ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0
England and Wales ['AFC Bournemouth']
em = False, f1 = 0
France 3 ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania State Senate ['Ed Rendell']
em = False, f1 = 0
Sainsbury's ['Justin King']
em = False, f1 = 0
Rally for Freedom and Democracy ['Jean-Marie Le Pen']
em = False, f1 = 0
Mauricio Macri ['Ottmar Hitzfeld']
em = False, f1 = 0
UMNO ['United Malays National Organisation']
em = False, f1 = 0
FC Barcelona ['Scuderia Ferrari']
em = False, f1 = 0
BJP ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape ['AOL']
em = False, f1 = 0
Thierry Henry ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
interior ministry ['President of Zimbabwe']
em = False, f1 = 0
interior ministry ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0
Australia ['Durham University']
em = False, f1 = 0
England and Wales ['University of Cambridge']
em = False, f1 = 0
FC Barcelona ['Blackburn Rovers F.C.']
em = False, f1 = 0.4
England Saxons ['San Diego Padres']
em = False, f1 = 0
England and Wales ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
FC Nantes ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0.4
UMP ['Socialist Party']
em = False, f1 = 0
Yvette Cooper ['Johannes Vogel']
em = False, f1 = 0
Chartered Accountant ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
interior ministry ['state treasurer']
em = False, f1 = 0
Polski ['Donald Tusk']
em = False, f1 = 0
Yokohama FC ['Chelsea F.C.']
em = False, f1 = 0.5
Livorno ['Alessandro Cosimi']
em = False, f1 = 0
Democratic Party ['National Liberal Party']
em = False, f1 = 0.4
UMP ['Horizon Monaco']
em = False, f1 = 0
International Shooting Sport Federation ['Olegario Vázquez Raña']
em = False, f1 = 0
interior ministry ['Prime Minister of Turkey']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
North Carolina State University ['West Texas A&M University']
em = False, f1 = 0.25
Democratic Party ['NOW – Pilz List']
em = False, f1 = 0
Brexit ['Yahoo']
em = False, f1 = 0
Labour Party ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
England Saxons ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
interior ministry ['chief technology officer']
em = False, f1 = 0
UNESCO ['Regent University']
em = False, f1 = 0
Gruppo Fratelli ['RCS MediaGroup']
em = False, f1 = 0
England and Wales ['FC Twente']
em = False, f1 = 0
eljko eljko ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
United States Department of Education ['IT University of Copenhagen']
em = False, f1 = 0.22222222222222224
EEA ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
Cristiano Ronaldo ['Quique Sánchez Flores']
em = False, f1 = 0
interior ministry ['State Secretary']
em = False, f1 = 0
Turin City Council ['Sergio Chiamparino']
em = False, f1 = 0
England and Wales ['FC Gold Pride']
em = False, f1 = 0
SV Werder Bremen ['Netherlands national association football team', 'FC Twente']
em = False, f1 = 0
United States of America ['US Airways']
em = False, f1 = 0
Jeremy Corbyn ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
France 5 ['Stanford University School of Medicine']
em = False, f1 = 0
England & Wales ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
England and Wales ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
Bjrn Bjrnson ['Dag-Eilev Fagermo']
em = False, f1 = 0
England and Wales ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
UNESCO ['Agnes Gund']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
UNESCO ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Buenos Aires ['Televisión Española']
em = False, f1 = 0
interior ministry ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
England and Wales ['Munster Rugby']
em = False, f1 = 0
Nicolás Maduro ['Tibisay Lucena']
em = False, f1 = 0
Christian Democratic Party ["People's Party"]
em = False, f1 = 0.4
England Saxons ['Stevenage F.C.']
em = False, f1 = 0
4chan ['Christopher Poole']
em = False, f1 = 0
interior ministry ['Chief Whip']
em = False, f1 = 0
England Saxons ['Dagenham & Redbridge F.C.']
em = False, f1 = 0
Yuriy Yaroslavl ['University of Jyväskylä']
em = False, f1 = 0
Christian Democratic Party ['Michel Wolter']
em = False, f1 = 0
United States of America ['MSNBC']
em = False, f1 = 0
iCloud ['Vera Augustin Research']
em = False, f1 = 0
People's Deputy of China ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0.4444444444444445
The Nature Conservancy ['S. I. Newhouse']
em = False, f1 = 0
NBCUniversal ['Rudolf Staechelin']
em = False, f1 = 0
Washington, D.C. ['Burnet Institute']
em = False, f1 = 0
tefan tefan ['Emil Săndoi']
em = False, f1 = 0
England and Wales ['Iniva']
em = False, f1 = 0
Yuriy Petrovich Putin ['Valentina Matviyenko']
em = False, f1 = 0
England Saxons ['Derby County F.C.']
em = False, f1 = 0
Kyto City Council ['Keiji Yamada']
em = False, f1 = 0
SK Rapid Wien ['Chicago Bulls']
em = False, f1 = 0
England Saxons ['England and Wales cricket team']
em = False, f1 = 0.28571428571428575
Argentinos Juniors ['Middlesbrough F.C.']
em = False, f1 = 0
interior ministry ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0
England and Wales ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
RC Strasbourg ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
United States Department of Energy ["Brigham and Women's Hospital"]
em = False, f1 = 0
interior ministry ['President of Mauritius']
em = False, f1 = 0
United States of America ['Harvard Medical School']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Union of Catalonia']
em = False, f1 = 0
Batangas Government ['Vilma Santos']
em = False, f1 = 0
Russia ['First Quantum Minerals']
em = False, f1 = 0
Argentine Nationalist Party ['Institutional Republican Party']
em = False, f1 = 0.3333333333333333
UMP ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Labour Party ['Conservative Party']
em = False, f1 = 0.5
UEFA ['Colorado State University']
em = False, f1 = 0
England Saxons ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0.28571428571428575
Yuriy Zhukov ['Karel Schwarzenberg']
em = False, f1 = 0
Brexit ['East Carolina Pirates football']
em = False, f1 = 0
interior ministry ['United States representative']
em = False, f1 = 0
interior ministry ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0
German Mathematical Society ['Wolfgang Lück']
em = False, f1 = 0
England Saxons ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
Mauricio Macri ['Danny De Bie']
em = False, f1 = 0
YES ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
Verkhovna Rada ['Volodymyr Lytvyn']
em = False, f1 = 0
Emmanuel Macron ['Lucette Michaux-Chevry']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
University of the West of Nigeria ['The Park School of Buffalo']
em = False, f1 = 0.22222222222222224
interior ministry ['United States representative']
em = False, f1 = 0
Labour Party ['Joe Bossano']
em = False, f1 = 0
interior ministry ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
CPSU ['A Just Russia']
em = False, f1 = 0
So Paulo ['Gilberto Kassab']
em = False, f1 = 0
So Paulo ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Party ['Liberty Korea Party']
em = False, f1 = 0.4
Democrat Party ['New Democratic Party']
em = False, f1 = 0.4
England Saxons ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0
England & Wales ['University of Connecticut']
em = False, f1 = 0
The Art Institute of Chicago ['Alice Walton']
em = False, f1 = 0
Democratic Party ['Left, Ecology and Freedom']
em = False, f1 = 0
England Saxons ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
Saudi Arabia ['Club Brugge K.V.']
em = False, f1 = 0
Kongregate ['GameStop']
em = False, f1 = 0
Argentinos Juniors ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
England and Wales ['University of Strathclyde']
em = False, f1 = 0
Washington, D.C. ['Washington University in St.\xa0Louis']
em = False, f1 = 0.28571428571428575
stfold ['Novo Nordisk']
em = False, f1 = 0
FIA ['TF1 Group']
em = False, f1 = 0
Democrat ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
Qatari Government ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0
interior ministry ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
interior ministry ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0
United States Department of Education ['United States Department of Justice']
em = False, f1 = 0.8000000000000002
Conservative Party ['New Democratic Party']
em = False, f1 = 0.4
Democratic Party ['Social Democratic Party']
em = False, f1 = 0.8
Labour Party ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0.3333333333333333
Maurcio Alves ['Yeda Crusius']
em = False, f1 = 0
England Saxons ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0
France 5 ['Harvard University']
em = False, f1 = 0
People's Party ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.28571428571428575
Liaoning City Council ['Chen Zhenggao']
em = False, f1 = 0
News Corporation ['Village Voice Media']
em = False, f1 = 0
Symbolic Logic ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
People's Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0
England Saxons ['England and Wales cricket team']
em = False, f1 = 0.28571428571428575
guila ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0
interior ministry ['Minister of Defence']
em = False, f1 = 0
France 3 ['RAI']
em = False, f1 = 0
Elect ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
interior ministry ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
FC Al Jazeera English ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
Democratic Party ['Democratic Liberal Party']
em = False, f1 = 0.8
United States Senate ['Oregon Ducks']
em = False, f1 = 0
France 3 ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
eljko eljko ['Reinoldijus Šarkinas']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
interior ministry ['dean of Liverpool']
em = False, f1 = 0
Changhua City Council ['Cho Po-yuan']
em = False, f1 = 0
Entercom ['Denison University']
em = False, f1 = 0
Jeremy Corbyn ['Hélène Langevin-Joliot']
em = False, f1 = 0
England Saxons ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
England and Wales ['Queens Museum']
em = False, f1 = 0
UNESCO ['University of Chile']
em = False, f1 = 0
LSU ['Les Miles']
em = False, f1 = 0
France 5 ['Hamilton College', 'Vassar College']
em = False, f1 = 0
United States Senate ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
United States of America ['University of Münster']
em = False, f1 = 0.28571428571428575
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
stfold ['Norwegian Labour Party']
em = False, f1 = 0
interior ministry ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
France 2 ['Institute for Advanced Study']
em = False, f1 = 0
Democrat Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0
University of Lagos ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
Bangladesh Nationalist Party ['Pakistan Muslim League (Q)']
em = False, f1 = 0
ukasz Kubot ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
Democrat ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
England Saxons ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
of the People ['United States representative']
em = False, f1 = 0
Colombia ['ETH Zurich']
em = False, f1 = 0
England Saxons ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0
interior ministry ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0
interior ministry ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.25
England Saxons ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0
SK Rapid Wien ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
Jacques-Louis David ['Jean-Louis Garcia']
em = False, f1 = 0
interior ministry ['White House Chief of Staff']
em = False, f1 = 0
interior ministry ['chairperson']
em = False, f1 = 0
Democratic Party of Lithuania ['SYRIZA']
em = False, f1 = 0
England Saxons ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0.28571428571428575
The New York Times ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
Chartered Accountant ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0
interior ministry ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0
interior ministry ['permanent representative of Spain to the European Union']
em = False, f1 = 0
FC Barcelona ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Democratic Party of Lithuania ["People's Party"]
em = False, f1 = 0.3333333333333333
England and Wales ['Santa Clara Broncos']
em = False, f1 = 0
Brexit ['University College London']
em = False, f1 = 0
interior ministry ['Secretary for Relations with States']
em = False, f1 = 0
The Guardian ['Lunar and Planetary Institute']
em = False, f1 = 0
Yokohama FC ['Pakistan national cricket team']
em = False, f1 = 0
Democrat Party ['Indian National Congress']
em = False, f1 = 0
United States Department of Defense ['University of Southampton']
em = False, f1 = 0.25
Bergen Commuter Rail ['Norwegian National Rail Administration']
em = False, f1 = 0.28571428571428575
BJP ['University of Arizona']
em = False, f1 = 0
tefan cel Mare ['University of Windsor']
em = False, f1 = 0
Government of Texas ['Rick Perry']
em = False, f1 = 0
Democrat ['president']
em = False, f1 = 0
interior ministry ['member of the European Parliament']
em = False, f1 = 0
Brexit ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Honolulu Government ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Russia ['Massachusetts General Hospital']
em = False, f1 = 0
United States ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0
Maurizio Bianchi ['Reiner Hollich']
em = False, f1 = 0
Democratic Party ['Republican Party']
em = False, f1 = 0.5
RC Lens ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
RCD ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
UNESCO ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0
FC Dallas ['New England Patriots']
em = False, f1 = 0
Democratic Party ['Alternative Democratic Pole']
em = False, f1 = 0.4
Democratic Party ['The People of Freedom']
em = False, f1 = 0
England Saxons ['Ineos Grenadier']
em = False, f1 = 0
University College London ['South Garland High School']
em = False, f1 = 0
interior ministry ['White House Cabinet Secretary']
em = False, f1 = 0
Argentine Primera B ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
Bangladesh Nationalist Party ['Kadima']
em = False, f1 = 0
interior ministry ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
UMP ['Socialist Party']
em = False, f1 = 0
Democratic Party ['Social Democratic Party']
em = False, f1 = 0.8
interior ministry ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
Washington, D.C. ['University of Bath']
em = False, f1 = 0
FC Porto ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0.5
interior ministry ['Mayor of Tehran']
em = False, f1 = 0
Democratic Party of Japan ['Liberal Democratic Party']
em = False, f1 = 0.5714285714285715
Ukraine ['Osnabrück University']
em = False, f1 = 0
interior ministry ['director', 'president']
em = False, f1 = 0
Bangladesh Nationalist Party ['Bahujan Samaj Party']
em = False, f1 = 0.3333333333333333
Serie A ['Leeds United F.C.']
em = False, f1 = 0
Democratic Party ['Democratic Party', 'Union of the Centre']
em = True, f1 = 1.0
Yokohama FC ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
University of South Korea ['Hanyang University']
em = False, f1 = 0.3333333333333333
Democratic Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0.3333333333333333
Yuriy Kuzmin ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Thierry Henry ['Jürgen Klopp']
em = False, f1 = 0
Conservative Party ['independent politician']
em = False, f1 = 0
UMP ['Union for a Popular Movement']
em = False, f1 = 0
England Saxons ['Hull City A.F.C.']
em = False, f1 = 0
Saudi Arabia ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Russia ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
England Saxons ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
Green Party of Norway ['Anni Sinnemäki']
em = False, f1 = 0
interior ministry ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
University of the Netherlands ['Erasmus University Rotterdam']
em = False, f1 = 0.3333333333333333
Jammu and Kashmir ['Mufti Mohammad Sayeed']
em = False, f1 = 0
Brexit ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers LLC ['Berkshire Hathaway']
em = False, f1 = 0
France 5 ['Democratic Party']
em = False, f1 = 0
United States of America ['The Rockefeller University']
em = False, f1 = 0
University of the Netherlands ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.4444444444444444
England Saxons ['Sunderland A.F.C.']
em = False, f1 = 0
Bangladesh Nationalist Party ['Malaysian Islamic Party']
em = False, f1 = 0.3333333333333333
lvaro Uribe ['Florian Pronold']
em = False, f1 = 0
Darren O'Connor ['Martin Russell']
em = False, f1 = 0
Democratic Party ['Democratic Liberal Party']
em = False, f1 = 0.8
ód University ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0.4
Westfield Wheaton ['Westfield Group']
em = False, f1 = 0.5
Yves Saint Laurent ['Freie Universität Berlin']
em = False, f1 = 0
Maurizio Marchetti ['Letizia Moratti']
em = False, f1 = 0
FC Barcelona ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
England and Wales ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0
Democrat ['president']
em = False, f1 = 0
United States Department of the Treasury ['General Services Administration']
em = False, f1 = 0
interior ministry ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
Yokohama ['Kyushu University']
em = False, f1 = 0
France 5 ['Monash University']
em = False, f1 = 0
Washington, D.C. ['California State University, Monterey Bay']
em = False, f1 = 0
lvaro Cárdenas ['Ernesto Valverde']
em = False, f1 = 0
University of Tehran ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0.15384615384615383
Rio Tinto ['Jan du Plessis']
em = False, f1 = 0
François Mitterrand ['Serge Lepeltier']
em = False, f1 = 0
UEFA ['Borussia Dortmund']
em = False, f1 = 0
Mauricio Macri ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democrats']
em = False, f1 = 0
Argentine Primera B ['Astana']
em = False, f1 = 0
Deputy Chief of Staff ['secretary of state']
em = False, f1 = 0.28571428571428575
MIT ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV ['Teracom']
em = False, f1 = 0
Charlotte Hornets LLC ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
FC Barcelona ['Arsenal F.C.']
em = False, f1 = 0.5
FC Sri Lanka ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0.5
Argentine Primera B ['Brazil Olympic football team']
em = False, f1 = 0
Maurizio Cattaneo ['Luigi Albore Mascia']
em = False, f1 = 0
New York City ['John Maeda']
em = False, f1 = 0
UMP ["Conservative People's Party"]
em = False, f1 = 0
United States of America ['Rutgers Scarlet Knights football']
em = False, f1 = 0
interior ministry ['Teachta Dála', 'Minister for Social Protection']
em = False, f1 = 0
CSKA Sofia ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
Yves Saint Laurent ['University of Pennsylvania']
em = False, f1 = 0
FC Porto ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
England and Wales ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Darren McGrath ['John Fox']
em = False, f1 = 0
Bangladesh Nationalist Party ['Muttahida Qaumi Movement']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
interior ministry ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0
FC Szczecin ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0.5
University College London ['Rowville Secondary College']
em = False, f1 = 0.3333333333333333
England and Wales ['University of Exeter']
em = False, f1 = 0
Mayer ['Google']
em = False, f1 = 0
Argentinos Juniors ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0
Welsh Assembly ['Dafydd Elis-Thomas']
em = False, f1 = 0
England and Wales ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0
England and Wales ['Washington Freedom']
em = False, f1 = 0
Boise City Council ['David H. Bieter']
em = False, f1 = 0
UNESCO ['Trans TV']
em = False, f1 = 0
Washington, D.C. ['bp']
em = False, f1 = 0
Maurizio Cattaneo ['Giuseppe Merisi']
em = False, f1 = 0
People's Party ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Serbian Progressive Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.25
FIA ['Fiat S.p.A.']
em = False, f1 = 0
FC Barcelona ['Real Madrid CF']
em = False, f1 = 0
France 3 ['Eutelsat']
em = False, f1 = 0
France 5 ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
FC Barcelona ['Golden State Warriors']
em = False, f1 = 0
University of Virginia ['St. Xavier High School']
em = False, f1 = 0
United States of America ['Apple Inc.']
em = False, f1 = 0
Regierungspräsident ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
interior ministry ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0
FC Nantes ['Arsenal F.C.']
em = False, f1 = 0.5
interior ministry ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0
interior ministry ['Minister of Children and Family Affairs']
em = False, f1 = 0
interior ministry ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0
UMP ['Authenticity and Modernity Party']
em = False, f1 = 0
Pau ['Martine Lignières-Cassou']
em = False, f1 = 0
Yokohama FC ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
England & Wales ['University of Bristol']
em = False, f1 = 0
PEN International ['John R. Saul']
em = False, f1 = 0
England and Wales ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0
Chartered Accountant ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0
Sahrawi Arab Democratic Republic ['Abdelkader Taleb Omar']
em = False, f1 = 0
Labour Party ['Liberal National Party of Queensland']
em = False, f1 = 0.28571428571428575
United States Department of Justice ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0.22222222222222224
Auckland City Council ['Len Brown']
em = False, f1 = 0
France 5 ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 4: 100%|██████████| 91/91 [00:09<00:00,  9.92it/s, loss=5.07]
                                                            [A
Epoch 4:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.07]         
Epoch 5:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.07]
Epoch 5:   1%|          | 1/91 [00:00<00:39,  2.25it/s, loss=5.07]
Epoch 5:   2%|▏         | 2/91 [00:00<00:22,  4.03it/s, loss=5.07]
Epoch 5:   3%|▎         | 3/91 [00:00<00:17,  5.06it/s, loss=4.9] 
Epoch 5:   4%|▍         | 4/91 [00:00<00:13,  6.26it/s, loss=4.9]
Epoch 5:   5%|▌         | 5/91 [00:00<00:11,  7.30it/s, loss=4.9]
Epoch 5:   7%|▋         | 6/91 [00:00<00:11,  7.67it/s, loss=4.76]
Epoch 5:   8%|▊         | 7/91 [00:00<00:09,  8.45it/s, loss=4.76]
Epoch 5:   9%|▉         | 8/91 [00:00<00:09,  9.16it/s, loss=4.76]
Epoch 5:  10%|▉         | 9/91 [00:01<00:09,  8.75it/s, loss=4.6] 
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:27,  2.96it/s][A
Validating:  37%|███▋      | 30/82 [00:00<00:00, 88.18it/s][A
Epoch 5:  67%|██████▋   | 61/91 [00:01<00:00, 40.55it/s, loss=4.6]Stanford University ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.25
People's Party for Freedom and Democracy ['Siumut']
em = False, f1 = 0
chief executive officer ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
Japan Green Party ['Democratic Party']
em = False, f1 = 0.4
University of Paris ['INSEP']
em = False, f1 = 0
Denmark ['Vibeke Storm Rasmussen']
em = False, f1 = 0
chief executive officer ['Speaker of the Knesset']
em = False, f1 = 0
FC Barcelona B ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0.3333333333333333
Yuriy Kozlov ['Philipp Mißfelder']
em = False, f1 = 0
United States Senate ['University of Sussex']
em = False, f1 = 0
Société Générale ['Alexander Ivanov']
em = False, f1 = 0
France 3 ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
Turkey ['Kadir Topbaş']
em = False, f1 = 0
Yuriy Kozlov ['Yuriy Maleyev']
em = False, f1 = 0.5
FC Barcelona ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0
Germany ['Andreas Baum']
em = False, f1 = 0
People's Deputy of Finland ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Centre Party']
em = False, f1 = 0.25
interior ministry ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0.25
United States Department of Justice ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar ['London and Continental Railways']
em = False, f1 = 0
chief executive officer ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
FC Dallas ['Atlanta Beat']
em = False, f1 = 0
Stanford University ['Cambridge High School']
em = False, f1 = 0
Drottningholm ['Stefanos Manos']
em = False, f1 = 0
FC Nantes ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0.5
The New York Times ['Roll Call']
em = False, f1 = 0
United Kingdom ['University of Sheffield']
em = False, f1 = 0
Max Planck Society ['Peter Gruss']
em = False, f1 = 0
FC Dallas ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0.4
st st ['Albin Kurti']
em = False, f1 = 0
FC Dallas ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0.4
Bangladesh Nationalist Party ['Indian National Congress']
em = False, f1 = 0
France 3 ['Case Western Reserve University']
em = False, f1 = 0
The New York Times ['University of York']
em = False, f1 = 0.3333333333333333
Stanford University ['Stanford University', 'University of California, Los Angeles']
em = True, f1 = 1.0
The New York Times ['University of Michigan']
em = False, f1 = 0
United States Department of Education ['University of Warwick']
em = False, f1 = 0.25
Darren Fletcher ['Mark McGregor']
em = False, f1 = 0
The New York Times ['Merrill Lynch']
em = False, f1 = 0
Member of the Philippines ['President of the Philippines']
em = False, f1 = 0.6666666666666666
U.S. Airways ['Daniel Carp']
em = False, f1 = 0
FC Barcelona ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
S.L. Kerala ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0.4
FC Barcelona ['Ineos Grenadier']
em = False, f1 = 0
People's Television Network ['Microsoft Corporation']
em = False, f1 = 0
Yokohama FC ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0.4
Ukraine ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo ['Beacon Capital Partners']
em = False, f1 = 0
chief executive officer ['Vice President of Ghana']
em = False, f1 = 0
FEMA ['Craig Fugate']
em = False, f1 = 0
chief executive officer ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0
People's Deputy of Singapore ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0.6666666666666665
People's Deputy of Norway ['general secretary']
em = False, f1 = 0
FC Dallas ['Manchester United F.C.']
em = False, f1 = 0.4
France 5 ['United States Copyright Office']
em = False, f1 = 0
United States Department of State ['Christian Dior S.A.']
em = False, f1 = 0
FC Barcelona ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
Stanford University ['Regis Jesuit High School']
em = False, f1 = 0
France 3 ['Birkbeck, University of London']
em = False, f1 = 0
The People of Freedom ['Democratic Party']
em = False, f1 = 0
FC Milan ['Yamaha Motor Racing']
em = False, f1 = 0
S.L. Benfica ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0
FC Dallas ['AFC Bournemouth']
em = False, f1 = 0
France 3 ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania State Senate ['Ed Rendell']
em = False, f1 = 0
Sainsbury's ['Justin King']
em = False, f1 = 0
France 5 ['Jean-Marie Le Pen']
em = False, f1 = 0
Cristiano Ronaldo ['Ottmar Hitzfeld']
em = False, f1 = 0
Malaysian Green Party ['United Malays National Organisation']
em = False, f1 = 0
FC Barcelona ['Scuderia Ferrari']
em = False, f1 = 0
India Today ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape ['AOL']
em = False, f1 = 0
Cristiano Ronaldo ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
chief executive officer ['President of Zimbabwe']
em = False, f1 = 0
People's Deputy of Poland ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0.25
United States Department of State ['Durham University']
em = False, f1 = 0
United States of America ['University of Cambridge']
em = False, f1 = 0.28571428571428575
FC Barcelona ['Blackburn Rovers F.C.']
em = False, f1 = 0.4
FC Dallas ['San Diego Padres']
em = False, f1 = 0
FC Nürnberg ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0.4
FC Nantes ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0.4
People's Party for Freedom and Democracy ['Socialist Party']
em = False, f1 = 0.25
Maya Angelou ['Johannes Vogel']
em = False, f1 = 0
chief executive officer ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
chief executive officer ['state treasurer']
em = False, f1 = 0
Poland ['Donald Tusk']
em = False, f1 = 0
FC Barcelona ['Chelsea F.C.']
em = False, f1 = 0.5
Silvio Berlusconi ['Alessandro Cosimi']
em = False, f1 = 0
Democratic Party ['National Liberal Party']
em = False, f1 = 0.4
People's Party for Freedom and Democracy ['Horizon Monaco']
em = False, f1 = 0
FIFA ['Olegario Vázquez Raña']
em = False, f1 = 0
People's Deputy of Turkey ['Prime Minister of Turkey']
em = False, f1 = 0.5
Christian Democratic Union ['The People of Freedom']
em = False, f1 = 0
North Carolina State University ['West Texas A&M University']
em = False, f1 = 0.25
Democratic Party ['NOW – Pilz List']
em = False, f1 = 0
France 3 ['Yahoo']
em = False, f1 = 0
The People of Freedom ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
FC Barcelona ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
executive Electoral Commissioner ['chief technology officer']
em = False, f1 = 0
China National Petroleum Corporation ['Regent University']
em = False, f1 = 0
Ferrovie dello Stato Italiane ['RCS MediaGroup']
em = False, f1 = 0
FC Barcelona ['FC Twente']
em = False, f1 = 0.5
Czechoslovakia ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
United States Department of Education ['IT University of Copenhagen']
em = False, f1 = 0.22222222222222224
European Commission ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
Cristian Castro ['Quique Sánchez Flores']
em = False, f1 = 0
People's Deputy of Denmark ['State Secretary']
em = False, f1 = 0
Juventus ['Sergio Chiamparino']
em = False, f1 = 0
FC Barcelona ['FC Gold Pride']
em = False, f1 = 0.4
FC Twente ['Netherlands national association football team', 'FC Twente']
em = True, f1 = 1.0
The New York Times ['US Airways']
em = False, f1 = 0
United Kingdom ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
Germany ['Stanford University School of Medicine']
em = False, f1 = 0
United Kingdom ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
FC Barcelona ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
Björn Borg ['Dag-Eilev Fagermo']
em = False, f1 = 0
FC Barcelona ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
People's Party for Freedom and Democracy ['The People of Freedom']
em = False, f1 = 0.2222222222222222
UNESCO ['Agnes Gund']
em = False, f1 = 0
Democratic Party ['The People of Freedom']
em = False, f1 = 0
Greece ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Televisa ['Televisión Española']
em = False, f1 = 0
chief executive officer ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
FC Dallas ['Munster Rugby']
em = False, f1 = 0
Nicolás Maduro ['Tibisay Lucena']
em = False, f1 = 0
The People of Freedom ["People's Party"]
em = False, f1 = 0
FC Dallas ['Stevenage F.C.']
em = False, f1 = 0.5
Telefónica de Chile ['Christopher Poole']
em = False, f1 = 0
chief executive officer ['Chief Whip']
em = False, f1 = 0.4
FC Dallas ['Dagenham & Redbridge F.C.']
em = False, f1 = 0.4
Finland ['University of Jyväskylä']
em = False, f1 = 0
Christian Social People's Party ['Michel Wolter']
em = False, f1 = 0
United States Department of Energy ['MSNBC']
em = False, f1 = 0
Microsoft ['Vera Augustin Research']
em = False, f1 = 0
People's Deputy of China ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0.4444444444444445
The Nature Conservancy ['S. I. Newhouse']
em = False, f1 = 0
NBCUniversal ['Rudolf Staechelin']
em = False, f1 = 0
The New York Times ['Burnet Institute']
em = False, f1 = 0
Cristian Dulca ['Emil Săndoi']
em = False, f1 = 0
France 3 ['Iniva']
em = False, f1 = 0
Russia ['Valentina Matviyenko']
em = False, f1 = 0
FC Dallas ['Derby County F.C.']
em = False, f1 = 0.4
Kyto ['Keiji Yamada']
em = False, f1 = 0
FC Dallas ['Chicago Bulls']
em = False, f1 = 0
FC Dallas ['England and Wales cricket team']
em = False, f1 = 0
FC Barcelona ['Middlesbrough F.C.']
em = False, f1 = 0.5
chief executive officer ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0
FC Dallas ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
FC Nantes ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0.4
The New York Times ["Brigham and Women's Hospital"]
em = False, f1 = 0
chief executive officer ['President of Mauritius']
em = False, f1 = 0
The New York Times ['Harvard Medical School']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Union of Catalonia']
em = False, f1 = 0
Barangay Ginebra ['Vilma Santos']
em = False, f1 = 0
Russia ['First Quantum Minerals']
em = False, f1 = 0
of Spain ['Institutional Republican Party']
em = False, f1 = 0
France 3 ['Democratic Convergence of Catalonia']
em = False, f1 = 0
The People of Freedom ['Conservative Party']
em = False, f1 = 0
Sweden ['Colorado State University']
em = False, f1 = 0
FC Dallas ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0
Yuriy Kozlov ['Karel Schwarzenberg']
em = False, f1 = 0
United States of America ['East Carolina Pirates football']
em = False, f1 = 0
Member of Parliament ['United States representative']
em = False, f1 = 0
People's Deputy of the Philippines ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0.18181818181818182
Nicolaus Copernicus ['Wolfgang Lück']
em = False, f1 = 0
FC Barcelona ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
Cristiano Ronaldo ['Danny De Bie']
em = False, f1 = 0
FC Barcelona B ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0.4
Ukraine ['Volodymyr Lytvyn']
em = False, f1 = 0
France 2 ['Lucette Michaux-Chevry']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
Stanford University ['The Park School of Buffalo']
em = False, f1 = 0
independent independent ['United States representative']
em = False, f1 = 0
Jeremy Corbyn ['Joe Bossano']
em = False, f1 = 0
chief executive officer ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0.4
People's Deputy of Russia ['A Just Russia']
em = False, f1 = 0.3333333333333333
So Paulo ['Gilberto Kassab']
em = False, f1 = 0
So Paulo ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Progressive Party ['Liberty Korea Party']
em = False, f1 = 0.3333333333333333
Parliament of Sri Lanka ['New Democratic Party']
em = False, f1 = 0
FC Dallas ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0.5
United States Air Force ['University of Connecticut']
em = False, f1 = 0
National Portrait Gallery ['Alice Walton']
em = False, f1 = 0
The People of Freedom ['Left, Ecology and Freedom']
em = False, f1 = 0.28571428571428575
FC Barcelona B ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
FC Barcelona ['Club Brugge K.V.']
em = False, f1 = 0
Kongregate ['GameStop']
em = False, f1 = 0
FC Barcelona ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
The New York Times ['University of Strathclyde']
em = False, f1 = 0
Washington, D.C. ['Washington University in St.\xa0Louis']
em = False, f1 = 0.28571428571428575
Germany ['Novo Nordisk']
em = False, f1 = 0
France 3 ['TF1 Group']
em = False, f1 = 0
United States Representative ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0.6666666666666666
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
Qatar ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0
interior ministry ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
independent chief executive officer ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0
The New York Times ['United States Department of Justice']
em = False, f1 = 0
The People of Freedom ['New Democratic Party']
em = False, f1 = 0
Romanian National Party ['Social Democratic Party']
em = False, f1 = 0.3333333333333333
The People of Freedom ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0.28571428571428575
So Paulo ['Yeda Crusius']
em = False, f1 = 0
FC Barcelona ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0.5
France 3 ['Harvard University']
em = False, f1 = 0
European People's Party ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.25
Liaoning City Council ['Chen Zhenggao']
em = False, f1 = 0
Tribune Media ['Village Voice Media']
em = False, f1 = 0.4
Yuriy Ivanovich Ivanov ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
FC Dallas ['England and Wales cricket team']
em = False, f1 = 0
FC Porto ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0.5
chief executive officer ['Minister of Defence']
em = False, f1 = 0
France 5 ['RAI']
em = False, f1 = 0
chief executive officer ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
chief executive officer ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Al Jazeera English ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
Romanian National Party ['Democratic Liberal Party']
em = False, f1 = 0.3333333333333333
United States Department of Justice ['Oregon Ducks']
em = False, f1 = 0
France 3 ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
eljko orevi ['Reinoldijus Šarkinas']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
independent independent ['dean of Liverpool']
em = False, f1 = 0
Changhua County ['Cho Po-yuan']
em = False, f1 = 0
Entercom ['Denison University']
em = False, f1 = 0
Jeremy Corbyn ['Hélène Langevin-Joliot']
em = False, f1 = 0
FC Dallas ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
United States of America ['Queens Museum']
em = False, f1 = 0
Buenos Aires ['University of Chile']
em = False, f1 = 0
Aaron Johnson ['Les Miles']
em = False, f1 = 0
The New York Times ['Hamilton College', 'Vassar College']
em = False, f1 = 0
The New York Times ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
The New York Times ['University of Münster']
em = False, f1 = 0
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
The Greens ['Norwegian Labour Party']
em = False, f1 = 0
People's Deputy of Venezuela ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
France 3 ['Institute for Advanced Study']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
University of Lagos ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
Pakistan People's Party ['Pakistan Muslim League (Q)']
em = False, f1 = 0.28571428571428575
ukasz Kocielny ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
executive executive executive officer ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
FC Dallas ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
chief executive officer ['United States representative']
em = False, f1 = 0
 ['ETH Zurich']
em = False, f1 = 0
S.L. Benfica ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0
chief executive officer ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0
Vice-Chancellor of the Philippines ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.2222222222222222
FC Dallas ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0.4
FC Barcelona ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
Emmanuel Macron ['Jean-Louis Garcia']
em = False, f1 = 0
chief executive officer ['White House Chief of Staff']
em = False, f1 = 0.25
People's Deputy of Finland ['chairperson']
em = False, f1 = 0
Democratic Party ['SYRIZA']
em = False, f1 = 0
FC Barcelona ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0.4
The New York Times ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
chief executive officer ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0
People's Deputy of Colombia ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0.22222222222222224
People's Deputy of Venezuela ['permanent representative of Spain to the European Union']
em = False, f1 = 0.18181818181818182
FC Barcelona ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Lithuanian National Assembly ["People's Party"]
em = False, f1 = 0
FC Barcelona ['Santa Clara Broncos']
em = False, f1 = 0
England and Wales ['University College London']
em = False, f1 = 0
chief executive officer ['Secretary for Relations with States']
em = False, f1 = 0
United Kingdom ['Lunar and Planetary Institute']
em = False, f1 = 0
S.L. Benfica ['Pakistan national cricket team']
em = False, f1 = 0
Tamil Nadu Legislative Assembly ['Indian National Congress']
em = False, f1 = 0
The New York Times ['University of Southampton']
em = False, f1 = 0
Bergen County ['Norwegian National Rail Administration']
em = False, f1 = 0
India Today ['University of Arizona']
em = False, f1 = 0
Romanian Football Federation ['University of Windsor']
em = False, f1 = 0
Texas State Legislature ['Rick Perry']
em = False, f1 = 0
chief executive officer ['president']
em = False, f1 = 0
chief executive officer ['member of the European Parliament']
em = False, f1 = 0
The New York Times ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Hawaii ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Russia ['Massachusetts General Hospital']
em = False, f1 = 0
The People of Freedom ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0.25
Mauritz Schröder ['Reiner Hollich']
em = False, f1 = 0
The People of Freedom ['Republican Party']
em = False, f1 = 0
FC Nantes ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0.5
lvaro Cárdenas ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
Armenian National Committee ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0.28571428571428575
FC Dallas ['New England Patriots']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Alternative Democratic Pole']
em = False, f1 = 0
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
FC Dallas ['Ineos Grenadier']
em = False, f1 = 0
Stanford University ['South Garland High School']
em = False, f1 = 0
chief executive officer ['White House Cabinet Secretary']
em = False, f1 = 0
FC Barcelona ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Kadima']
em = False, f1 = 0
chief executive officer ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
Union for a Popular Movement ['Socialist Party']
em = False, f1 = 0
Romanian People's Party ['Social Democratic Party']
em = False, f1 = 0.3333333333333333
chief executive officer ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
Washington, D.C. ['University of Bath']
em = False, f1 = 0
FC Porto ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0.5
chief executive officer ['Mayor of Tehran']
em = False, f1 = 0
Democratic Party ['Liberal Democratic Party']
em = False, f1 = 0.8
Ukraine ['Osnabrück University']
em = False, f1 = 0
chief executive officer ['director', 'president']
em = False, f1 = 0
Bangladesh Nationalist Party ['Bahujan Samaj Party']
em = False, f1 = 0.3333333333333333
FC Milan ['Leeds United F.C.']
em = False, f1 = 0.4
The People of Freedom ['Democratic Party', 'Union of the Centre']
em = False, f1 = 0.3333333333333333
FC Barcelona ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
University of South Korea ['Hanyang University']
em = False, f1 = 0.3333333333333333
The People of Freedom ['Democratic Convergence of Catalonia']
em = False, f1 = 0.28571428571428575
Nicolás Almagro ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Thierry Henry ['Jürgen Klopp']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
Socialist Party ['Union for a Popular Movement']
em = False, f1 = 0
FC Dallas ['Hull City A.F.C.']
em = False, f1 = 0
S.L. Saadiq ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Russia ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
FC Dallas ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
Green Party of Norway ['Anni Sinnemäki']
em = False, f1 = 0
UMNO ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
University of Amsterdam ['Erasmus University Rotterdam']
em = False, f1 = 0.3333333333333333
BJP ['Mufti Mohammad Sayeed']
em = False, f1 = 0
The New York Times ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers ['Berkshire Hathaway']
em = False, f1 = 0
France 5 ['Democratic Party']
em = False, f1 = 0
The New York Times ['The Rockefeller University']
em = False, f1 = 0
Stanford University ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.5
FC Dallas ['Sunderland A.F.C.']
em = False, f1 = 0
Bangladesh Nationalist Party ['Malaysian Islamic Party']
em = False, f1 = 0.3333333333333333
Andreas Weiss ['Florian Pronold']
em = False, f1 = 0
Sean O'Connor ['Martin Russell']
em = False, f1 = 0
Democratic Party ['Democratic Liberal Party']
em = False, f1 = 0.8
University of Minnesota ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0.6666666666666666
Westfield Wheaton ['Westfield Group']
em = False, f1 = 0.5
Germany ['Freie Universität Berlin']
em = False, f1 = 0
Milan ['Letizia Moratti']
em = False, f1 = 0
FC Barcelona ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
FC Dallas ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0.5
executive Electoral College ['president']
em = False, f1 = 0
United States Steel Corporation ['General Services Administration']
em = False, f1 = 0
chief executive officer ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
Yokohama FC ['Kyushu University']
em = False, f1 = 0
France 3 ['Monash University']
em = False, f1 = 0
The New York Times ['California State University, Monterey Bay']
em = False, f1 = 0
Cristian Castro ['Ernesto Valverde']
em = False, f1 = 0
University of Tehran ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0.15384615384615383
Rio Tinto ['Jan du Plessis']
em = False, f1 = 0
France 2 ['Serge Lepeltier']
em = False, f1 = 0
Germany ['Borussia Dortmund']
em = False, f1 = 0
Nicolas Marais ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
People's Action Party ['Democrats']
em = False, f1 = 0
FC Barcelona ['Astana']
em = False, f1 = 0
Vice-Chancellor of the Philippines ['secretary of state']
em = False, f1 = 0.3333333333333333
Stanford University ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV ['Teracom']
em = False, f1 = 0
Charlotte Hornets ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
FC Barcelona ['Arsenal F.C.']
em = False, f1 = 0.5
S.L. Sabah ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0
FC Barcelona ['Brazil Olympic football team']
em = False, f1 = 0
Silvio Berlusconi ['Luigi Albore Mascia']
em = False, f1 = 0
Judith A. Smith ['John Maeda']
em = False, f1 = 0
European People's Party ["Conservative People's Party"]
em = False, f1 = 0.6666666666666666
The New York Times ['Rutgers Scarlet Knights football']
em = False, f1 = 0
executive officer of Ireland ['Teachta Dála', 'Minister for Social Protection']
em = False, f1 = 0
FC Ararat ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0.4
France 3 ['University of Pennsylvania']
em = False, f1 = 0
FC Barcelona ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
FC Porto ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Christian McKinley ['John Fox']
em = False, f1 = 0
Bangladesh Nationalist Party ['Muttahida Qaumi Movement']
em = False, f1 = 0
Yuriy Zhukov ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
chief executive officer ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0
FC Szczecin ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0.5
Stanford University ['Rowville Secondary College']
em = False, f1 = 0
United States Air Force ['University of Exeter']
em = False, f1 = 0
The New York Times ['Google']
em = False, f1 = 0
FC Barcelona ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0.4
Wales ['Dafydd Elis-Thomas']
em = False, f1 = 0
FC Dallas ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0.5
Australia ['Washington Freedom']
em = False, f1 = 0
Boise City Council ['David H. Bieter']
em = False, f1 = 0
UNESCO ['Trans TV']
em = False, f1 = 0
Washington, D.C. ['bp']
em = False, f1 = 0
Silvio Berlusconi ['Giuseppe Merisi']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Democratic Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.28571428571428575
Ferrari ['Fiat S.p.A.']
em = False, f1 = 0
FC Barcelona ['Real Madrid CF']
em = False, f1 = 0
France 3 ['Eutelsat']
em = False, f1 = 0
France 5 ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
FC Barcelona ['Golden State Warriors']
em = False, f1 = 0
Stanford University ['St. Xavier High School']
em = False, f1 = 0
The New York Times ['Apple Inc.']
em = False, f1 = 0
Germany ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
chief executive officer ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0
FC Nantes ['Arsenal F.C.']
em = False, f1 = 0.5
chief executive officer ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0
People's Deputy of Denmark ['Minister of Children and Family Affairs']
em = False, f1 = 0.2
chief executive officer ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Authenticity and Modernity Party']
em = False, f1 = 0.4
Pau ['Martine Lignières-Cassou']
em = False, f1 = 0
Yokohama FC ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
England and Wales ['University of Bristol']
em = False, f1 = 0
PEN International ['John R. Saul']
em = False, f1 = 0
FC Seoul ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0.5
chief executive officer ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0.2222222222222222
Sahrawi Arab Democratic Republic ['Abdelkader Taleb Omar']
em = False, f1 = 0
The People of Freedom ['Liberal National Party of Queensland']
em = False, f1 = 0.25
The New York Times ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
Auckland City Council ['Len Brown']
em = False, f1 = 0
France 5 ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 5: 100%|██████████| 91/91 [00:09<00:00,  9.25it/s, loss=4.6]
                                                           [A
Epoch 5:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.6]         
Epoch 6:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.6]
Epoch 6:   1%|          | 1/91 [00:00<00:40,  2.23it/s, loss=4.6]
Epoch 6:   2%|▏         | 2/91 [00:00<00:22,  3.98it/s, loss=4.6]
Epoch 6:   3%|▎         | 3/91 [00:00<00:17,  5.01it/s, loss=4.43]
Epoch 6:   4%|▍         | 4/91 [00:00<00:14,  6.20it/s, loss=4.43]
Epoch 6:   5%|▌         | 5/91 [00:00<00:11,  7.24it/s, loss=4.43]
Epoch 6:   7%|▋         | 6/91 [00:00<00:11,  7.62it/s, loss=4.28]
Epoch 6:   8%|▊         | 7/91 [00:00<00:10,  8.39it/s, loss=4.28]
Epoch 6:   9%|▉         | 8/91 [00:00<00:09,  9.10it/s, loss=4.28]
Epoch 6:  10%|▉         | 9/91 [00:01<00:09,  8.71it/s, loss=4.01]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:32,  2.52it/s][A
Epoch 6:  67%|██████▋   | 61/91 [00:01<00:00, 40.20it/s, loss=4.01]
Validating:  76%|███████▌  | 62/82 [00:00<00:00, 163.18it/s][AStanford University ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.25
The People of Freedom ['Siumut']
em = False, f1 = 0
interior ministry ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
France 5 ['INSEP']
em = False, f1 = 0
 ['Vibeke Storm Rasmussen']
em = False, f1 = 0
Vice-President of the Navy ['Speaker of the Knesset']
em = False, f1 = 0.3333333333333333
S.L. Benfica ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0
 ['Philipp Mißfelder']
em = False, f1 = 0
United States of America ['University of Sussex']
em = False, f1 = 0.28571428571428575
S.L. Benfica ['Alexander Ivanov']
em = False, f1 = 0
France 5 ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
ahin ['Kadir Topbaş']
em = False, f1 = 0
Yuriy Davydenko ['Yuriy Maleyev']
em = False, f1 = 0.5
Valencia CF ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0.4
 ['Andreas Baum']
em = False, f1 = 0
Vice-President of Finland ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
People's Party ['Centre Party']
em = False, f1 = 0.5
the People's Deputy of Hungary ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0.25
The People's Party for Freedom and Democracy ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0.25
The New York Times ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar ['London and Continental Railways']
em = False, f1 = 0
in the House of Representatives ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0.22222222222222224
Birmingham City F.C. ['Atlanta Beat']
em = False, f1 = 0
Stanford University ['Cambridge High School']
em = False, f1 = 0
 ['Stefanos Manos']
em = False, f1 = 0
Paris Saint-Germain ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
The New York Times ['Roll Call']
em = False, f1 = 0
United States of America ['University of Sheffield']
em = False, f1 = 0.28571428571428575
 ['Peter Gruss']
em = False, f1 = 0
Birmingham City F.C. ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0.3333333333333333
Yuriy Davydenko ['Albin Kurti']
em = False, f1 = 0
Birmingham City F.C. ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0.3333333333333333
Bangladesh Awami League ['Indian National Congress']
em = False, f1 = 0
United States of America ['Case Western Reserve University']
em = False, f1 = 0
The New York Times ['University of York']
em = False, f1 = 0.3333333333333333
Stanford University ['Stanford University', 'University of California, Los Angeles']
em = True, f1 = 1.0
The New York Times ['University of Michigan']
em = False, f1 = 0
United States Senate ['University of Warwick']
em = False, f1 = 0
Cristiano Ronaldo ['Mark McGregor']
em = False, f1 = 0
The New York Times ['Merrill Lynch']
em = False, f1 = 0
politician ['President of the Philippines']
em = False, f1 = 0
Michael Bloomberg ['Daniel Carp']
em = False, f1 = 0
Valencia CF ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
S.L. Benfica ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
IF Elfsborg ['Ineos Grenadier']
em = False, f1 = 0
Weibo ['Microsoft Corporation']
em = False, f1 = 0
Birmingham City F.C. ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0.3333333333333333
 ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo ['Beacon Capital Partners']
em = False, f1 = 0
 ['Vice President of Ghana']
em = False, f1 = 0
 ['Craig Fugate']
em = False, f1 = 0
 ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0
chief executive officer ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0
Vice-President of Norway ['general secretary']
em = False, f1 = 0
Birmingham City F.C. ['Manchester United F.C.']
em = False, f1 = 0.3333333333333333
France 5 ['United States Copyright Office']
em = False, f1 = 0
United States Senate ['Christian Dior S.A.']
em = False, f1 = 0
S.L. Benfica ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
Stanford University ['Regis Jesuit High School']
em = False, f1 = 0
S.L.A. ['Birkbeck, University of London']
em = False, f1 = 0
The People of Freedom ['Democratic Party']
em = False, f1 = 0
S.L. Benfica ['Yamaha Motor Racing']
em = False, f1 = 0
S.L. Milan ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0.4
Birmingham City F.C. ['AFC Bournemouth']
em = False, f1 = 0
Germany ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania State Senate ['Ed Rendell']
em = False, f1 = 0
David Cameron ['Justin King']
em = False, f1 = 0
France 5 ['Jean-Marie Le Pen']
em = False, f1 = 0
 ['Ottmar Hitzfeld']
em = False, f1 = 0
Malaysian Greens ['United Malays National Organisation']
em = False, f1 = 0
Valencia CF ['Scuderia Ferrari']
em = False, f1 = 0
United Arab Emirates ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape Communications ['AOL']
em = False, f1 = 0
Cristiano Ronaldo ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
interior ministry ['President of Zimbabwe']
em = False, f1 = 0
of Poland ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0.3333333333333333
United States Senate ['Durham University']
em = False, f1 = 0
United Kingdom ['University of Cambridge']
em = False, f1 = 0
Al Jazeera English ['Blackburn Rovers F.C.']
em = False, f1 = 0
Birmingham City F.C. ['San Diego Padres']
em = False, f1 = 0
S.L. Benfica ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
Paris Saint-Germain ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0
France 5 ['Socialist Party']
em = False, f1 = 0
David Cameron ['Johannes Vogel']
em = False, f1 = 0
Vice-President of the European Commission ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
 ['state treasurer']
em = False, f1 = 0
Poland ['Donald Tusk']
em = False, f1 = 0
Beerschot AC ['Chelsea F.C.']
em = False, f1 = 0
Silvio Berlusconi ['Alessandro Cosimi']
em = False, f1 = 0
Democratic Convergence of Catalonia ['National Liberal Party']
em = False, f1 = 0
The People of Freedom ['Horizon Monaco']
em = False, f1 = 0
 ['Olegario Vázquez Raña']
em = False, f1 = 0
 ['Prime Minister of Turkey']
em = False, f1 = 0
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
North Carolina State University ['West Texas A&M University']
em = False, f1 = 0.25
Democratic Party ['NOW – Pilz List']
em = False, f1 = 0
United States of America ['Yahoo']
em = False, f1 = 0
United States of America ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
S.L. Benfica ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
Vice-President of the European Commission ['chief technology officer']
em = False, f1 = 0
The People of Freedom ['Regent University']
em = False, f1 = 0
Ferrovie dello Stato Italiane ['RCS MediaGroup']
em = False, f1 = 0
Birmingham City F.C. ['FC Twente']
em = False, f1 = 0.4
 ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
United States Department of Education ['IT University of Copenhagen']
em = False, f1 = 0.22222222222222224
France 5 ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
Cristiano Ronaldo ['Quique Sánchez Flores']
em = False, f1 = 0
interior ministry ['State Secretary']
em = False, f1 = 0
Silvio Berlusconi ['Sergio Chiamparino']
em = False, f1 = 0
S.L. Benfica ['FC Gold Pride']
em = False, f1 = 0
S.L. Benfica ['Netherlands national association football team', 'FC Twente']
em = False, f1 = 0
The New York Times ['US Airways']
em = False, f1 = 0
United States Senate ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
France 5 ['Stanford University School of Medicine']
em = False, f1 = 0
United States of America ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
Birmingham City F.C. ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Grupo Panamericano ['Silvio Santos']
em = False, f1 = 0
 ['Dag-Eilev Fagermo']
em = False, f1 = 0
S.L. Benfica ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
The Walt Disney Company ['Agnes Gund']
em = False, f1 = 0
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
online ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
Televisa ['Televisión Española']
em = False, f1 = 0
interior ministry ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
Birmingham City F.C. ['Munster Rugby']
em = False, f1 = 0
Nicolás Maduro ['Tibisay Lucena']
em = False, f1 = 0
The People of Freedom ["People's Party"]
em = False, f1 = 0
S.L. Benfica ['Stevenage F.C.']
em = False, f1 = 0
Ofcom ['Christopher Poole']
em = False, f1 = 0
Vice-President of the World ['Chief Whip']
em = False, f1 = 0
Birmingham City F.C. ['Dagenham & Redbridge F.C.']
em = False, f1 = 0.3333333333333333
Finland ['University of Jyväskylä']
em = False, f1 = 0
France 5 ['Michel Wolter']
em = False, f1 = 0
United States of America ['MSNBC']
em = False, f1 = 0
.com ['Vera Augustin Research']
em = False, f1 = 0
chief executive officer ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0
The Coca-Cola Company ['S. I. Newhouse']
em = False, f1 = 0
The Coca-Cola Company ['Rudolf Staechelin']
em = False, f1 = 0
The New York Times ['Burnet Institute']
em = False, f1 = 0
Cristian Dulca ['Emil Săndoi']
em = False, f1 = 0
United States of America ['Iniva']
em = False, f1 = 0
Yuriy Davydenko ['Valentina Matviyenko']
em = False, f1 = 0
Birmingham City F.C. ['Derby County F.C.']
em = False, f1 = 0.3333333333333333
Shinzo Abe ['Keiji Yamada']
em = False, f1 = 0
S.L. Benfica ['Chicago Bulls']
em = False, f1 = 0
Birmingham City F.C. ['England and Wales cricket team']
em = False, f1 = 0
Valencia CF ['Middlesbrough F.C.']
em = False, f1 = 0
Vice-President of the European Commission ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0.2
Birmingham City F.C. ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
Paris Saint-Germain ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
The New York Times ["Brigham and Women's Hospital"]
em = False, f1 = 0
interior ministry ['President of Mauritius']
em = False, f1 = 0
United States Senate ['Harvard Medical School']
em = False, f1 = 0
The People of Freedom ['Democratic Union of Catalonia']
em = False, f1 = 0.28571428571428575
Carlos Menem ['Vilma Santos']
em = False, f1 = 0
Russia ['First Quantum Minerals']
em = False, f1 = 0
The People of Freedom ['Institutional Republican Party']
em = False, f1 = 0
France 5 ['Democratic Convergence of Catalonia']
em = False, f1 = 0
United States Senate ['Conservative Party']
em = False, f1 = 0
United States of America ['Colorado State University']
em = False, f1 = 0
Birmingham City F.C. ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0
Yves Saint Laurent ['Karel Schwarzenberg']
em = False, f1 = 0
United States of America ['East Carolina Pirates football']
em = False, f1 = 0
interior ministry ['United States representative']
em = False, f1 = 0
of New York City ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0.18181818181818182
Germany ['Wolfgang Lück']
em = False, f1 = 0
S.L. Benfica ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
Cristian Castro ['Danny De Bie']
em = False, f1 = 0
S.L. Milan ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
 ['Volodymyr Lytvyn']
em = False, f1 = 0
France 5 ['Lucette Michaux-Chevry']
em = False, f1 = 0
Democratic Union ['independent politician']
em = False, f1 = 0
Stanford University ['The Park School of Buffalo']
em = False, f1 = 0
 ['United States representative']
em = False, f1 = 0
France 5 ['Joe Bossano']
em = False, f1 = 0
 ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
Ukraine ['A Just Russia']
em = False, f1 = 0
S. Paulo ['Gilberto Kassab']
em = False, f1 = 0
S. Paulo ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Party ['Liberty Korea Party']
em = False, f1 = 0.4
Parliament of India ['New Democratic Party']
em = False, f1 = 0
Birmingham City F.C. ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0.4
United States of America ['University of Connecticut']
em = False, f1 = 0.28571428571428575
University of Virginia ['Alice Walton']
em = False, f1 = 0
The People of Freedom ['Left, Ecology and Freedom']
em = False, f1 = 0.28571428571428575
Birmingham City F.C. ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
S.L. Benfica ['Club Brugge K.V.']
em = False, f1 = 0
Kongregat ['GameStop']
em = False, f1 = 0
S.L. Benfica ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
United States Senate ['University of Strathclyde']
em = False, f1 = 0
United States Department of Justice ['Washington University in St.\xa0Louis']
em = False, f1 = 0
S.L. Benfica ['Novo Nordisk']
em = False, f1 = 0
FIA ['TF1 Group']
em = False, f1 = 0
United States Attorney ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0.6666666666666666
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
Qatari Government ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0
of Serbia ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
 ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0
United States Department of Education ['United States Department of Justice']
em = False, f1 = 0.8000000000000002
The People of Freedom ['New Democratic Party']
em = False, f1 = 0
Democratic Convergence of Catalonia ['Social Democratic Party']
em = False, f1 = 0.28571428571428575
The People of Freedom ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0.28571428571428575
Sérgio Mendes ['Yeda Crusius']
em = False, f1 = 0
Birmingham City F.C. ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0.6666666666666666
France 5 ['Harvard University']
em = False, f1 = 0
France 5 ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0
Liaoning ['Chen Zhenggao']
em = False, f1 = 0
Los Angeles Times ['Village Voice Media']
em = False, f1 = 0
Yuriy Ivanov ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
The People of Freedom ['Democratic Convergence of Catalonia']
em = False, f1 = 0.28571428571428575
Birmingham City F.C. ['England and Wales cricket team']
em = False, f1 = 0
Benfica ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0
interior ministry ['Minister of Defence']
em = False, f1 = 0
France 5 ['RAI']
em = False, f1 = 0
Vice-President of the Philippines ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
Vice-President of the European Commission ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Al-Ahly ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
Democratic Union ['Democratic Liberal Party']
em = False, f1 = 0.4
United States Department of Justice ['Oregon Ducks']
em = False, f1 = 0
France 5 ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
Yuriy Yuriyev ['Reinoldijus Šarkinas']
em = False, f1 = 0
The People of Freedom ['Democratic Convergence of Catalonia']
em = False, f1 = 0.28571428571428575
Vice-President of the Navy ['dean of Liverpool']
em = False, f1 = 0.3333333333333333
Changhua County ['Cho Po-yuan']
em = False, f1 = 0
Entercom ['Denison University']
em = False, f1 = 0
David Cameron ['Hélène Langevin-Joliot']
em = False, f1 = 0
Birmingham City F.C. ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
United States of America ['Queens Museum']
em = False, f1 = 0
France 5 ['University of Chile']
em = False, f1 = 0
Ben Hodges ['Les Miles']
em = False, f1 = 0
United States of America ['Hamilton College', 'Vassar College']
em = False, f1 = 0
The New York Times ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
United States of America ['University of Münster']
em = False, f1 = 0.28571428571428575
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
People's Party ['Norwegian Labour Party']
em = False, f1 = 0.4
in Canada ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0
France 5 ['Institute for Advanced Study']
em = False, f1 = 0
The People of Freedom ['Democratic Convergence of Catalonia']
em = False, f1 = 0.28571428571428575
University of Otago ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
Bangladesh Awami League ['Pakistan Muslim League (Q)']
em = False, f1 = 0.28571428571428575
Mariusz Fyrstenberg ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
Democrat ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
Birmingham City F.C. ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
United States Attorney ['United States representative']
em = False, f1 = 0.6666666666666666
ONO ['ETH Zurich']
em = False, f1 = 0
Birmingham City F.C. ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0.6666666666666666
Vice-President of the Navy ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0.18181818181818182
Vice-President of the Philippines ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.2222222222222222
Birmingham City F.C. ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0.6666666666666666
SK Rapid Wien ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
France 5 ['Jean-Louis Garcia']
em = False, f1 = 0
interior ministry ['White House Chief of Staff']
em = False, f1 = 0
 ['chairperson']
em = False, f1 = 0
Democratic Workers' Party ['SYRIZA']
em = False, f1 = 0
United States of America ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0
Los Angeles Angels ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
 ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0
Vice-President of the Philippines ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0.25
of the Philippines ['permanent representative of Spain to the European Union']
em = False, f1 = 0.22222222222222224
Toronto Raptors ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Lithuanian Parliament ["People's Party"]
em = False, f1 = 0
Toronto Raptors ['Santa Clara Broncos']
em = False, f1 = 0
England and Wales Cricket Board ['University College London']
em = False, f1 = 0
interior ministry ['Secretary for Relations with States']
em = False, f1 = 0
United Kingdom ['Lunar and Planetary Institute']
em = False, f1 = 0
S.L. Saab ['Pakistan national cricket team']
em = False, f1 = 0
 ['Indian National Congress']
em = False, f1 = 0
United States Department of Education ['University of Southampton']
em = False, f1 = 0.25
Norges Statsbaner ['Norwegian National Rail Administration']
em = False, f1 = 0
United Arab Emirates ['University of Arizona']
em = False, f1 = 0
Romania ['University of Windsor']
em = False, f1 = 0
Carlos Menem ['Rick Perry']
em = False, f1 = 0
 ['president']
em = False, f1 = 0
 ['member of the European Parliament']
em = False, f1 = 0
United States Senate ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Honolulu ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Russia Today ['Massachusetts General Hospital']
em = False, f1 = 0
United States of America ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0.22222222222222224
Christian Schäfer ['Reiner Hollich']
em = False, f1 = 0
The People of Freedom ['Republican Party']
em = False, f1 = 0
RC Lens ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
Carlos Menem ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
United States of America ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0.25
Birmingham City F.C. ['New England Patriots']
em = False, f1 = 0
The People of Freedom ['Alternative Democratic Pole']
em = False, f1 = 0
The People of Freedom ['The People of Freedom']
em = True, f1 = 1.0
Birmingham City F.C. ['Ineos Grenadier']
em = False, f1 = 0
Stanford University ['South Garland High School']
em = False, f1 = 0
 ['White House Cabinet Secretary']
em = False, f1 = 0
Valencia CF ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
United States Senate ['Kadima']
em = False, f1 = 0
 ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
France 5 ['Socialist Party']
em = False, f1 = 0
Democratic Convergence of Catalonia ['Social Democratic Party']
em = False, f1 = 0.28571428571428575
interior ministry ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
The New York Times ['University of Bath']
em = False, f1 = 0
Benfica ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0
 ['Mayor of Tehran']
em = False, f1 = 0
Democratic Party ['Liberal Democratic Party']
em = False, f1 = 0.8
Football League ['Osnabrück University']
em = False, f1 = 0
interior ministry ['director', 'president']
em = False, f1 = 0
Bangladesh Awami League ['Bahujan Samaj Party']
em = False, f1 = 0
Benfica ['Leeds United F.C.']
em = False, f1 = 0
The People of Freedom ['Democratic Party', 'Union of the Centre']
em = False, f1 = 0.3333333333333333
S.L. Benfica ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
University of South Korea ['Hanyang University']
em = False, f1 = 0.3333333333333333
The People of Freedom ['Democratic Convergence of Catalonia']
em = False, f1 = 0.28571428571428575
Cristian Dulca ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
 ['Jürgen Klopp']
em = False, f1 = 0
The People of Freedom ['independent politician']
em = False, f1 = 0
France 5 ['Union for a Popular Movement']
em = False, f1 = 0
Birmingham City F.C. ['Hull City A.F.C.']
em = False, f1 = 0.3333333333333333
S.L. Benfica ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Russia ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
Birmingham City F.C. ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
 ['Anni Sinnemäki']
em = False, f1 = 0
S.L. Benfica ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
Stanford University ['Erasmus University Rotterdam']
em = False, f1 = 0.4
 ['Mufti Mohammad Sayeed']
em = False, f1 = 0
United States Senate ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0
Hickory Newspapers ['Berkshire Hathaway']
em = False, f1 = 0
The People of Freedom ['Democratic Party']
em = False, f1 = 0
The New York Times ['The Rockefeller University']
em = False, f1 = 0
Stanford University ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.5
Birmingham City F.C. ['Sunderland A.F.C.']
em = False, f1 = 0
Bangladesh Awami League ['Malaysian Islamic Party']
em = False, f1 = 0
Christian X ['Florian Pronold']
em = False, f1 = 0
UCD ['Martin Russell']
em = False, f1 = 0
Democratic Convergence of Catalonia ['Democratic Liberal Party']
em = False, f1 = 0.28571428571428575
Stanford University ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0.4
Wheaton, Inc. ['Westfield Group']
em = False, f1 = 0
France 5 ['Freie Universität Berlin']
em = False, f1 = 0
Silvio Berlusconi ['Letizia Moratti']
em = False, f1 = 0
Valencia CF ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
Toronto Raptors ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0
Vice-President of the Philippines ['president']
em = False, f1 = 0
United States Steel Corporation ['General Services Administration']
em = False, f1 = 0
interior ministry ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
The People of Freedom ['Kyushu University']
em = False, f1 = 0
France 5 ['Monash University']
em = False, f1 = 0
The New York Times ['California State University, Monterey Bay']
em = False, f1 = 0
Cristian Dulca ['Ernesto Valverde']
em = False, f1 = 0
Istanbul University ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0
Benfica ['Jan du Plessis']
em = False, f1 = 0
France 5 ['Serge Lepeltier']
em = False, f1 = 0
Germany ['Borussia Dortmund']
em = False, f1 = 0
 ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
The People of Freedom ['Democrats']
em = False, f1 = 0
Valencia CF ['Astana']
em = False, f1 = 0
of New York City ['secretary of state']
em = False, f1 = 0.28571428571428575
Stanford University ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV ['Teracom']
em = False, f1 = 0
Charlotte Hornets ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
Barcelona B ['Arsenal F.C.']
em = False, f1 = 0
S.L. Benfica ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0
S.L. Benfica ['Brazil Olympic football team']
em = False, f1 = 0
Francesco Sforza ['Luigi Albore Mascia']
em = False, f1 = 0
Michael C. Smith ['John Maeda']
em = False, f1 = 0
France 5 ["Conservative People's Party"]
em = False, f1 = 0
United States Department of State ['Rutgers Scarlet Knights football']
em = False, f1 = 0
Teachta Dála ['Teachta Dála', 'Minister for Social Protection']
em = True, f1 = 1.0
France 5 ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
United States of America ['University of Pennsylvania']
em = False, f1 = 0.28571428571428575
Valencia CF ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
Toronto Raptors ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Mike Wallace ['John Fox']
em = False, f1 = 0
Bangladesh Awami League ['Muttahida Qaumi Movement']
em = False, f1 = 0
 ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
Vice-President of India ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0.3333333333333333
Wolverhampton Wanderers ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0
Stanford University ['Rowville Secondary College']
em = False, f1 = 0
England and Wales Cricket Board ['University of Exeter']
em = False, f1 = 0
United States of America ['Google']
em = False, f1 = 0
Valencia CF ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0
Wales ['Dafydd Elis-Thomas']
em = False, f1 = 0
Toronto Raptors ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0
Birmingham City F.C. ['Washington Freedom']
em = False, f1 = 0
 ['David H. Bieter']
em = False, f1 = 0
The People of Freedom ['Trans TV']
em = False, f1 = 0
The New York Times ['bp']
em = False, f1 = 0
Silvio Berlusconi ['Giuseppe Merisi']
em = False, f1 = 0
The People of Freedom ['Democratic Convergence of Catalonia']
em = False, f1 = 0.28571428571428575
Democratic Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.28571428571428575
Vicenza ['Fiat S.p.A.']
em = False, f1 = 0
Valencia CF ['Real Madrid CF']
em = False, f1 = 0.4
France 5 ['Eutelsat']
em = False, f1 = 0
Vicenza ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
Valencia CF ['Golden State Warriors']
em = False, f1 = 0
Stanford University ['St. Xavier High School']
em = False, f1 = 0
Toronto Raptors ['Apple Inc.']
em = False, f1 = 0
Germany ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
Vice-President of the European Commission ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0.2
Olympique Lyonnais ['Arsenal F.C.']
em = False, f1 = 0
 ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0
interior ministry ['Minister of Children and Family Affairs']
em = False, f1 = 0
chief executive officer ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0
France 5 ['Authenticity and Modernity Party']
em = False, f1 = 0
France 5 ['Martine Lignières-Cassou']
em = False, f1 = 0
S.L. Benfica ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
England and Wales Cricket Board ['University of Bristol']
em = False, f1 = 0
PEN ['John R. Saul']
em = False, f1 = 0
Toronto Raptors ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0
interior ministry ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0
 ['Abdelkader Taleb Omar']
em = False, f1 = 0
The People of Freedom ['Liberal National Party of Queensland']
em = False, f1 = 0.25
The New York Times ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
 ['Len Brown']
em = False, f1 = 0
Vicenza ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 6: 100%|██████████| 91/91 [00:12<00:00,  7.05it/s, loss=4.01]
                                                            [A
Epoch 6:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.01]         
Epoch 7:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.01]
Epoch 7:   1%|          | 1/91 [00:00<00:42,  2.10it/s, loss=4.01]
Epoch 7:   2%|▏         | 2/91 [00:00<00:23,  3.84it/s, loss=4.01]
Epoch 7:   3%|▎         | 3/91 [00:00<00:18,  4.83it/s, loss=3.75]
Epoch 7:   4%|▍         | 4/91 [00:00<00:14,  5.99it/s, loss=3.75]
Epoch 7:   5%|▌         | 5/91 [00:00<00:12,  7.02it/s, loss=3.75]
Epoch 7:   7%|▋         | 6/91 [00:00<00:11,  7.43it/s, loss=3.43]
Epoch 7:   8%|▊         | 7/91 [00:00<00:10,  8.19it/s, loss=3.43]
Epoch 7:   9%|▉         | 8/91 [00:00<00:09,  8.89it/s, loss=3.43]
Epoch 7:  10%|▉         | 9/91 [00:01<00:09,  8.55it/s, loss=3.16]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:34,  2.36it/s][A
Epoch 7:  67%|██████▋   | 61/91 [00:01<00:00, 38.93it/s, loss=3.16]
Validating:  73%|███████▎  | 60/82 [00:00<00:00, 150.64it/s][AStanford University ['University of Washington School of Law', 'University of Washington College of Education']
em = False, f1 = 0.25
Democratic Party ['Siumut']
em = False, f1 = 0
chief executive officer ['Minister for Foreign Affairs', 'Minister of Land, Infrastructure, Transport and Tourism']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
France 5 ['INSEP']
em = False, f1 = 0
 ['Vibeke Storm Rasmussen']
em = False, f1 = 0
chief executive officer ['Speaker of the Knesset']
em = False, f1 = 0
S.L. Benfica ['Milton Keynes Dons F.C.', 'Stockport County F.C.']
em = False, f1 = 0
Yuriy Davydenko ['Philipp Mißfelder']
em = False, f1 = 0
France 5 ['University of Sussex']
em = False, f1 = 0
S.L. Benfica ['Alexander Ivanov']
em = False, f1 = 0
France 5 ['University of Minnesota', 'Rutgers University']
em = False, f1 = 0
 ['Kadir Topbaş']
em = False, f1 = 0
Yuriy Krot ['Yuriy Maleyev']
em = False, f1 = 0.5
Valencia CF ['Real Madrid Castilla', 'Spain national under-18 football team', 'Real Madrid CF', 'Spain national under-19 football team']
em = False, f1 = 0.4
 ['Andreas Baum']
em = False, f1 = 0
Vice-President of Finland ['Minister for European Affairs and Foreign Trade']
em = False, f1 = 0
Democratic Party ['Centre Party']
em = False, f1 = 0.5
Vice-President of Hungary ['member of the European Parliament', 'Vice President of the European Parliament']
em = False, f1 = 0.28571428571428575
Democratic Convergence of Catalonia ['Labour Party', 'Labour Co-operative']
em = False, f1 = 0
Vice-President of the Philippines ['Cornell University', 'Case Western Reserve University']
em = False, f1 = 0
Eurostar ['London and Continental Railways']
em = False, f1 = 0
chief executive officer ['Secretary of State for Defence', 'Shadow Secretary of State for Defence']
em = False, f1 = 0
Birmingham City F.C. ['Atlanta Beat']
em = False, f1 = 0
Stanford University ['Cambridge High School']
em = False, f1 = 0
Dmitri Dmitrievich ['Stefanos Manos']
em = False, f1 = 0
France 5 ['Tours FC.', 'Montpellier Hérault Sport Club']
em = False, f1 = 0
United States Department of Justice ['Roll Call']
em = False, f1 = 0
United States of America ['University of Sheffield']
em = False, f1 = 0.28571428571428575
Germany ['Peter Gruss']
em = False, f1 = 0
Toronto Raptors ['Wales national association football team', 'Nottingham Forest F.C.']
em = False, f1 = 0
Yuriy Krot ['Albin Kurti']
em = False, f1 = 0
Leicester City F.C. ['Tottenham Hotspur F.C.', 'England national association football team']
em = False, f1 = 0.3333333333333333
Democratic Party ['Indian National Congress']
em = False, f1 = 0
France 5 ['Case Western Reserve University']
em = False, f1 = 0
The New York Times ['University of York']
em = False, f1 = 0.3333333333333333
Stanford University ['Stanford University', 'University of California, Los Angeles']
em = True, f1 = 1.0
United States Department of Education ['University of Michigan']
em = False, f1 = 0.25
United States Department of Education ['University of Warwick']
em = False, f1 = 0.25
S.L. Lawrence ['Mark McGregor']
em = False, f1 = 0
United States Department of Education ['Merrill Lynch']
em = False, f1 = 0
Vice-President of the Philippines ['President of the Philippines']
em = False, f1 = 0.6666666666666666
 ['Daniel Carp']
em = False, f1 = 0
Olympique Lyonnais ['Club Universidad de Chile', 'Club de Deportes La Serena']
em = False, f1 = 0
S.L. Rajapaksa ['India national cricket team', 'Kings XI Punjab', 'Kerala cricket team']
em = False, f1 = 0
Al Jazeera English ['Ineos Grenadier']
em = False, f1 = 0
Zhejiang University ['Microsoft Corporation']
em = False, f1 = 0
Birmingham City F.C. ['Wales national association football team', 'Sheffield United F.C.']
em = False, f1 = 0.3333333333333333
Ukraine ['Ihor Ostash']
em = False, f1 = 0
Wells Fargo ['Beacon Capital Partners']
em = False, f1 = 0
chief executive officer ['Vice President of Ghana']
em = False, f1 = 0
Mauricio Macri ['Craig Fugate']
em = False, f1 = 0
chief executive officer ['Secretary of State for International Development', 'Shadow Secretary of State for International Development']
em = False, f1 = 0
Vice-President of Singapore ['Minister for Home Affairs', 'Deputy Prime Minister of Singapore', 'Co-ordinating Minister for National Security']
em = False, f1 = 0.5
Vice-President of Norway ['general secretary']
em = False, f1 = 0
Birmingham City F.C. ['Manchester United F.C.']
em = False, f1 = 0.3333333333333333
France 5 ['United States Copyright Office']
em = False, f1 = 0
France 5 ['Christian Dior S.A.']
em = False, f1 = 0
S.L. Benfica ['Rubin Kazan', 'TSG 1899 Hoffenheim', 'Brazil national football team']
em = False, f1 = 0
Stanford University ['Regis Jesuit High School']
em = False, f1 = 0
France 5 ['Birkbeck, University of London']
em = False, f1 = 0
Democratic Party ['Democratic Party']
em = True, f1 = 1.0
Vicenza ['Yamaha Motor Racing']
em = False, f1 = 0
S.L. Milan ['FC Barcelona', 'Sweden national association football team', 'Associazione Calcio Milan']
em = False, f1 = 0.4
Leicester City F.C. ['AFC Bournemouth']
em = False, f1 = 0
France 5 ['Städel Museum', 'Liebieghaus', 'Schirn Kunsthalle Frankfurt']
em = False, f1 = 0
Pennsylvania State Government ['Ed Rendell']
em = False, f1 = 0
Michael Gove ['Justin King']
em = False, f1 = 0
France 5 ['Jean-Marie Le Pen']
em = False, f1 = 0
Yuriy Krot ['Ottmar Hitzfeld']
em = False, f1 = 0
Democratic Party of Malaysia ['United Malays National Organisation']
em = False, f1 = 0
Valencia CF ['Scuderia Ferrari']
em = False, f1 = 0
India Today ['National Planning Commission of Nepal', 'Nepal Rastra Bank']
em = False, f1 = 0
Netscape Communications Corporation ['AOL']
em = False, f1 = 0
Cristiano Ronaldo ['Martin Jol', 'Frank de Boer']
em = False, f1 = 0
chief executive officer ['President of Zimbabwe']
em = False, f1 = 0
Vice-President of Poland ['member of the European Parliament', 'President of the European Parliament']
em = False, f1 = 0.28571428571428575
France 5 ['Durham University']
em = False, f1 = 0
United States of America ['University of Cambridge']
em = False, f1 = 0.28571428571428575
Al Jazeera English ['Blackburn Rovers F.C.']
em = False, f1 = 0
Toronto Raptors ['San Diego Padres']
em = False, f1 = 0
SK Rapid Wien ['1. FC Kaiserslautern', 'S.S.C. Napoli', 'Austria national association football team']
em = False, f1 = 0
France 5 ['Hamburger SV', 'Manchester City F.C.']
em = False, f1 = 0
Democratic Union for a Popular Movement ['Socialist Party']
em = False, f1 = 0
Jeremy Corbyn ['Johannes Vogel']
em = False, f1 = 0
chief executive officer ['Church Commissioners', 'Church Estates Commissioners']
em = False, f1 = 0
chief executive officer ['state treasurer']
em = False, f1 = 0
 ['Donald Tusk']
em = False, f1 = 0
Olympique Lyonnais ['Chelsea F.C.']
em = False, f1 = 0
Silvio Berlusconi ['Alessandro Cosimi']
em = False, f1 = 0
Democratic Party ['National Liberal Party']
em = False, f1 = 0.4
Democratic Convergence of Catalonia ['Horizon Monaco']
em = False, f1 = 0
FIFA ['Olegario Vázquez Raña']
em = False, f1 = 0
Prime Minister of Turkey ['Prime Minister of Turkey']
em = True, f1 = 1.0
Democratic Convergence of Catalonia ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Kansas City Chiefs ['West Texas A&M University']
em = False, f1 = 0
Democratic Party ['NOW – Pilz List']
em = False, f1 = 0
France 5 ['Yahoo']
em = False, f1 = 0
United States of America ['Commonwealth Scientific and Industrial Research Organisation']
em = False, f1 = 0
Toronto Raptors ['Australia national cricket team', 'Western Fury']
em = False, f1 = 0
chief executive officer ['chief technology officer']
em = False, f1 = 0.6666666666666666
Yongjiang University ['Regent University']
em = False, f1 = 0.5
Ferrovie dello Stato Italiane ['RCS MediaGroup']
em = False, f1 = 0
Toronto Raptors ['FC Twente']
em = False, f1 = 0
eljko eljko ['Bohuslav Sobotka', 'Jiří Paroubek']
em = False, f1 = 0
United States Department of Education ['IT University of Copenhagen']
em = False, f1 = 0.22222222222222224
France 5 ['Thomas Mirow', 'Horst Köhler']
em = False, f1 = 0
Cristiano Ronaldo ['Quique Sánchez Flores']
em = False, f1 = 0
Vice-President of the European Commission ['State Secretary']
em = False, f1 = 0
Vice-President of Turin ['Sergio Chiamparino']
em = False, f1 = 0
Toronto Raptors ['FC Gold Pride']
em = False, f1 = 0
S.L. Benfica ['Netherlands national association football team', 'FC Twente']
em = False, f1 = 0
The New York Times ['US Airways']
em = False, f1 = 0
United States Department of State ['Royal Free London NHS Foundation Trust']
em = False, f1 = 0
France 5 ['Stanford University School of Medicine']
em = False, f1 = 0
United States of America ['Juniper Networks', 'Echelon Corporation']
em = False, f1 = 0
Birmingham City F.C. ['Los Angeles Galaxy', 'Associazione Calcio Milan']
em = False, f1 = 0
Banco del Norte ['Silvio Santos']
em = False, f1 = 0
 ['Dag-Eilev Fagermo']
em = False, f1 = 0
S.L. Benfica ['Ghana national football team', 'Sunderland A.F.C.', 'Olympique Lyonnais']
em = False, f1 = 0
Democratic Convergence of Catalonia ['The People of Freedom']
em = False, f1 = 0.28571428571428575
The Walt Disney Company ['Agnes Gund']
em = False, f1 = 0
Democratic Convergence of Catalonia ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Greece ['Athens University of Economics and Business', 'National and Kapodistrian University of Athens']
em = False, f1 = 0
France 5 ['Televisión Española']
em = False, f1 = 0
chief executive officer ['Major General of the Armed Forces', "Head of the Prime Minister's military cabinet"]
em = False, f1 = 0
Toronto Raptors ['Munster Rugby']
em = False, f1 = 0
Nicolás Maduro ['Tibisay Lucena']
em = False, f1 = 0
Democratic Party ["People's Party"]
em = False, f1 = 0.5
S.L. Benfica ['Stevenage F.C.']
em = False, f1 = 0
Ofcom ['Christopher Poole']
em = False, f1 = 0
chief executive officer ['Chief Whip']
em = False, f1 = 0.4
Leicester City F.C. ['Dagenham & Redbridge F.C.']
em = False, f1 = 0.3333333333333333
ONO ['University of Jyväskylä']
em = False, f1 = 0
 ['Michel Wolter']
em = False, f1 = 0
United States of America ['MSNBC']
em = False, f1 = 0
SourceForge ['Vera Augustin Research']
em = False, f1 = 0
Vice-President of China ['President of the Republic of China', 'Chairperson of the Kuomintang']
em = False, f1 = 0.5
The Nature Conservancy ['S. I. Newhouse']
em = False, f1 = 0
The Coca-Cola Company ['Rudolf Staechelin']
em = False, f1 = 0
United States Department of Education ['Burnet Institute']
em = False, f1 = 0
Cristian Dulca ['Emil Săndoi']
em = False, f1 = 0
France 5 ['Iniva']
em = False, f1 = 0
 ['Valentina Matviyenko']
em = False, f1 = 0
Los Angeles Angels ['Derby County F.C.']
em = False, f1 = 0
 ['Keiji Yamada']
em = False, f1 = 0
S.L. Benfica ['Chicago Bulls']
em = False, f1 = 0
Toronto Raptors ['England and Wales cricket team']
em = False, f1 = 0
Valencia CF ['Middlesbrough F.C.']
em = False, f1 = 0
chief executive officer ['Minister for Foreign Affairs of Finland']
em = False, f1 = 0
Birmingham City F.C. ['California Storm', "United States women's national soccer team", 'Pali Blues']
em = False, f1 = 0
France 5 ['Lille OSC', 'AS Monaco FC', 'Associazione Calcio Milan']
em = False, f1 = 0
United States Department of Education ["Brigham and Women's Hospital"]
em = False, f1 = 0
chief executive officer ['President of Mauritius']
em = False, f1 = 0
United States of America ['Harvard Medical School']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Union of Catalonia']
em = False, f1 = 0
 ['Vilma Santos']
em = False, f1 = 0
Kevitsa ['First Quantum Minerals']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Institutional Republican Party']
em = False, f1 = 0.2222222222222222
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Democratic Union of South Africa ['Conservative Party']
em = False, f1 = 0
Sweden Democrats ['Colorado State University']
em = False, f1 = 0
Birmingham City F.C. ['England and Wales cricket team', 'Sussex County Cricket Club']
em = False, f1 = 0
Sven-Göran Eriksson ['Karel Schwarzenberg']
em = False, f1 = 0
United States of America ['East Carolina Pirates football']
em = False, f1 = 0
chief executive officer ['United States representative']
em = False, f1 = 0
Vice-President of the Philippines ['Republican Conference Chairman of the United States Senate', 'United States senator']
em = False, f1 = 0.2
 ['Wolfgang Lück']
em = False, f1 = 0
Toronto Raptors ['Futebol Clube do Porto', 'Club Atlético Banfield']
em = False, f1 = 0
Mauricio Macri ['Danny De Bie']
em = False, f1 = 0
Olympique Lyonnais ['Chelsea F.C.', 'Liverpool F.C.']
em = False, f1 = 0
 ['Volodymyr Lytvyn']
em = False, f1 = 0
 ['Lucette Michaux-Chevry']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
University of Ghana ['The Park School of Buffalo']
em = False, f1 = 0.28571428571428575
chief executive officer ['United States representative']
em = False, f1 = 0
 ['Joe Bossano']
em = False, f1 = 0
Vice-President of the European Commission ['Labour Chief Whip', 'Chief Whip']
em = False, f1 = 0
Russia ['A Just Russia']
em = False, f1 = 0.6666666666666666
 ['Gilberto Kassab']
em = False, f1 = 0
 ['José Serra', 'Alberto Goldman']
em = False, f1 = 0
Democratic Party of Korea ['Liberty Korea Party']
em = False, f1 = 0.5714285714285715
Democratic Union of Sri Lanka ['New Democratic Party']
em = False, f1 = 0.25
Birmingham City F.C. ['Blackpool F.C.', 'Swansea City A.F.C.']
em = False, f1 = 0.4
United States of America ['University of Connecticut']
em = False, f1 = 0.28571428571428575
The National Portrait Gallery ['Alice Walton']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Left, Ecology and Freedom']
em = False, f1 = 0.4
England and Wales Cricket Board ['New York Mets', 'Buffalo Bisons']
em = False, f1 = 0
Olympique Lyonnais ['Club Brugge K.V.']
em = False, f1 = 0
Kongregat ['GameStop']
em = False, f1 = 0
Los Angeles Angels ['Washington Wizards', 'Orlando Magic']
em = False, f1 = 0
Vice-President of the World ['University of Strathclyde']
em = False, f1 = 0.3333333333333333
United States Department of Education ['Washington University in St.\xa0Louis']
em = False, f1 = 0
Kre ['Novo Nordisk']
em = False, f1 = 0
FIA Europe ['TF1 Group']
em = False, f1 = 0
Vice-President of the Philippines ['United States senator', 'Republican Conference Vice-Chair of the United States Senate']
em = False, f1 = 0.2
Democratic Convergence of Catalonia ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Al Jazeera English ['Hamad bin Jassim bin Jaber Al Thani', 'Abdullah bin Nasser bin Khalifa Al Thani']
em = False, f1 = 0.2
Vice-President of Serbia ['European Commissioner for Education, Culture, Multilingualism and Youth']
em = False, f1 = 0
chief executive officer ['Secretary of State for Scotland', 'Shadow Secretary of State for Defence', 'Shadow Secretary of State for Scotland']
em = False, f1 = 0
United States Navy ['United States Department of Justice']
em = False, f1 = 0.5
United States Senate ['New Democratic Party']
em = False, f1 = 0
Democratic Convergence of Romania ['Social Democratic Party']
em = False, f1 = 0.28571428571428575
Democratic Union for a Popular Movement ['Liberal Party of Australia', 'Liberal Party of Australia (South Australian Division)']
em = False, f1 = 0
 ['Yeda Crusius']
em = False, f1 = 0
Toronto Raptors ['Burnley F.C.', 'IF Brommapojkarna', 'Manchester City F.C.', 'Sweden national under-21 football team', 'Sweden national under-19 football team']
em = False, f1 = 0
France 5 ['Harvard University']
em = False, f1 = 0
People's Party for Freedom and Democracy ['United and Alternative Left', 'Party of the Communists of Catalonia']
em = False, f1 = 0.2
Liaoning ['Chen Zhenggao']
em = False, f1 = 0
Los Angeles Times ['Village Voice Media']
em = False, f1 = 0
Yuriy Zhukov ['Penelope Maddy', 'Alec Wilkie']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Birmingham City F.C. ['England and Wales cricket team']
em = False, f1 = 0
S.L. Benfica ['Juventus FC', 'VfL Wolfsburg']
em = False, f1 = 0
chief executive officer ['Minister of Defence']
em = False, f1 = 0
France 5 ['RAI']
em = False, f1 = 0
chief executive officer ['Teachta Dála', 'Minister for Education and Skills', 'Minister for Jobs, Enterprise and Innovation', 'Tánaiste']
em = False, f1 = 0
Vice-President of the European Commission ['titular bishop', 'Catholic bishop']
em = False, f1 = 0
Al Jazeera English ['Bangladesh national cricket team', 'Worcestershire County Cricket Club']
em = False, f1 = 0
Democratic Party ['Democratic Liberal Party']
em = False, f1 = 0.8
United States Department of Justice ['Oregon Ducks']
em = False, f1 = 0
France 5 ['European Society of Cardiology', 'UZ Leuven']
em = False, f1 = 0
Yuriy Yuriyev ['Reinoldijus Šarkinas']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Vice-President of the Navy ['dean of Liverpool']
em = False, f1 = 0.3333333333333333
Xi Jinping ['Cho Po-yuan']
em = False, f1 = 0
Entercom ['Denison University']
em = False, f1 = 0
France 5 ['Hélène Langevin-Joliot']
em = False, f1 = 0
Toronto Raptors ['Columbus Crew SC', "United States men's national soccer team"]
em = False, f1 = 0
United States of America ['Queens Museum']
em = False, f1 = 0
France 5 ['University of Chile']
em = False, f1 = 0
Jr. ['Les Miles']
em = False, f1 = 0
The People of Freedom ['Hamilton College', 'Vassar College']
em = False, f1 = 0
The New York Times ['Dow Jones & Company', 'BBC America']
em = False, f1 = 0
Vice-Chancellor of Germany ['University of Münster']
em = False, f1 = 0.3333333333333333
University of Tokyo ['Sendai University Meisei High School']
em = False, f1 = 0.25
Democratic Party ['Norwegian Labour Party']
em = False, f1 = 0.4
Vice-President of the European Commission ['European Commissioner for Energy', 'European Commissioner for International Cooperation, Humanitarian Aid and Crisis Response']
em = False, f1 = 0.25
France 5 ['Institute for Advanced Study']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
University of Lagos ['University of Eastern Finland', 'University of Helsinki']
em = False, f1 = 0.6666666666666666
Democratic Party ['Pakistan Muslim League (Q)']
em = False, f1 = 0
witochr ['Stefan Białas', 'Maciej Skorża', 'Jan Urban']
em = False, f1 = 0
chief executive officer ['treasurer', 'Kansas State Treasurer']
em = False, f1 = 0
Toronto Raptors ['Colorado Rapids', 'Houston Dynamo']
em = False, f1 = 0
Vice-President of the Philippines ['United States representative']
em = False, f1 = 0
ONO ['ETH Zurich']
em = False, f1 = 0
Birmingham City F.C. ['Manchester City F.C.', 'Republic of Ireland national association football team']
em = False, f1 = 0.6666666666666666
chief executive officer ['Liberal Democrat Home Affairs spokesman', 'Secretary of State for Energy and Climate Change']
em = False, f1 = 0
Vice-President of the Philippines ['Secretary of the Interior and Local Government', 'mayor']
em = False, f1 = 0.2222222222222222
Toronto Raptors ['Derry City F.C.', 'Northern Ireland national under-21 football team']
em = False, f1 = 0
S.L. Benfica ['R.S.C. Anderlecht', 'Belgium national football team']
em = False, f1 = 0
France 5 ['Jean-Louis Garcia']
em = False, f1 = 0
Vice-President of the Philippines ['White House Chief of Staff']
em = False, f1 = 0.25
Vice-President of Finland ['chairperson']
em = False, f1 = 0
Democratic Party ['SYRIZA']
em = False, f1 = 0
Leicester City F.C. ['Manchester City F.C.', 'England national association football team']
em = False, f1 = 0.6666666666666666
Los Angeles Angels ['Bangor Symphony Orchestra', 'Knoxville Symphony Orchestra']
em = False, f1 = 0
Vice-President of the European Commission ['Minister for Immigration and Border Protection of Australia']
em = False, f1 = 0.16666666666666666
Vice-President of the Philippines ['ambassador of Uruguay to China', 'foreign minister']
em = False, f1 = 0.25
Vice-President of the Philippines ['permanent representative of Spain to the European Union']
em = False, f1 = 0.2
Toronto Raptors ['Belgium national under-17 football team', 'Belgium national under-18 football team', 'Belgium national under-19 football team']
em = False, f1 = 0
Democratic Union of Lithuania ["People's Party"]
em = False, f1 = 0
Toronto Raptors ['Santa Clara Broncos']
em = False, f1 = 0
United States of America ['University College London']
em = False, f1 = 0
chief executive officer ['Secretary for Relations with States']
em = False, f1 = 0
United States Information Agency ['Lunar and Planetary Institute']
em = False, f1 = 0
S.L. Benfica ['Pakistan national cricket team']
em = False, f1 = 0
Democratic Party ['Indian National Congress']
em = False, f1 = 0
United States Department of Education ['University of Southampton']
em = False, f1 = 0.25
Bergen Commuter Rail ['Norwegian National Rail Administration']
em = False, f1 = 0.28571428571428575
United India Party ['University of Arizona']
em = False, f1 = 0
Romanian Football Federation ['University of Windsor']
em = False, f1 = 0
 ['Rick Perry']
em = False, f1 = 0
chief executive officer ['president']
em = False, f1 = 0
chief executive officer ['member of the European Parliament']
em = False, f1 = 0
United States Information Agency ['University of Cambridge', 'Perimeter Institute for Theoretical Physics']
em = False, f1 = 0
Honduran ['Linda Lingle', 'Neil Abercrombie']
em = False, f1 = 0
Russia Today ['Massachusetts General Hospital']
em = False, f1 = 0
United States Department of Education ['WHU-Otto Beisheim School of Management']
em = False, f1 = 0.20000000000000004
 ['Reiner Hollich']
em = False, f1 = 0
Democratic Party ['Republican Party']
em = False, f1 = 0.5
France 5 ['Middlesbrough F.C.', 'OGC Nice']
em = False, f1 = 0
Nicolás Almagro ['Josep Maria Pons Irazazábal']
em = False, f1 = 0
United Arab Emirates ['Armenian State Pedagogical University', 'Public Radio of Armenia']
em = False, f1 = 0
Toronto Raptors ['New England Patriots']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Alternative Democratic Pole']
em = False, f1 = 0
Democratic Convergence of Catalonia ['The People of Freedom']
em = False, f1 = 0.28571428571428575
Birmingham City F.C. ['Ineos Grenadier']
em = False, f1 = 0
Stanford University ['South Garland High School']
em = False, f1 = 0
chief executive officer ['White House Cabinet Secretary']
em = False, f1 = 0
Valencia CF ['Genoa C.F.C.', 'Argentina national football team']
em = False, f1 = 0
Democratic Party ['Kadima']
em = False, f1 = 0
chief executive officer ['Shadow Attorney General for England and Wales', 'Solicitor General for England and Wales']
em = False, f1 = 0
Union for a Popular Movement ['Socialist Party']
em = False, f1 = 0
Democratic Convergence of Catalonia ['Social Democratic Party']
em = False, f1 = 0.28571428571428575
chief executive officer ['United States Ambassador to the United Nations Agencies for Food and Agriculture']
em = False, f1 = 0
United States Department of Education ['University of Bath']
em = False, f1 = 0.25
S.L. Benfica ['Santos F.C.', 'Brazil national football team', 'Manchester City F.C.', 'Associazione Calcio Milan']
em = False, f1 = 0
Vice-President of Pakistan ['Mayor of Tehran']
em = False, f1 = 0.3333333333333333
Democratic Party ['Liberal Democratic Party']
em = False, f1 = 0.8
Ukraine ['Osnabrück University']
em = False, f1 = 0
chief executive officer ['director', 'president']
em = False, f1 = 0
United Malays National Organisation ['Bahujan Samaj Party']
em = False, f1 = 0
Vicenza ['Leeds United F.C.']
em = False, f1 = 0
Democratic Convergence of Catalonia ['Democratic Party', 'Union of the Centre']
em = False, f1 = 0.3333333333333333
S.L. Benfica ['Counties Manukau Rugby Football Union', 'RC Toulonnais']
em = False, f1 = 0
University of the South ['Hanyang University']
em = False, f1 = 0.4
Democratic Convergence of Catalonia ['Democratic Convergence of Catalonia']
em = True, f1 = 1.0
Yuriy Krot ['Cemal Yıldız', 'Thomas Herbst']
em = False, f1 = 0
Cristian Dulca ['Jürgen Klopp']
em = False, f1 = 0
Democratic Party ['independent politician']
em = False, f1 = 0
France 5 ['Union for a Popular Movement']
em = False, f1 = 0
Toronto Raptors ['Hull City A.F.C.']
em = False, f1 = 0
Al Jazeera English ['Sui Northern Gas Pipelines Limited', 'Faisalabad cricket team', 'Pakistan national cricket team', 'Faisalabad Wolves']
em = False, f1 = 0
Russia Today ['Alfa Group', 'X5 Retail Group']
em = False, f1 = 0
Toronto Raptors ['Crusaders', 'New Zealand national rugby union team']
em = False, f1 = 0
Yves Saint Laurent ['Anni Sinnemäki']
em = False, f1 = 0
S.L. Benfica ['Al-Wakrah Sports Club', 'FAR Rabat']
em = False, f1 = 0
Stanford University ['Erasmus University Rotterdam']
em = False, f1 = 0.4
Syed Ali Shah ['Mufti Mohammad Sayeed']
em = False, f1 = 0
United States Department of Education ['Grenoble Institute of Technology', 'Aberystwyth University']
em = False, f1 = 0.22222222222222224
Hickory Newspapers ['Berkshire Hathaway']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Party']
em = False, f1 = 0.25
The New York Times ['The Rockefeller University']
em = False, f1 = 0
Stanford University ['HU University of Applied Sciences Utrecht', 'Heriot-Watt University']
em = False, f1 = 0.5
Toronto Raptors ['Sunderland A.F.C.']
em = False, f1 = 0
Democratic Party ['Malaysian Islamic Party']
em = False, f1 = 0.4
Christian XIII ['Florian Pronold']
em = False, f1 = 0
Sean O'Connor ['Martin Russell']
em = False, f1 = 0
Democratic Convergence of Catalonia ['Democratic Liberal Party']
em = False, f1 = 0.28571428571428575
University of Havana ['Eötvös Loránd University', 'University of Amsterdam']
em = False, f1 = 0.6666666666666666
Wheaton Corporation ['Westfield Group']
em = False, f1 = 0
France 5 ['Freie Universität Berlin']
em = False, f1 = 0
Vice-President of Milan ['Letizia Moratti']
em = False, f1 = 0
Valencia CF ['Boston Red Sox', 'San Diego Padres']
em = False, f1 = 0
Toronto Raptors ['Newcastle United F.C.', 'Celtic F.C.', 'Norwich City F.C.']
em = False, f1 = 0
chief executive officer ['president']
em = False, f1 = 0
The Federal Building Commission ['General Services Administration']
em = False, f1 = 0
chief executive officer ['European Commissioner for Agriculture and Rural Development']
em = False, f1 = 0
ONO ['Kyushu University']
em = False, f1 = 0
France 5 ['Monash University']
em = False, f1 = 0
France 5 ['California State University, Monterey Bay']
em = False, f1 = 0
lvaro Uribe ['Ernesto Valverde']
em = False, f1 = 0
University of Tehran ['Geneva Centre for Security Policy', 'Diplomatic Academy of the Ministry of Foreign Affairs of the Russian Federation']
em = False, f1 = 0.15384615384615383
Benfica ['Jan du Plessis']
em = False, f1 = 0
 ['Serge Lepeltier']
em = False, f1 = 0
Germany ['Borussia Dortmund']
em = False, f1 = 0
Emmanuel Macron ['Mario De Clercq', 'Hans De Clercq']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democrats']
em = False, f1 = 0
ONO ['Astana']
em = False, f1 = 0
chief executive officer ['secretary of state']
em = False, f1 = 0
Stanford University ['St. Pius X Catholic High School']
em = False, f1 = 0
Boxer TV ['Teracom']
em = False, f1 = 0
Charlotte Hornets ['Michael Jordan', 'Robert L. Johnson']
em = False, f1 = 0
Valencia CF ['Arsenal F.C.']
em = False, f1 = 0
S.L. Sabah ['Chennai Super Kings', 'Sri Lanka national cricket team']
em = False, f1 = 0
S.L. Benfica ['Brazil Olympic football team']
em = False, f1 = 0
Silvio Berlusconi ['Luigi Albore Mascia']
em = False, f1 = 0
Michael C. Smith ['John Maeda']
em = False, f1 = 0
People's Party for Freedom and Democracy ["Conservative People's Party"]
em = False, f1 = 0.4444444444444444
United States Department of Education ['Rutgers Scarlet Knights football']
em = False, f1 = 0
Teachta Dála ['Teachta Dála', 'Minister for Social Protection']
em = True, f1 = 1.0
France 5 ['Armenia national under-21 football team', 'FC Shakhtar Donetsk', 'FC Metalurh Donetsk']
em = False, f1 = 0
United States of America ['University of Pennsylvania']
em = False, f1 = 0.28571428571428575
S.L. Benfica ["Indiana Hoosiers men's basketball"]
em = False, f1 = 0
Toronto Raptors ['Munster Rugby', 'Ireland national rugby union team']
em = False, f1 = 0
Michael Mann ['John Fox']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Muttahida Qaumi Movement']
em = False, f1 = 0
 ['Vladimir Ryzhkov', 'Valentina Melnikova']
em = False, f1 = 0
Vice-President of India ['Minister of Finance', 'Leader of the House']
em = False, f1 = 0.3333333333333333
Wolverhampton Wanderers ['Arsenal F.C.', 'Poland national under-20 football team', 'Brentford F.C.', 'Poland national under-21 football team']
em = False, f1 = 0
Stanford University ['Rowville Secondary College']
em = False, f1 = 0
Vice-President of the World ['University of Exeter']
em = False, f1 = 0.3333333333333333
United States Department of Education ['Google']
em = False, f1 = 0
Valencia CF ['Italy national under-21 football team', 'Manchester United F.C.']
em = False, f1 = 0
Wales Democrat ['Dafydd Elis-Thomas']
em = False, f1 = 0
Toronto Raptors ['Netherlands national association football team', 'Liverpool F.C.']
em = False, f1 = 0
Toronto Raptors ['Washington Freedom']
em = False, f1 = 0
 ['David H. Bieter']
em = False, f1 = 0
The People of Freedom ['Trans TV']
em = False, f1 = 0
United States Department of Education ['bp']
em = False, f1 = 0
Silvio Berlusconi ['Giuseppe Merisi']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Democratic Convergence of Catalonia']
em = False, f1 = 0
Democratic Party ["Socialist People's Party of Montenegro"]
em = False, f1 = 0.28571428571428575
Vicenza ['Fiat S.p.A.']
em = False, f1 = 0
S.L. Benfica ['Real Madrid CF']
em = False, f1 = 0
France 5 ['Eutelsat']
em = False, f1 = 0
Vicenza ['University of the Mediterranean - Aix Marseille II']
em = False, f1 = 0
Valencia CF ['Golden State Warriors']
em = False, f1 = 0
Stanford University ['St. Xavier High School']
em = False, f1 = 0
United States of America ['Apple Inc.']
em = False, f1 = 0
 ['Ole von Beust', 'Christoph Ahlhaus']
em = False, f1 = 0
Vice-President of Norway ['Secretary General of the Council of Europe', 'chairperson']
em = False, f1 = 0.2222222222222222
S.L. Benfica ['Arsenal F.C.']
em = False, f1 = 0
chief executive officer ['Bishop of Southampton', 'Bishop of Southwell and Nottingham']
em = False, f1 = 0
Vice-President of Norway ['Minister of Children and Family Affairs']
em = False, f1 = 0.2222222222222222
chief executive officer ['Secretary of State for Business, Energy and Industrial Strategy']
em = False, f1 = 0
People's Party for Freedom and Democracy ['Authenticity and Modernity Party']
em = False, f1 = 0.4
 ['Martine Lignières-Cassou']
em = False, f1 = 0
S.L. Sagar ['Hokkaido Nippon-Ham Fighters']
em = False, f1 = 0
United States Naval Academy ['University of Bristol']
em = False, f1 = 0
PEN International ['John R. Saul']
em = False, f1 = 0
S.L. Benfica ['Portsmouth F.C.', 'Ghana national football team', 'Associazione Calcio Milan']
em = False, f1 = 0
Vice-President of the European Commission ['member of the Australian Capital Territory Legislative Assembly', 'Chief Minister of the Australian Capital Territory']
em = False, f1 = 0.2
Omar al-Bashir ['Abdelkader Taleb Omar']
em = False, f1 = 0.4
Democratic Party ['Liberal National Party of Queensland']
em = False, f1 = 0.28571428571428575
The New York Times ['Centre for Quantum Technologies', 'National University of Singapore', 'California Institute of Technology']
em = False, f1 = 0
of New Zealand ['Len Brown']
em = False, f1 = 0
Vicenza ['Beth Israel Deaconess Medical Center', 'Harvard Medical School']
em = False, f1 = 0
Epoch 7: 100%|██████████| 91/91 [00:11<00:00,  7.84it/s, loss=3.16]
                                                            [A
Epoch 7: 100%|██████████| 91/91 [00:12<00:00,  7.55it/s, loss=3.16]
