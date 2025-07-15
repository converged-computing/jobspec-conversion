#!/bin/bash
#FLUX: --job-name=dinosaur-cattywampus-2058
#FLUX: --urgency=16

ml python/3.6.4
module load miniconda/3
python3 GSTR_calc.py "--project=${1}" "--parameter=${2}" "--root=${3}" --sgids_to_exclude=Pcna_2,Pten_2,Smad4_2,Rbm10_4,Rnf43_1,Rb1_1,Smad4_1,Apc_2,Kmt2c_1,Cdkn2c_3,Cdkn2a_1,Ifngr1_2,Setd2_V4,Smarca4_2,B2M_1,Ifngr1_1 --samples_to_exclude=MT475_Liver,MT475_Spleen,MT442_Liver,,MT1715,MT469_MT1786,MT470,MT1025,MT1071,MT1759,MT1779,MT498_PM
