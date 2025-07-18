#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=86400
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python preprocess_wmt_train_data.py 2007 -debug
--------------------
As Woes Grow, Mortgage Ads Keep Up Pitch
Wall Street may have soured on the mortgage business.
{'entity': 'B-LOC', 'score': 0.99927634, 'index': 1, 'word': 'Wall', 'start': 0, 'end': 4}
{'entity': 'I-LOC', 'score': 0.99937636, 'index': 2, 'word': 'Street', 'start': 5, 'end': 11}
But on television, radio and the Internet, the industry is as ebullient as ever.
{'entity': 'B-MISC', 'score': 0.9933886, 'index': 8, 'word': 'Internet', 'start': 33, 'end': 41}
For example, Quicken Loans, no longer affiliated with the makers of Quicken software but the nations 25th-biggest lender, continues to run its signature spot on radio stations. This is a rate alert, the advertisement starts off, sounding much like a newscast. Slower economic growth has caused the Fed to keep interest rates flat, and the market has responded with some of the lowest mortgage rates in years.
{'entity': 'B-ORG', 'score': 0.99864537, 'index': 4, 'word': 'Quick', 'start': 13, 'end': 18}
{'entity': 'I-ORG', 'score': 0.9985757, 'index': 5, 'word': '##en', 'start': 18, 'end': 20}
{'entity': 'I-ORG', 'score': 0.99868983, 'index': 6, 'word': 'Lo', 'start': 21, 'end': 23}
{'entity': 'I-ORG', 'score': 0.9968586, 'index': 7, 'word': '##ans', 'start': 23, 'end': 26}
{'entity': 'B-ORG', 'score': 0.938297, 'index': 16, 'word': 'Quick', 'start': 68, 'end': 73}
{'entity': 'I-ORG', 'score': 0.79861474, 'index': 17, 'word': '##en', 'start': 73, 'end': 75}
{'entity': 'B-ORG', 'score': 0.9990312, 'index': 62, 'word': 'Fed', 'start': 302, 'end': 305}
As more homeowners fall behind on mortgage payments and investors abandon the industry in droves, mortgage companies are facing greater scrutiny over their lending practices and disclosures to borrowers.
One area where regulators are paying closer attention is advertising that promises tantalizingly low payments without clearly disclosing the myriad strings that accompany the debts.
It is a tactic that has been widely used  and, critics say, abused  by lenders trying to lure new customers.
Mortgage lenders have spent more than $3 billion since 2000 on advertising on television, on radio and in print, said Nielsen Monitor-Plus, which tracks ad spending.
{'entity': 'B-MISC', 'score': 0.7972702, 'index': 28, 'word': 'Nielsen', 'start': 118, 'end': 125}
{'entity': 'I-MISC', 'score': 0.98634404, 'index': 29, 'word': 'Monitor', 'start': 126, 'end': 133}
{'entity': 'I-MISC', 'score': 0.49472976, 'index': 31, 'word': 'Plus', 'start': 134, 'end': 138}
That figure does not include direct mail and Internet advertising, which are increasingly popular vehicles for the industry.
{'entity': 'B-MISC', 'score': 0.9965266, 'index': 9, 'word': 'Internet', 'start': 45, 'end': 53}
Nielsen/NetRatings estimates that mortgage companies spent $378 million in the first six months of this year on Internet display ads, and many companies also buy search advertising.
{'entity': 'B-ORG', 'score': 0.9926375, 'index': 1, 'word': 'Nielsen', 'start': 0, 'end': 7}
{'entity': 'I-ORG', 'score': 0.96569884, 'index': 2, 'word': '/', 'start': 7, 'end': 8}
{'entity': 'I-ORG', 'score': 0.9938918, 'index': 3, 'word': 'Net', 'start': 8, 'end': 11}
{'entity': 'I-ORG', 'score': 0.9973384, 'index': 4, 'word': '##R', 'start': 11, 'end': 12}
{'entity': 'I-ORG', 'score': 0.98999995, 'index': 5, 'word': '##ating', 'start': 12, 'end': 17}
{'entity': 'I-ORG', 'score': 0.99161714, 'index': 6, 'word': '##s', 'start': 17, 'end': 18}
{'entity': 'B-MISC', 'score': 0.99369323, 'index': 25, 'word': 'Internet', 'start': 112, 'end': 120}
LowerMyBills.com, a site owned by the credit agency Experian that funnels borrowers to mortgage lenders, has become a prolific advertiser on the Web with its impossible-to-miss ads that feature dancing cowboys and a video of a woman jumping and screaming with joy, presumably after being approved for a loan.
{'entity': 'B-ORG', 'score': 0.98142606, 'index': 1, 'word': 'Lower', 'start': 0, 'end': 5}
{'entity': 'I-ORG', 'score': 0.9922299, 'index': 2, 'word': '##M', 'start': 5, 'end': 6}
{'entity': 'I-ORG', 'score': 0.92608434, 'index': 3, 'word': '##y', 'start': 6, 'end': 7}
{'entity': 'I-ORG', 'score': 0.99634814, 'index': 4, 'word': '##B', 'start': 7, 'end': 8}
{'entity': 'I-ORG', 'score': 0.9949167, 'index': 5, 'word': '##ill', 'start': 8, 'end': 11}
{'entity': 'I-ORG', 'score': 0.9956119, 'index': 6, 'word': '##s', 'start': 11, 'end': 12}
{'entity': 'I-ORG', 'score': 0.97639173, 'index': 7, 'word': '.', 'start': 12, 'end': 13}
{'entity': 'I-ORG', 'score': 0.99073017, 'index': 8, 'word': 'com', 'start': 13, 'end': 16}
{'entity': 'B-ORG', 'score': 0.99516, 'index': 17, 'word': 'Ex', 'start': 52, 'end': 54}
{'entity': 'I-ORG', 'score': 0.99396867, 'index': 18, 'word': '##per', 'start': 54, 'end': 57}
{'entity': 'I-ORG', 'score': 0.9874558, 'index': 19, 'word': '##ian', 'start': 57, 'end': 60}
The Federal Trade Commission and attorneys general in states like Ohio and New York are looking into the ads as part of more comprehensive reviews of lending practices during the housing boom.
{'entity': 'B-ORG', 'score': 0.99925905, 'index': 2, 'word': 'Federal', 'start': 4, 'end': 11}
{'entity': 'I-ORG', 'score': 0.9993264, 'index': 3, 'word': 'Trade', 'start': 12, 'end': 17}
{'entity': 'I-ORG', 'score': 0.9994003, 'index': 4, 'word': 'Commission', 'start': 18, 'end': 28}
{'entity': 'B-LOC', 'score': 0.99944216, 'index': 11, 'word': 'Ohio', 'start': 66, 'end': 70}
{'entity': 'B-LOC', 'score': 0.9988923, 'index': 13, 'word': 'New', 'start': 75, 'end': 78}
{'entity': 'I-LOC', 'score': 0.99930245, 'index': 14, 'word': 'York', 'start': 79, 'end': 83}
In June, federal banking regulators ranked advertising as one of three areas where mortgage lenders need to be more judicious.
The Ohio attorney general, Marc Dann, said his staff was investigating direct-mail advertising that appears to be a solicitation from a homeowners bank or from the federal government.
{'entity': 'B-LOC', 'score': 0.9997251, 'index': 2, 'word': 'Ohio', 'start': 4, 'end': 8}
{'entity': 'B-PER', 'score': 0.99973094, 'index': 6, 'word': 'Marc', 'start': 27, 'end': 31}
{'entity': 'I-PER', 'score': 0.99962914, 'index': 7, 'word': 'Dan', 'start': 32, 'end': 35}
{'entity': 'I-PER', 'score': 0.99802506, 'index': 8, 'word': '##n', 'start': 35, 'end': 36}
Many ads appear to aim at low-income and minority neighborhoods.
Mr. Dann said his office has sent letters asking 30 lenders to substantiate their claims..
{'entity': 'B-PER', 'score': 0.9980347, 'index': 3, 'word': 'Dan', 'start': 4, 'end': 7}
As the mortgage market shrinks and defaults rise, he said, lenders are becoming more desperate, and consumers are becoming more desperate.
Consumer advocates say many ads are at best misleading and at worst steer consumers into risky loans with promises of low introductory rates that do not make clear that they could pay significantly more in a few months or years.
The advertising was a drumbeat to consumers, saying: Dont worry, you can qualify for a loan.
We will approve it,  said Patricia A. McCoy, a law professor at the University of Connecticut who has studied mortgage advertising. It was push marketing to reach out to these people on the sidelines who have doubts about their ability to pay a mortgage and lure them in.
{'entity': 'B-PER', 'score': 0.9995823, 'index': 7, 'word': 'Patricia', 'start': 28, 'end': 36}
{'entity': 'I-PER', 'score': 0.99612194, 'index': 8, 'word': 'A', 'start': 37, 'end': 38}
{'entity': 'I-PER', 'score': 0.9962915, 'index': 9, 'word': '.', 'start': 38, 'end': 39}
{'entity': 'I-PER', 'score': 0.9994773, 'index': 10, 'word': 'McCoy', 'start': 40, 'end': 45}
{'entity': 'B-ORG', 'score': 0.99623734, 'index': 17, 'word': 'University', 'start': 70, 'end': 80}
{'entity': 'I-ORG', 'score': 0.9976334, 'index': 18, 'word': 'of', 'start': 81, 'end': 83}
{'entity': 'I-ORG', 'score': 0.99673045, 'index': 19, 'word': 'Connecticut', 'start': 84, 'end': 95}
Even when consumers do find out about higher rates before closing on a house, by that time they are often psychologically committed to buying, Ms. McCoy said.
{'entity': 'B-PER', 'score': 0.9981803, 'index': 30, 'word': 'McCoy', 'start': 149, 'end': 154}
Quicken Loans was one of the many mortgage companies that benefited during the housing boom.
{'entity': 'B-ORG', 'score': 0.99932593, 'index': 1, 'word': 'Quick', 'start': 0, 'end': 5}
{'entity': 'I-ORG', 'score': 0.9988294, 'index': 2, 'word': '##en', 'start': 5, 'end': 7}
{'entity': 'I-ORG', 'score': 0.9990642, 'index': 3, 'word': 'Lo', 'start': 8, 'end': 10}
{'entity': 'I-ORG', 'score': 0.99868697, 'index': 4, 'word': '##ans', 'start': 10, 'end': 13}
The company, based in Livonia, Mich., near Detroit, wrote $18 billion in loans last year, up from $4.6 billion in 2001.
{'entity': 'B-LOC', 'score': 0.99769455, 'index': 6, 'word': 'Liv', 'start': 22, 'end': 25}
{'entity': 'I-LOC', 'score': 0.9993174, 'index': 7, 'word': '##onia', 'start': 25, 'end': 29}
{'entity': 'B-LOC', 'score': 0.9943613, 'index': 9, 'word': 'Mi', 'start': 31, 'end': 33}
{'entity': 'I-LOC', 'score': 0.85190135, 'index': 10, 'word': '##ch', 'start': 33, 'end': 35}
{'entity': 'B-LOC', 'score': 0.99798906, 'index': 14, 'word': 'Detroit', 'start': 43, 'end': 50}
Even during the tough market this year, Quicken Loans expects to make more than $20 billion in loans.
{'entity': 'B-ORG', 'score': 0.99945045, 'index': 9, 'word': 'Quick', 'start': 40, 'end': 45}
{'entity': 'I-ORG', 'score': 0.99897736, 'index': 10, 'word': '##en', 'start': 45, 'end': 47}
{'entity': 'I-ORG', 'score': 0.9991645, 'index': 11, 'word': 'Lo', 'start': 48, 'end': 50}
{'entity': 'I-ORG', 'score': 0.99886805, 'index': 12, 'word': '##ans', 'start': 50, 'end': 53}
Not coincidentally, Quicken Loans also pumped money into its advertising over that period  increasing it to $51 million last year from about $3.5 million in 2002, according to estimates from Nielsen Monitor-Plus.
{'entity': 'B-ORG', 'score': 0.99941844, 'index': 6, 'word': 'Quick', 'start': 20, 'end': 25}
{'entity': 'I-ORG', 'score': 0.9992178, 'index': 7, 'word': '##en', 'start': 25, 'end': 27}
{'entity': 'I-ORG', 'score': 0.9992223, 'index': 8, 'word': 'Lo', 'start': 28, 'end': 30}
{'entity': 'I-ORG', 'score': 0.9989962, 'index': 9, 'word': '##ans', 'start': 30, 'end': 33}
{'entity': 'B-MISC', 'score': 0.8859958, 'index': 41, 'word': 'Nielsen', 'start': 192, 'end': 199}
{'entity': 'I-MISC', 'score': 0.9857925, 'index': 42, 'word': 'Monitor', 'start': 200, 'end': 207}
{'entity': 'I-MISC', 'score': 0.9011955, 'index': 44, 'word': 'Plus', 'start': 208, 'end': 212}
Through June, Quicken Loans spent $37 million on mortgage ads  second only to GMAC, which spent $46 million.
{'entity': 'B-ORG', 'score': 0.9988249, 'index': 4, 'word': 'Quick', 'start': 14, 'end': 19}
{'entity': 'I-ORG', 'score': 0.99864906, 'index': 5, 'word': '##en', 'start': 19, 'end': 21}
{'entity': 'I-ORG', 'score': 0.999174, 'index': 6, 'word': 'Lo', 'start': 22, 'end': 24}
{'entity': 'I-ORG', 'score': 0.998563, 'index': 7, 'word': '##ans', 'start': 24, 'end': 27}
{'entity': 'B-ORG', 'score': 0.9991686, 'index': 18, 'word': 'GMA', 'start': 79, 'end': 82}
{'entity': 'I-ORG', 'score': 0.99880916, 'index': 19, 'word': '##C', 'start': 82, 'end': 83}
Quicken Loans would not confirm how much it spends on advertising but executives acknowledged that such spending had significantly increased.
{'entity': 'B-ORG', 'score': 0.9990687, 'index': 1, 'word': 'Quick', 'start': 0, 'end': 5}
{'entity': 'I-ORG', 'score': 0.99859464, 'index': 2, 'word': '##en', 'start': 5, 'end': 7}
{'entity': 'I-ORG', 'score': 0.9988919, 'index': 3, 'word': 'Lo', 'start': 8, 'end': 10}
{'entity': 'I-ORG', 'score': 0.9982769, 'index': 4, 'word': '##ans', 'start': 10, 'end': 13}
The chief marketing officer of Quicken Loans, Bryan Stapp, said that the ads were not misleading and that spending had increased as the company had grown.
{'entity': 'B-ORG', 'score': 0.9994491, 'index': 6, 'word': 'Quick', 'start': 31, 'end': 36}
{'entity': 'I-ORG', 'score': 0.9992388, 'index': 7, 'word': '##en', 'start': 36, 'end': 38}
{'entity': 'I-ORG', 'score': 0.99924105, 'index': 8, 'word': 'Lo', 'start': 39, 'end': 41}
{'entity': 'I-ORG', 'score': 0.99896985, 'index': 9, 'word': '##ans', 'start': 41, 'end': 44}
{'entity': 'B-PER', 'score': 0.9995556, 'index': 11, 'word': 'Bryan', 'start': 46, 'end': 51}
{'entity': 'I-PER', 'score': 0.99966484, 'index': 12, 'word': 'St', 'start': 52, 'end': 54}
{'entity': 'I-PER', 'score': 0.99891055, 'index': 13, 'word': '##ap', 'start': 54, 'end': 56}
{'entity': 'I-PER', 'score': 0.97924036, 'index': 14, 'word': '##p', 'start': 56, 'end': 57}
While the advertising mayve caused some to pick up the phone or go online, they still have to go through the process of talking to a banker, Mr. Stapp said. Anyone who was attracted to whatever advertising we had would then have a better picture of what program they could qualify for. Quicken Loans has not been identified as being under investigation by the F.T.C. or any regulatory agency.
{'entity': 'B-PER', 'score': 0.9974569, 'index': 33, 'word': 'St', 'start': 148, 'end': 150}
{'entity': 'B-PER', 'score': 0.8202364, 'index': 34, 'word': '##ap', 'start': 150, 'end': 152}
{'entity': 'B-ORG', 'score': 0.99774987, 'index': 61, 'word': 'Quick', 'start': 291, 'end': 296}
{'entity': 'I-ORG', 'score': 0.9970593, 'index': 62, 'word': '##en', 'start': 296, 'end': 298}
{'entity': 'I-ORG', 'score': 0.9986336, 'index': 63, 'word': 'Lo', 'start': 299, 'end': 301}
{'entity': 'I-ORG', 'score': 0.9964982, 'index': 64, 'word': '##ans', 'start': 301, 'end': 304}
{'entity': 'B-ORG', 'score': 0.99562985, 'index': 75, 'word': 'F', 'start': 365, 'end': 366}
{'entity': 'I-ORG', 'score': 0.7532993, 'index': 76, 'word': '.', 'start': 366, 'end': 367}
{'entity': 'I-ORG', 'score': 0.99848825, 'index': 77, 'word': 'T', 'start': 367, 'end': 368}
{'entity': 'I-ORG', 'score': 0.9893969, 'index': 78, 'word': '.', 'start': 368, 'end': 369}
{'entity': 'I-ORG', 'score': 0.9962252, 'index': 79, 'word': 'C', 'start': 369, 'end': 370}
{'entity': 'I-ORG', 'score': 0.47921738, 'index': 80, 'word': '.', 'start': 370, 'end': 371}
Quicken Loans has found that 40 percent of its business come from referrals or returning customers, Mr. Stapp said.
{'entity': 'B-ORG', 'score': 0.9995009, 'index': 1, 'word': 'Quick', 'start': 0, 'end': 5}
{'entity': 'I-ORG', 'score': 0.9991029, 'index': 2, 'word': '##en', 'start': 5, 'end': 7}
{'entity': 'I-ORG', 'score': 0.9991575, 'index': 3, 'word': 'Lo', 'start': 8, 'end': 10}
{'entity': 'I-ORG', 'score': 0.9989713, 'index': 4, 'word': '##ans', 'start': 10, 'end': 13}
{'entity': 'B-PER', 'score': 0.99673086, 'index': 23, 'word': 'St', 'start': 104, 'end': 106}
{'entity': 'I-PER', 'score': 0.39360756, 'index': 24, 'word': '##ap', 'start': 106, 'end': 108}
{'entity': 'B-PER', 'score': 0.56548035, 'index': 25, 'word': '##p', 'start': 108, 'end': 109}
The remaining 60 percent depend on new people picking up the phone or clicking on its Web site.
The company also provides free videos and articles about the mortgage and real estate market for use by any Web site and many Realtors, bloggers and others post the information  along with a link to Quicken Loans site.
{'entity': 'B-ORG', 'score': 0.5883122, 'index': 24, 'word': 'Real', 'start': 126, 'end': 130}
{'entity': 'I-ORG', 'score': 0.91896343, 'index': 25, 'word': '##tors', 'start': 130, 'end': 134}
{'entity': 'B-ORG', 'score': 0.99849266, 'index': 39, 'word': 'Quick', 'start': 200, 'end': 205}
{'entity': 'I-ORG', 'score': 0.99847937, 'index': 40, 'word': '##en', 'start': 205, 'end': 207}
{'entity': 'I-ORG', 'score': 0.9987943, 'index': 41, 'word': 'Lo', 'start': 208, 'end': 210}
{'entity': 'I-ORG', 'score': 0.996757, 'index': 42, 'word': '##ans', 'start': 210, 'end': 214}
The company does not plan to cut back on advertising for the rest of the year, Mr. Stapp said.
{'entity': 'B-PER', 'score': 0.99843264, 'index': 20, 'word': 'St', 'start': 83, 'end': 85}
{'entity': 'B-PER', 'score': 0.7331677, 'index': 21, 'word': '##ap', 'start': 85, 'end': 87}
{'entity': 'B-PER', 'score': 0.6422431, 'index': 22, 'word': '##p', 'start': 87, 'end': 88}
That will be a relief to media companies, which have benefited from the influx of spending.
But Countrywide Financial, the nations biggest mortgage company and a leading advertiser, recently said it would cut back on many popular loans because of its financial troubles.
{'entity': 'B-ORG', 'score': 0.9993889, 'index': 2, 'word': 'Country', 'start': 4, 'end': 11}
{'entity': 'I-ORG', 'score': 0.9992685, 'index': 3, 'word': '##wide', 'start': 11, 'end': 15}
{'entity': 'I-ORG', 'score': 0.9990126, 'index': 4, 'word': 'Financial', 'start': 16, 'end': 25}
Some advertising executives expect mortgage ad revenue at Web sites will drop significantly.
Housing analysts said the increase in home prices may have been propelled by ads from companies like Quicken Loans, which ran TV spots with pitches like: Your payment can be lower than you ever imagined.
{'entity': 'B-ORG', 'score': 0.9995063, 'index': 18, 'word': 'Quick', 'start': 101, 'end': 106}
{'entity': 'I-ORG', 'score': 0.9992132, 'index': 19, 'word': '##en', 'start': 106, 'end': 108}
{'entity': 'I-ORG', 'score': 0.9991818, 'index': 20, 'word': 'Lo', 'start': 109, 'end': 111}
{'entity': 'I-ORG', 'score': 0.99905884, 'index': 21, 'word': '##ans', 'start': 111, 'end': 114}
In its ads, Quicken Loans suggested that consumers could pay off credit card bills, remodel their homes and lower their monthly payment if they got a Secure Advantage mortgage, which allowed homeowners to roll what they would have paid in interest into the amount they owe.
{'entity': 'B-ORG', 'score': 0.99942493, 'index': 5, 'word': 'Quick', 'start': 12, 'end': 17}
{'entity': 'I-ORG', 'score': 0.99916697, 'index': 6, 'word': '##en', 'start': 17, 'end': 19}
{'entity': 'I-ORG', 'score': 0.99910253, 'index': 7, 'word': 'Lo', 'start': 20, 'end': 22}
{'entity': 'I-ORG', 'score': 0.99878955, 'index': 8, 'word': '##ans', 'start': 22, 'end': 25}
{'entity': 'B-MISC', 'score': 0.7318486, 'index': 33, 'word': 'Se', 'start': 150, 'end': 152}
{'entity': 'I-ORG', 'score': 0.48802245, 'index': 35, 'word': 'Ad', 'start': 157, 'end': 159}
{'entity': 'I-ORG', 'score': 0.48677707, 'index': 36, 'word': '##vant', 'start': 159, 'end': 163}
{'entity': 'I-MISC', 'score': 0.4394831, 'index': 37, 'word': '##age', 'start': 163, 'end': 166}
Many critics consider such mortgages, known as payment-option loans, dangerous for all but the most sophisticated borrowers, because many homeowners do not realize that making just the minimum payment will mean they owe more on their house with each passing month.
The company says it no longer offers that mortgage.
But Quicken Loans posted one of the ads on YouTube and it was up as recently as Aug. 7.
{'entity': 'B-ORG', 'score': 0.9994008, 'index': 2, 'word': 'Quick', 'start': 4, 'end': 9}
{'entity': 'I-ORG', 'score': 0.9991057, 'index': 3, 'word': '##en', 'start': 9, 'end': 11}
{'entity': 'I-ORG', 'score': 0.99912447, 'index': 4, 'word': 'Lo', 'start': 12, 'end': 14}
{'entity': 'I-ORG', 'score': 0.99877805, 'index': 5, 'word': '##ans', 'start': 14, 'end': 17}
{'entity': 'B-ORG', 'score': 0.9402197, 'index': 12, 'word': 'YouTube', 'start': 43, 'end': 50}
The radio version of the ads has run several times this month, according to Competitrack, a company in New York that tracks advertising.
{'entity': 'B-ORG', 'score': 0.9986461, 'index': 16, 'word': 'Co', 'start': 76, 'end': 78}
{'entity': 'I-ORG', 'score': 0.9969457, 'index': 17, 'word': '##mp', 'start': 78, 'end': 80}
{'entity': 'I-ORG', 'score': 0.98218805, 'index': 18, 'word': '##eti', 'start': 80, 'end': 83}
{'entity': 'I-ORG', 'score': 0.9985081, 'index': 19, 'word': '##track', 'start': 83, 'end': 88}
{'entity': 'B-LOC', 'score': 0.9994891, 'index': 24, 'word': 'New', 'start': 103, 'end': 106}
{'entity': 'I-LOC', 'score': 0.9994845, 'index': 25, 'word': 'York', 'start': 107, 'end': 111}
Quicken Loans says that even when it was advertising Secure Advantage, it did not make many payment-option loans.
{'entity': 'B-ORG', 'score': 0.9991407, 'index': 1, 'word': 'Quick', 'start': 0, 'end': 5}
{'entity': 'I-ORG', 'score': 0.99877, 'index': 2, 'word': '##en', 'start': 5, 'end': 7}
{'entity': 'I-ORG', 'score': 0.99901783, 'index': 3, 'word': 'Lo', 'start': 8, 'end': 10}
{'entity': 'I-ORG', 'score': 0.99854976, 'index': 4, 'word': '##ans', 'start': 10, 'end': 13}
{'entity': 'B-MISC', 'score': 0.9859084, 'index': 12, 'word': 'Se', 'start': 53, 'end': 55}
{'entity': 'I-MISC', 'score': 0.8985967, 'index': 13, 'word': '##cure', 'start': 55, 'end': 59}
{'entity': 'I-MISC', 'score': 0.97815436, 'index': 14, 'word': 'Ad', 'start': 60, 'end': 62}
{'entity': 'I-MISC', 'score': 0.94018847, 'index': 15, 'word': '##vant', 'start': 62, 'end': 66}
{'entity': 'I-MISC', 'score': 0.9609063, 'index': 16, 'word': '##age', 'start': 66, 'end': 69}
The company also said it made few loans to subprime borrowers  homeowners who have weak or blemished credit records.
Steve Walsh, a mortgage broker in Scottsdale, Ariz., said he spends a lot of time counseling clients against taking out loans that promise a deceptively low payment rate. These guys say your payment will be $500 a month, but nowhere do they say that your actual payment is $3,000 a month, Mr. Walsh said referring to the payments consumers would need to make to pay off their loan on a 30-year schedule. It should be criminal.
{'entity': 'B-PER', 'score': 0.99976856, 'index': 1, 'word': 'Steve', 'start': 0, 'end': 5}
{'entity': 'I-PER', 'score': 0.9996803, 'index': 2, 'word': 'Walsh', 'start': 6, 'end': 11}
{'entity': 'B-LOC', 'score': 0.99721175, 'index': 8, 'word': 'Scott', 'start': 34, 'end': 39}
{'entity': 'I-LOC', 'score': 0.9991192, 'index': 9, 'word': '##sdale', 'start': 39, 'end': 44}
{'entity': 'B-LOC', 'score': 0.98941016, 'index': 11, 'word': 'Ari', 'start': 46, 'end': 49}
{'entity': 'I-LOC', 'score': 0.9984837, 'index': 12, 'word': '##z', 'start': 49, 'end': 50}
{'entity': 'I-LOC', 'score': 0.93575835, 'index': 13, 'word': '.', 'start': 50, 'end': 51}
{'entity': 'I-PER', 'score': 0.7033568, 'index': 69, 'word': 'Walsh', 'start': 295, 'end': 300}
The disclosures are usually complicated, and people dont know what hit them.
The other thing that surprises consumers is that some mortgage companies do not return the mortgage application fees if the mortgage is not approved, but others, like Quicken Loans, say they return money if the mortgage is not used.
{'entity': 'B-ORG', 'score': 0.99914485, 'index': 30, 'word': 'Quick', 'start': 167, 'end': 172}
{'entity': 'I-ORG', 'score': 0.99824226, 'index': 31, 'word': '##en', 'start': 172, 'end': 174}
{'entity': 'I-ORG', 'score': 0.99889106, 'index': 32, 'word': 'Lo', 'start': 175, 'end': 177}
{'entity': 'I-ORG', 'score': 0.99816376, 'index': 33, 'word': '##ans', 'start': 177, 'end': 180}
Some states require lenders to disclose the annual percentage rate on any loans they advertise.
But legal specialists say it can be hard to enforce these and other consumer protection statutes.
Companies simply withdraw ads when they receive cease-and-desist letters, but the ads often immediately pop up elsewhere.
You do get an immediate positive feedback, said James E. Tierney, director of the national state attorneys general program at Columbia Law School in New York and a former attorney general. But its hard to make it a sustainable success since there are so many lenders and ads.
{'entity': 'B-PER', 'score': 0.99968755, 'index': 10, 'word': 'James', 'start': 50, 'end': 55}
{'entity': 'I-PER', 'score': 0.99676263, 'index': 11, 'word': 'E', 'start': 56, 'end': 57}
{'entity': 'I-PER', 'score': 0.99769753, 'index': 12, 'word': '.', 'start': 57, 'end': 58}
{'entity': 'I-PER', 'score': 0.9995335, 'index': 13, 'word': 'Tier', 'start': 59, 'end': 63}
{'entity': 'I-PER', 'score': 0.9985552, 'index': 14, 'word': '##ney', 'start': 63, 'end': 66}
{'entity': 'B-ORG', 'score': 0.99625283, 'index': 25, 'word': 'Columbia', 'start': 128, 'end': 136}
{'entity': 'I-ORG', 'score': 0.99583346, 'index': 26, 'word': 'Law', 'start': 137, 'end': 140}
{'entity': 'I-ORG', 'score': 0.9912926, 'index': 27, 'word': 'School', 'start': 141, 'end': 147}
{'entity': 'B-LOC', 'score': 0.99903125, 'index': 29, 'word': 'New', 'start': 151, 'end': 154}
{'entity': 'I-LOC', 'score': 0.999363, 'index': 30, 'word': 'York', 'start': 155, 'end': 159}
To Iran and Its Foes, an Indispensable Irritant
{'entity': 'B-LOC', 'score': 0.99981517, 'index': 2, 'word': 'Iran', 'start': 3, 'end': 7}
VIENNA  Late in August, Mohamed ElBaradei put the finishing touches on a nuclear accord negotiated in secret with Iran.
{'entity': 'B-ORG', 'score': 0.9705326, 'index': 1, 'word': 'VI', 'start': 0, 'end': 2}
{'entity': 'I-ORG', 'score': 0.8481481, 'index': 2, 'word': '##EN', 'start': 2, 'end': 4}
{'entity': 'I-ORG', 'score': 0.5401202, 'index': 3, 'word': '##NA', 'start': 4, 'end': 6}
{'entity': 'B-PER', 'score': 0.9997408, 'index': 8, 'word': 'Mohamed', 'start': 25, 'end': 32}
{'entity': 'I-PER', 'score': 0.9997436, 'index': 9, 'word': 'El', 'start': 33, 'end': 35}
{'entity': 'I-PER', 'score': 0.9994897, 'index': 10, 'word': '##B', 'start': 35, 'end': 36}
{'entity': 'I-PER', 'score': 0.99081385, 'index': 11, 'word': '##ara', 'start': 36, 'end': 39}
{'entity': 'I-PER', 'score': 0.97723806, 'index': 12, 'word': '##de', 'start': 39, 'end': 41}
{'entity': 'I-PER', 'score': 0.9893651, 'index': 13, 'word': '##i', 'start': 41, 'end': 42}
{'entity': 'B-LOC', 'score': 0.9997741, 'index': 26, 'word': 'Iran', 'start': 115, 'end': 119}
The deal would be divisive and risky, one of the biggest gambles of his 10 years as director general of the International Atomic Energy Agency.
{'entity': 'B-ORG', 'score': 0.99910456, 'index': 27, 'word': 'International', 'start': 108, 'end': 121}
{'entity': 'I-ORG', 'score': 0.9992556, 'index': 28, 'word': 'Atomic', 'start': 122, 'end': 128}
{'entity': 'I-ORG', 'score': 0.99927366, 'index': 29, 'word': 'Energy', 'start': 129, 'end': 135}
{'entity': 'I-ORG', 'score': 0.9991185, 'index': 30, 'word': 'Agency', 'start': 136, 'end': 142}
Iran would answer questions about its clandestine nuclear past in exchange for a series of concessions.
{'entity': 'B-LOC', 'score': 0.99985075, 'index': 1, 'word': 'Iran', 'start': 0, 'end': 4}
With no advance notice or media strategy, Dr. ElBaradei ordered the plan released in the evening.
{'entity': 'B-PER', 'score': 0.99903345, 'index': 11, 'word': 'El', 'start': 46, 'end': 48}
{'entity': 'I-PER', 'score': 0.9691794, 'index': 12, 'word': '##B', 'start': 48, 'end': 49}
{'entity': 'I-PER', 'score': 0.93004465, 'index': 13, 'word': '##ara', 'start': 49, 'end': 52}
{'entity': 'I-PER', 'score': 0.96418345, 'index': 14, 'word': '##de', 'start': 52, 'end': 54}
{'entity': 'I-PER', 'score': 0.72356266, 'index': 15, 'word': '##i', 'start': 54, 'end': 55}
And then he waited.
The next day, diplomats from the United States, France, Britain and Germany marched into his office atop a Vienna skyscraper to deliver a joint protest.
{'entity': 'B-LOC', 'score': 0.999698, 'index': 9, 'word': 'United', 'start': 33, 'end': 39}
{'entity': 'I-LOC', 'score': 0.99928874, 'index': 10, 'word': 'States', 'start': 40, 'end': 46}
{'entity': 'B-LOC', 'score': 0.9997471, 'index': 12, 'word': 'France', 'start': 48, 'end': 54}
{'entity': 'B-LOC', 'score': 0.9997635, 'index': 14, 'word': 'Britain', 'start': 56, 'end': 63}
{'entity': 'B-LOC', 'score': 0.9997743, 'index': 16, 'word': 'Germany', 'start': 68, 'end': 75}
{'entity': 'B-LOC', 'score': 0.9997774, 'index': 23, 'word': 'Vienna', 'start': 107, 'end': 113}
The deal, they said, amounted to irresponsible meddling that threatened to undermine a United Nations Security Council strategy to punish, not reward, Tehran.
{'entity': 'B-ORG', 'score': 0.9992087, 'index': 20, 'word': 'United', 'start': 87, 'end': 93}
{'entity': 'I-ORG', 'score': 0.99936926, 'index': 21, 'word': 'Nations', 'start': 94, 'end': 101}
{'entity': 'I-ORG', 'score': 0.9994451, 'index': 22, 'word': 'Security', 'start': 102, 'end': 110}
{'entity': 'I-ORG', 'score': 0.9992097, 'index': 23, 'word': 'Council', 'start': 111, 'end': 118}
{'entity': 'B-LOC', 'score': 0.998912, 'index': 31, 'word': 'Tehran', 'start': 151, 'end': 157}
Dr. ElBaradei, an Egyptian-born lawyer, was polite but firm. If Iran wants to answer questions, what am I supposed to do, tell them it cant? he asked.
{'entity': 'B-PER', 'score': 0.99845225, 'index': 3, 'word': 'El', 'start': 4, 'end': 6}
{'entity': 'I-PER', 'score': 0.9885898, 'index': 4, 'word': '##B', 'start': 6, 'end': 7}
{'entity': 'I-PER', 'score': 0.9689526, 'index': 5, 'word': '##ara', 'start': 7, 'end': 10}
{'entity': 'I-PER', 'score': 0.98283416, 'index': 6, 'word': '##de', 'start': 10, 'end': 12}
{'entity': 'I-PER', 'score': 0.9904167, 'index': 7, 'word': '##i', 'start': 12, 'end': 13}
{'entity': 'B-MISC', 'score': 0.9971016, 'index': 10, 'word': 'Egyptian', 'start': 18, 'end': 26}
{'entity': 'B-LOC', 'score': 0.99984664, 'index': 21, 'word': 'Iran', 'start': 65, 'end': 69}
Then, brandishing one of his characteristic mangled metaphors, he dismissed his critics as living room coaches who shoot from the hip.
Almost five years after he stood up to the Bush administration on Iraq and then won the Nobel Peace Prize for his trouble, Dr. ElBaradei now finds himself at the center of the Wests turbulent confrontation with Iran, derided yet relied upon by all sides.
{'entity': 'B-PER', 'score': 0.9987824, 'index': 10, 'word': 'Bush', 'start': 43, 'end': 47}
{'entity': 'B-LOC', 'score': 0.9998382, 'index': 13, 'word': 'Iraq', 'start': 66, 'end': 70}
{'entity': 'B-MISC', 'score': 0.99777305, 'index': 18, 'word': 'Nobel', 'start': 88, 'end': 93}
{'entity': 'I-MISC', 'score': 0.99841934, 'index': 19, 'word': 'Peace', 'start': 94, 'end': 99}
{'entity': 'I-MISC', 'score': 0.99874806, 'index': 20, 'word': 'Prize', 'start': 100, 'end': 105}
{'entity': 'B-PER', 'score': 0.9981833, 'index': 27, 'word': 'El', 'start': 127, 'end': 129}
{'entity': 'I-PER', 'score': 0.9790795, 'index': 28, 'word': '##B', 'start': 129, 'end': 130}
{'entity': 'I-PER', 'score': 0.9125224, 'index': 29, 'word': '##ara', 'start': 130, 'end': 133}
{'entity': 'I-PER', 'score': 0.9702851, 'index': 30, 'word': '##de', 'start': 133, 'end': 135}
{'entity': 'I-PER', 'score': 0.855005, 'index': 31, 'word': '##i', 'start': 135, 'end': 136}
{'entity': 'B-MISC', 'score': 0.89109504, 'index': 40, 'word': 'West', 'start': 176, 'end': 180}
{'entity': 'B-LOC', 'score': 0.99981725, 'index': 45, 'word': 'Iran', 'start': 212, 'end': 216}
To his critics in the West, he is guilty of serious diplomatic sins  bias toward Iran, recklessness and, above all, a naïve grandiosity that leads him to reach far beyond his station.
{'entity': 'B-MISC', 'score': 0.66873366, 'index': 6, 'word': 'West', 'start': 22, 'end': 26}
{'entity': 'B-LOC', 'score': 0.99984694, 'index': 17, 'word': 'Iran', 'start': 82, 'end': 86}
Over the past year, even before he unveiled his deal with Tehran, Western governments had presented him with a flurry of formal protests over his stewardship of the Iran case.
{'entity': 'B-LOC', 'score': 0.99957794, 'index': 13, 'word': 'Tehran', 'start': 58, 'end': 64}
{'entity': 'B-MISC', 'score': 0.9997319, 'index': 15, 'word': 'Western', 'start': 66, 'end': 73}
{'entity': 'B-LOC', 'score': 0.99983597, 'index': 34, 'word': 'Iran', 'start': 165, 'end': 169}
Even some of his own staff members have become restive, questioning his leadership and what they see as his sympathy for the Iranians, according to diplomats here.
{'entity': 'B-MISC', 'score': 0.999571, 'index': 25, 'word': 'Iranian', 'start': 125, 'end': 132}
Yet the Iranians also seek to humiliate him and block his inspectors.
{'entity': 'B-MISC', 'score': 0.9992046, 'index': 3, 'word': 'Iranian', 'start': 8, 'end': 15}
He is the man in the middle, said Lee H. Hamilton, a former Democratic congressman long respected for his foreign affairs acumen. The United States and Iran simply do not believe one another.
{'entity': 'B-PER', 'score': 0.99960166, 'index': 10, 'word': 'Lee', 'start': 36, 'end': 39}
{'entity': 'I-PER', 'score': 0.9986429, 'index': 11, 'word': 'H', 'start': 40, 'end': 41}
{'entity': 'I-PER', 'score': 0.996853, 'index': 12, 'word': '.', 'start': 41, 'end': 42}
{'entity': 'I-PER', 'score': 0.99961203, 'index': 13, 'word': 'Hamilton', 'start': 43, 'end': 51}
{'entity': 'B-MISC', 'score': 0.9996931, 'index': 17, 'word': 'Democratic', 'start': 62, 'end': 72}
{'entity': 'B-LOC', 'score': 0.99977595, 'index': 31, 'word': 'United', 'start': 137, 'end': 143}
{'entity': 'I-LOC', 'score': 0.9994808, 'index': 32, 'word': 'States', 'start': 144, 'end': 150}
{'entity': 'B-LOC', 'score': 0.99982685, 'index': 34, 'word': 'Iran', 'start': 155, 'end': 159}
There is deep distrust. And, he added, that makes the situation very difficult for any go-between.
Even so, while Dr. ElBaradeis harshest detractors describe him as drunk with the power of his Nobel, what keeps him on center stage is a pragmatic truth: He is everyones best hope.
{'entity': 'B-PER', 'score': 0.9985383, 'index': 7, 'word': 'El', 'start': 19, 'end': 21}
{'entity': 'I-PER', 'score': 0.9855077, 'index': 8, 'word': '##B', 'start': 21, 'end': 22}
{'entity': 'I-PER', 'score': 0.9424128, 'index': 9, 'word': '##ara', 'start': 22, 'end': 25}
{'entity': 'I-PER', 'score': 0.87890375, 'index': 10, 'word': '##de', 'start': 25, 'end': 27}
{'entity': 'B-MISC', 'score': 0.9400293, 'index': 26, 'word': 'Nobel', 'start': 95, 'end': 100}
He has grown ever more indispensable as American credibility on atomic intelligence has nose-dived and European diplomacy with Tehran has stalled.
{'entity': 'B-MISC', 'score': 0.9997882, 'index': 11, 'word': 'American', 'start': 40, 'end': 48}
{'entity': 'B-MISC', 'score': 0.9997647, 'index': 22, 'word': 'European', 'start': 103, 'end': 111}
{'entity': 'B-LOC', 'score': 0.9995075, 'index': 25, 'word': 'Tehran', 'start': 127, 'end': 133}
For the world powers, he is far and away the best source of knowledge about Irans nuclear progress  information Washington uses regularly to portray Tehran as an imminent global danger.
{'entity': 'B-LOC', 'score': 0.96969557, 'index': 17, 'word': 'Iran', 'start': 76, 'end': 80}
{'entity': 'B-LOC', 'score': 0.9979456, 'index': 22, 'word': 'Washington', 'start': 114, 'end': 124}
{'entity': 'B-LOC', 'score': 0.99965674, 'index': 27, 'word': 'Tehran', 'start': 151, 'end': 157}
Even the Iranians need him (as he likes to remind them) because his maneuvers promise to lessen and perhaps end the sting of United Nations sanctions.
{'entity': 'B-MISC', 'score': 0.9994703, 'index': 3, 'word': 'Iranian', 'start': 9, 'end': 16}
{'entity': 'B-ORG', 'score': 0.9965853, 'index': 28, 'word': 'United', 'start': 125, 'end': 131}
{'entity': 'I-ORG', 'score': 0.9916908, 'index': 29, 'word': 'Nations', 'start': 132, 'end': 139}
Dr. ElBaradei, who is 65, seems unfazed, even energized, by all the dissent.
{'entity': 'B-PER', 'score': 0.99912417, 'index': 3, 'word': 'El', 'start': 4, 'end': 6}
{'entity': 'I-PER', 'score': 0.9905679, 'index': 4, 'word': '##B', 'start': 6, 'end': 7}
{'entity': 'I-PER', 'score': 0.9655642, 'index': 5, 'word': '##ara', 'start': 7, 'end': 10}
{'entity': 'I-PER', 'score': 0.9694013, 'index': 6, 'word': '##de', 'start': 10, 'end': 12}
{'entity': 'I-PER', 'score': 0.87059414, 'index': 7, 'word': '##i', 'start': 12, 'end': 13}
He alludes to a sense of destiny that has pressed him into the role of world peacemaker.
He has called those who advocate war against Iran crazies, and in two long recent interviews described himself as a secular pope whose mission is to make sure, frankly, that we do not end up killing each other.
{'entity': 'B-LOC', 'score': 0.9998455, 'index': 9, 'word': 'Iran', 'start': 45, 'end': 49}
He added, You meet someone in the street  and I do a lot  and someone will tell me, You are doing Gods work, and that will keep me going for quite a while.
{'entity': 'B-ORG', 'score': 0.3013846, 'index': 24, 'word': 'Gods', 'start': 102, 'end': 107}
It is precisely that self-invented role that enrages his detractors.
They say he has stepped dangerously beyond the mandate of the I.A.E.A., a United Nations agency best known for inspecting atomic installations in an effort to find and deter secret work on nuclear arms.
{'entity': 'B-ORG', 'score': 0.9511002, 'index': 12, 'word': 'I', 'start': 62, 'end': 63}
{'entity': 'I-ORG', 'score': 0.97567576, 'index': 14, 'word': 'A', 'start': 64, 'end': 65}
{'entity': 'I-ORG', 'score': 0.98404914, 'index': 16, 'word': 'E', 'start': 66, 'end': 67}
{'entity': 'I-ORG', 'score': 0.552425, 'index': 17, 'word': '.', 'start': 67, 'end': 68}
{'entity': 'I-ORG', 'score': 0.9845716, 'index': 18, 'word': 'A', 'start': 68, 'end': 69}
{'entity': 'B-ORG', 'score': 0.9989391, 'index': 22, 'word': 'United', 'start': 74, 'end': 80}
{'entity': 'I-ORG', 'score': 0.9987036, 'index': 23, 'word': 'Nations', 'start': 81, 'end': 88}
Instead of being the head of a technical agency, whose job is to monitor these agreements, and come up with objective assessments, he has become a world policy maker, an advocate, said Robert J. Einhorn, the State Departments nonproliferation director from 1999 to 2001.
{'entity': 'B-PER', 'score': 0.9996408, 'index': 38, 'word': 'Robert', 'start': 187, 'end': 193}
{'entity': 'I-PER', 'score': 0.99443024, 'index': 39, 'word': 'J', 'start': 194, 'end': 195}
{'entity': 'I-PER', 'score': 0.9946364, 'index': 40, 'word': '.', 'start': 195, 'end': 196}
{'entity': 'I-PER', 'score': 0.9996311, 'index': 41, 'word': 'Ein', 'start': 197, 'end': 200}
{'entity': 'I-PER', 'score': 0.9985248, 'index': 42, 'word': '##horn', 'start': 200, 'end': 204}
{'entity': 'B-ORG', 'score': 0.9942028, 'index': 45, 'word': 'State', 'start': 210, 'end': 215}
{'entity': 'I-ORG', 'score': 0.9974462, 'index': 46, 'word': 'Department', 'start': 216, 'end': 226}
In particular, Dr. ElBaradei is faulted for his new deal with Iran, which has defied repeated Security Council demands to suspend its enrichment of uranium.
{'entity': 'B-PER', 'score': 0.99920017, 'index': 6, 'word': 'El', 'start': 19, 'end': 21}
{'entity': 'I-PER', 'score': 0.9945402, 'index': 7, 'word': '##B', 'start': 21, 'end': 22}
{'entity': 'I-PER', 'score': 0.9835086, 'index': 8, 'word': '##ara', 'start': 22, 'end': 25}
{'entity': 'I-PER', 'score': 0.98795223, 'index': 9, 'word': '##de', 'start': 25, 'end': 27}
{'entity': 'I-PER', 'score': 0.9582736, 'index': 10, 'word': '##i', 'start': 27, 'end': 28}
{'entity': 'B-LOC', 'score': 0.999819, 'index': 19, 'word': 'Iran', 'start': 62, 'end': 66}
{'entity': 'B-ORG', 'score': 0.99831486, 'index': 26, 'word': 'Security', 'start': 94, 'end': 102}
{'entity': 'I-ORG', 'score': 0.99817616, 'index': 27, 'word': 'Council', 'start': 103, 'end': 110}
Critics say the plan threatens to buy Iran more time to master that technology, which can make fuel for reactors or atomic bombs.
{'entity': 'B-LOC', 'score': 0.9998625, 'index': 8, 'word': 'Iran', 'start': 38, 'end': 42}
Despite Irans long history of nuclear deception, Dr. ElBaradeis supporters cite his vindication on Iraq  no evidence of an active Iraqi nuclear program has been found  as reason to listen to him now.
{'entity': 'B-LOC', 'score': 0.98428327, 'index': 2, 'word': 'Iran', 'start': 8, 'end': 12}
{'entity': 'B-PER', 'score': 0.9992278, 'index': 12, 'word': 'El', 'start': 54, 'end': 56}
{'entity': 'I-PER', 'score': 0.9834442, 'index': 13, 'word': '##B', 'start': 56, 'end': 57}
{'entity': 'I-PER', 'score': 0.8459556, 'index': 14, 'word': '##ara', 'start': 57, 'end': 60}
{'entity': 'I-PER', 'score': 0.9348844, 'index': 15, 'word': '##de', 'start': 60, 'end': 62}
{'entity': 'I-PER', 'score': 0.40372416, 'index': 16, 'word': '##is', 'start': 62, 'end': 65}
{'entity': 'B-LOC', 'score': 0.9997681, 'index': 26, 'word': 'Iraq', 'start': 101, 'end': 105}
{'entity': 'B-MISC', 'score': 0.99977607, 'index': 32, 'word': 'Iraqi', 'start': 133, 'end': 138}
He could have saved us a disastrous war if we had paid attention to him, said Thomas M. Franck, an international law professor emeritus at New York University Law School, who taught Dr. ElBaradei there decades ago and has remained a close friend.
{'entity': 'B-PER', 'score': 0.9996911, 'index': 18, 'word': 'Thomas', 'start': 80, 'end': 86}
{'entity': 'I-PER', 'score': 0.99746203, 'index': 19, 'word': 'M', 'start': 87, 'end': 88}
{'entity': 'I-PER', 'score': 0.99761003, 'index': 20, 'word': '.', 'start': 88, 'end': 89}
{'entity': 'I-PER', 'score': 0.9994817, 'index': 21, 'word': 'Fr', 'start': 90, 'end': 92}
{'entity': 'I-PER', 'score': 0.992311, 'index': 22, 'word': '##an', 'start': 92, 'end': 94}
{'entity': 'I-PER', 'score': 0.98887414, 'index': 23, 'word': '##ck', 'start': 94, 'end': 96}
{'entity': 'B-ORG', 'score': 0.9792038, 'index': 31, 'word': 'New', 'start': 141, 'end': 144}
{'entity': 'I-ORG', 'score': 0.9320358, 'index': 32, 'word': 'York', 'start': 145, 'end': 149}
{'entity': 'I-ORG', 'score': 0.9703746, 'index': 33, 'word': 'University', 'start': 150, 'end': 160}
{'entity': 'I-ORG', 'score': 0.9548233, 'index': 34, 'word': 'Law', 'start': 161, 'end': 164}
{'entity': 'I-ORG', 'score': 0.980176, 'index': 35, 'word': 'School', 'start': 165, 'end': 171}
{'entity': 'B-PER', 'score': 0.99349546, 'index': 41, 'word': 'El', 'start': 188, 'end': 190}
{'entity': 'I-PER', 'score': 0.92624027, 'index': 42, 'word': '##B', 'start': 190, 'end': 191}
{'entity': 'I-PER', 'score': 0.80944484, 'index': 43, 'word': '##ara', 'start': 191, 'end': 194}
{'entity': 'I-PER', 'score': 0.81369895, 'index': 44, 'word': '##de', 'start': 194, 'end': 196}
After the Iran accord became public, The Washington Post published an editorial branding Dr. ElBaradei a Rogue Regulator. His wife, Aida, who is his closest political adviser, came up with a response  T-shirts that succinctly frame the ElBaradei debate: Rogue regulator will be stenciled on the front, Or smooth operator? on the back.
{'entity': 'B-LOC', 'score': 0.9994339, 'index': 3, 'word': 'Iran', 'start': 10, 'end': 14}
{'entity': 'B-ORG', 'score': 0.9990691, 'index': 8, 'word': 'The', 'start': 37, 'end': 40}
{'entity': 'I-ORG', 'score': 0.9991665, 'index': 9, 'word': 'Washington', 'start': 41, 'end': 51}
{'entity': 'I-ORG', 'score': 0.998971, 'index': 10, 'word': 'Post', 'start': 52, 'end': 56}
{'entity': 'B-PER', 'score': 0.99592817, 'index': 17, 'word': 'El', 'start': 93, 'end': 95}
{'entity': 'I-PER', 'score': 0.8901868, 'index': 18, 'word': '##B', 'start': 95, 'end': 96}
{'entity': 'I-PER', 'score': 0.44686088, 'index': 19, 'word': '##ara', 'start': 96, 'end': 99}
{'entity': 'I-PER', 'score': 0.55377287, 'index': 20, 'word': '##de', 'start': 99, 'end': 101}
{'entity': 'B-MISC', 'score': 0.4356052, 'index': 23, 'word': 'Rogue', 'start': 106, 'end': 111}
{'entity': 'I-MISC', 'score': 0.56298715, 'index': 24, 'word': 'Reg', 'start': 112, 'end': 115}
{'entity': 'I-MISC', 'score': 0.8195661, 'index': 25, 'word': '##ulator', 'start': 115, 'end': 121}
{'entity': 'B-PER', 'score': 0.973154, 'index': 30, 'word': 'Aid', 'start': 134, 'end': 137}
{'entity': 'B-PER', 'score': 0.67097056, 'index': 31, 'word': '##a', 'start': 137, 'end': 138}
{'entity': 'B-PER', 'score': 0.88462186, 'index': 55, 'word': 'El', 'start': 239, 'end': 241}
{'entity': 'I-PER', 'score': 0.49029648, 'index': 56, 'word': '##B', 'start': 241, 'end': 242}
{'entity': 'I-ORG', 'score': 0.59596056, 'index': 57, 'word': '##ara', 'start': 242, 'end': 245}
{'entity': 'I-ORG', 'score': 0.5405236, 'index': 58, 'word': '##de', 'start': 245, 'end': 247}
Ambitious, but Reserved
When Dr. ElBaradei received the Nobel Prize in December 2005, he used his acceptance speech to lay out an ambitious agenda  helping the poor, saving the environment, fighting crime and confronting new dangers spawned by globalization.
{'entity': 'B-PER', 'score': 0.99941254, 'index': 4, 'word': 'El', 'start': 9, 'end': 11}
{'entity': 'I-PER', 'score': 0.9870825, 'index': 5, 'word': '##B', 'start': 11, 'end': 12}
{'entity': 'I-PER', 'score': 0.9649724, 'index': 6, 'word': '##ara', 'start': 12, 'end': 15}
{'entity': 'I-PER', 'score': 0.97425336, 'index': 7, 'word': '##de', 'start': 15, 'end': 17}
{'entity': 'I-PER', 'score': 0.8192089, 'index': 8, 'word': '##i', 'start': 17, 'end': 18}
{'entity': 'B-MISC', 'score': 0.99721664, 'index': 11, 'word': 'Nobel', 'start': 32, 'end': 37}
{'entity': 'I-MISC', 'score': 0.9979534, 'index': 12, 'word': 'Prize', 'start': 38, 'end': 43}
We cannot respond to these threats by building more walls, developing bigger weapons, or dispatching more troops, he said. Quite to the contrary, by their very nature, these security threats require primarily international cooperation.
Yet Dr. ElBaradeis expansive view of himself is a striking counterpoint to his personal style.
{'entity': 'B-PER', 'score': 0.99914885, 'index': 4, 'word': 'El', 'start': 8, 'end': 10}
{'entity': 'I-PER', 'score': 0.97215307, 'index': 5, 'word': '##B', 'start': 10, 'end': 11}
{'entity': 'I-PER', 'score': 0.9305427, 'index': 6, 'word': '##ara', 'start': 11, 'end': 14}
{'entity': 'I-PER', 'score': 0.9084589, 'index': 7, 'word': '##de', 'start': 14, 'end': 16}
That Nobel night, he was celebrating with friends in his suite at the Grand Hotel in Oslo when thousands of people appeared on the street below, holding candles and cheering.
{'entity': 'B-MISC', 'score': 0.9958325, 'index': 2, 'word': 'Nobel', 'start': 5, 'end': 10}
{'entity': 'B-LOC', 'score': 0.9435856, 'index': 15, 'word': 'Grand', 'start': 70, 'end': 75}
{'entity': 'I-LOC', 'score': 0.96769327, 'index': 16, 'word': 'Hotel', 'start': 76, 'end': 81}
{'entity': 'B-LOC', 'score': 0.9992853, 'index': 18, 'word': 'Oslo', 'start': 85, 'end': 89}
Unsure of himself, he froze.
He was clearly nonplused and adrift at what to do, Mr. Franck recalled. His wife told him to wave back.
{'entity': 'B-PER', 'score': 0.99230444, 'index': 18, 'word': 'Fr', 'start': 57, 'end': 59}
{'entity': 'B-PER', 'score': 0.65871763, 'index': 19, 'word': '##an', 'start': 59, 'end': 61}
A tall, shy man with a salt-and-pepper mustache, Dr. ElBaradei is so averse to small talk that he refuses even superficial conversation with staff members in the agencys elevators, aides say.
{'entity': 'B-PER', 'score': 0.9983388, 'index': 18, 'word': 'El', 'start': 53, 'end': 55}
{'entity': 'I-PER', 'score': 0.9486067, 'index': 19, 'word': '##B', 'start': 55, 'end': 56}
{'entity': 'I-PER', 'score': 0.8530084, 'index': 20, 'word': '##ara', 'start': 56, 'end': 59}
{'entity': 'I-PER', 'score': 0.771591, 'index': 21, 'word': '##de', 'start': 59, 'end': 61}
Rather than venture into the dining room or cafeteria, he brings lunch from home and eats at his desk.
He must be arm-twisted to make even the briefest appearance at important agency functions.
He is very reserved, very aloof, Mrs. ElBaradei said recently over tea in their apartment, filled with rugs from Iran and the awards and other baubles that come with her husbands persona as a campaigner for world peace. He thinks these diplomatic receptions and dinners are a waste of time.
{'entity': 'B-PER', 'score': 0.9971739, 'index': 12, 'word': 'El', 'start': 40, 'end': 42}
{'entity': 'I-PER', 'score': 0.87606853, 'index': 13, 'word': '##B', 'start': 42, 'end': 43}
{'entity': 'I-PER', 'score': 0.6369375, 'index': 14, 'word': '##ara', 'start': 43, 'end': 46}
{'entity': 'I-PER', 'score': 0.888053, 'index': 15, 'word': '##de', 'start': 46, 'end': 48}
{'entity': 'I-PER', 'score': 0.49969506, 'index': 16, 'word': '##i', 'start': 48, 'end': 49}
{'entity': 'B-LOC', 'score': 0.9998369, 'index': 30, 'word': 'Iran', 'start': 115, 'end': 119}
He shares confidences with only a handful of associates. He doesnt have meetings where he seeks input, said one former agency official, who like some others would speak about Dr. ElBaradei only on the condition of anonymity. Its, Heres what I want to do. 
{'entity': 'B-PER', 'score': 0.9969186, 'index': 37, 'word': 'El', 'start': 182, 'end': 184}
{'entity': 'I-PER', 'score': 0.93202424, 'index': 38, 'word': '##B', 'start': 184, 'end': 185}
{'entity': 'I-PER', 'score': 0.6557308, 'index': 39, 'word': '##ara', 'start': 185, 'end': 188}
{'entity': 'I-PER', 'score': 0.7864874, 'index': 40, 'word': '##de', 'start': 188, 'end': 190}
He has become a compulsive name-dropper, diplomats say. He remains a shy man, but one who is somehow dazzled by his own destiny, said one European nonproliferation official who knows him well. Hes always saying, Oh, I talked to Condi last week and she told me this, or I was with Putin and he said this or that. Hes almost like a child.
{'entity': 'B-MISC', 'score': 0.9997275, 'index': 38, 'word': 'European', 'start': 140, 'end': 148}
{'entity': 'B-PER', 'score': 0.99915695, 'index': 60, 'word': 'Con', 'start': 233, 'end': 236}
{'entity': 'B-PER', 'score': 0.83061296, 'index': 61, 'word': '##di', 'start': 236, 'end': 238}
{'entity': 'B-PER', 'score': 0.9990849, 'index': 74, 'word': 'Putin', 'start': 287, 'end': 292}
The eldest of five children from an upper-middle-class family in Cairo, Dr. ElBaradei grew up with a French nanny and a private school education.
{'entity': 'B-LOC', 'score': 0.9996071, 'index': 15, 'word': 'Cairo', 'start': 65, 'end': 70}
{'entity': 'B-PER', 'score': 0.9982165, 'index': 19, 'word': 'El', 'start': 76, 'end': 78}
{'entity': 'I-PER', 'score': 0.9188946, 'index': 20, 'word': '##B', 'start': 78, 'end': 79}
{'entity': 'I-PER', 'score': 0.8044279, 'index': 21, 'word': '##ara', 'start': 79, 'end': 82}
{'entity': 'I-PER', 'score': 0.8961294, 'index': 22, 'word': '##de', 'start': 82, 'end': 84}
{'entity': 'I-PER', 'score': 0.5097389, 'index': 23, 'word': '##i', 'start': 84, 'end': 85}
{'entity': 'B-MISC', 'score': 0.9997035, 'index': 28, 'word': 'French', 'start': 101, 'end': 107}
At 19, he became the national youth champion in squash. You have to be cunning, he said of the sport.
His father, a lawyer, was the head of Egypts bar association.
{'entity': 'B-LOC', 'score': 0.8526428, 'index': 11, 'word': 'Egypt', 'start': 38, 'end': 43}
The son studied law and joined the foreign service, eventually serving in New York.
{'entity': 'B-LOC', 'score': 0.9994378, 'index': 14, 'word': 'New', 'start': 74, 'end': 77}
{'entity': 'I-LOC', 'score': 0.9993888, 'index': 15, 'word': 'York', 'start': 78, 'end': 82}
Living there in the late 1960s and early 70s was so transforming, he said, that today he feels greater kinship with New York than Cairo, more comfortable speaking English than Arabic.
{'entity': 'B-LOC', 'score': 0.9988171, 'index': 25, 'word': 'New', 'start': 117, 'end': 120}
{'entity': 'I-LOC', 'score': 0.99931574, 'index': 26, 'word': 'York', 'start': 121, 'end': 125}
{'entity': 'B-LOC', 'score': 0.99948233, 'index': 28, 'word': 'Cairo', 'start': 131, 'end': 136}
{'entity': 'B-MISC', 'score': 0.9993639, 'index': 33, 'word': 'English', 'start': 164, 'end': 171}
{'entity': 'B-MISC', 'score': 0.99915296, 'index': 35, 'word': 'Arabic', 'start': 177, 'end': 183}
While working on his doctorate on international law at New York University, he went to New York Knicks basketball games and to the Metropolitan Opera, and stayed up late talking American politics and drinking wine in Greenwich Village bars.
{'entity': 'B-ORG', 'score': 0.96896183, 'index': 10, 'word': 'New', 'start': 55, 'end': 58}
{'entity': 'I-ORG', 'score': 0.9331936, 'index': 11, 'word': 'York', 'start': 59, 'end': 63}
{'entity': 'I-ORG', 'score': 0.965425, 'index': 12, 'word': 'University', 'start': 64, 'end': 74}
{'entity': 'B-ORG', 'score': 0.9101403, 'index': 17, 'word': 'New', 'start': 87, 'end': 90}
{'entity': 'I-ORG', 'score': 0.8181208, 'index': 18, 'word': 'York', 'start': 91, 'end': 95}
{'entity': 'I-ORG', 'score': 0.9731988, 'index': 19, 'word': 'K', 'start': 96, 'end': 97}
{'entity': 'I-ORG', 'score': 0.975645, 'index': 20, 'word': '##nick', 'start': 97, 'end': 101}
{'entity': 'I-ORG', 'score': 0.9782739, 'index': 21, 'word': '##s', 'start': 101, 'end': 102}
{'entity': 'B-ORG', 'score': 0.7399791, 'index': 27, 'word': 'Metropolitan', 'start': 131, 'end': 143}
{'entity': 'I-ORG', 'score': 0.4591756, 'index': 28, 'word': 'Opera', 'start': 144, 'end': 149}
{'entity': 'B-MISC', 'score': 0.9997387, 'index': 35, 'word': 'American', 'start': 178, 'end': 186}
{'entity': 'B-LOC', 'score': 0.99023426, 'index': 41, 'word': 'Greenwich', 'start': 217, 'end': 226}
{'entity': 'I-LOC', 'score': 0.9972265, 'index': 42, 'word': 'Village', 'start': 227, 'end': 234}
His first girlfriend, he said, was Jewish.
{'entity': 'B-MISC', 'score': 0.9982721, 'index': 9, 'word': 'Jewish', 'start': 35, 'end': 41}
Moving up the diplomatic ladder, he eventually settled in Vienna, where he became the nuclear agencys legal counselor and then head of external relations.
{'entity': 'B-LOC', 'score': 0.9995613, 'index': 11, 'word': 'Vienna', 'start': 58, 'end': 64}
His ascent to the top job, in 1997, was a surprise.
After none of the proposed candidates received the needed votes, the American ambassador to the agency at the time, John Ritch, led a quiet campaign for Dr. ElBaradei, a close friend.
{'entity': 'B-MISC', 'score': 0.9997695, 'index': 13, 'word': 'American', 'start': 69, 'end': 77}
{'entity': 'B-PER', 'score': 0.99966174, 'index': 22, 'word': 'John', 'start': 116, 'end': 120}
{'entity': 'I-PER', 'score': 0.9994263, 'index': 23, 'word': 'R', 'start': 121, 'end': 122}
{'entity': 'I-PER', 'score': 0.9989173, 'index': 24, 'word': '##itch', 'start': 122, 'end': 126}
{'entity': 'B-PER', 'score': 0.99776024, 'index': 33, 'word': 'El', 'start': 157, 'end': 159}
{'entity': 'I-PER', 'score': 0.9459234, 'index': 34, 'word': '##B', 'start': 159, 'end': 160}
{'entity': 'I-PER', 'score': 0.8444503, 'index': 35, 'word': '##ara', 'start': 160, 'end': 163}
{'entity': 'I-PER', 'score': 0.824742, 'index': 36, 'word': '##de', 'start': 163, 'end': 165}
{'entity': 'I-PER', 'score': 0.6614213, 'index': 37, 'word': '##i', 'start': 165, 'end': 166}
In a cable to Washington, Mr. Ritch recalled, he said the United States could do no better than backing an Egyptian who is a passionate Knicks fan.
{'entity': 'B-LOC', 'score': 0.99959284, 'index': 5, 'word': 'Washington', 'start': 14, 'end': 24}
{'entity': 'B-PER', 'score': 0.99596536, 'index': 9, 'word': 'R', 'start': 30, 'end': 31}
{'entity': 'B-PER', 'score': 0.9282992, 'index': 10, 'word': '##itch', 'start': 31, 'end': 35}
{'entity': 'B-LOC', 'score': 0.99971616, 'index': 16, 'word': 'United', 'start': 58, 'end': 64}
{'entity': 'I-LOC', 'score': 0.9994206, 'index': 17, 'word': 'States', 'start': 65, 'end': 71}
{'entity': 'B-MISC', 'score': 0.99971515, 'index': 25, 'word': 'Egyptian', 'start': 108, 'end': 116}
{'entity': 'B-ORG', 'score': 0.97678995, 'index': 30, 'word': 'K', 'start': 137, 'end': 138}
{'entity': 'I-ORG', 'score': 0.9222407, 'index': 31, 'word': '##nick', 'start': 138, 'end': 142}
{'entity': 'I-ORG', 'score': 0.93190914, 'index': 32, 'word': '##s', 'start': 142, 'end': 143}
Dr. ElBaradei started out with the modest goal of reorganizing the agency, which today has about 2,300 employees.
{'entity': 'B-PER', 'score': 0.98674345, 'index': 3, 'word': 'El', 'start': 4, 'end': 6}
{'entity': 'I-PER', 'score': 0.947515, 'index': 4, 'word': '##B', 'start': 6, 'end': 7}
{'entity': 'I-PER', 'score': 0.9296417, 'index': 5, 'word': '##ara', 'start': 7, 'end': 10}
{'entity': 'I-PER', 'score': 0.89100236, 'index': 6, 'word': '##de', 'start': 10, 'end': 12}
{'entity': 'I-PER', 'score': 0.4066792, 'index': 7, 'word': '##i', 'start': 12, 'end': 13}
Then came Iraq.
{'entity': 'B-LOC', 'score': 0.99981844, 'index': 3, 'word': 'Iraq', 'start': 10, 'end': 14}
Before the war, the Bush administration repeatedly warned of Saddam Hussein getting the bomb, and called on atomic inspectors to confirm that view.
{'entity': 'B-PER', 'score': 0.9989946, 'index': 6, 'word': 'Bush', 'start': 20, 'end': 24}
{'entity': 'B-PER', 'score': 0.9991659, 'index': 11, 'word': 'Saddam', 'start': 61, 'end': 67}
{'entity': 'I-PER', 'score': 0.9968105, 'index': 12, 'word': 'Hussein', 'start': 68, 'end': 75}
Instead, in March 2003, Dr. ElBaradei told the Security Council that after hundreds of inspections over three months, his teams had found no evidence or plausible indication of the revival of a nuclear weapons program. And while President Bush charged that Iraq was trying to buy uranium in Africa, Dr. ElBaradei dismissed the underlying intelligence as not authentic.
{'entity': 'B-PER', 'score': 0.9991091, 'index': 9, 'word': 'El', 'start': 28, 'end': 30}
{'entity': 'I-PER', 'score': 0.9839413, 'index': 10, 'word': '##B', 'start': 30, 'end': 31}
{'entity': 'I-PER', 'score': 0.95987684, 'index': 11, 'word': '##ara', 'start': 31, 'end': 34}
{'entity': 'I-PER', 'score': 0.98274046, 'index': 12, 'word': '##de', 'start': 34, 'end': 36}
{'entity': 'I-PER', 'score': 0.77340454, 'index': 13, 'word': '##i', 'start': 36, 'end': 37}
{'entity': 'B-ORG', 'score': 0.99930006, 'index': 16, 'word': 'Security', 'start': 47, 'end': 55}
{'entity': 'I-ORG', 'score': 0.9991195, 'index': 17, 'word': 'Council', 'start': 56, 'end': 63}
{'entity': 'B-PER', 'score': 0.99958783, 'index': 49, 'word': 'Bush', 'start': 241, 'end': 245}
{'entity': 'B-LOC', 'score': 0.99984133, 'index': 52, 'word': 'Iraq', 'start': 259, 'end': 263}
{'entity': 'B-LOC', 'score': 0.99975806, 'index': 59, 'word': 'Africa', 'start': 293, 'end': 299}
{'entity': 'B-PER', 'score': 0.999138, 'index': 63, 'word': 'El', 'start': 305, 'end': 307}
{'entity': 'I-PER', 'score': 0.9909662, 'index': 64, 'word': '##B', 'start': 307, 'end': 308}
{'entity': 'I-PER', 'score': 0.95161104, 'index': 65, 'word': '##ara', 'start': 308, 'end': 311}
{'entity': 'I-PER', 'score': 0.9795795, 'index': 66, 'word': '##de', 'start': 311, 'end': 313}
The invasion, 13 days later, was the saddest day of my life, he said.
Even as American troops found no unconventional arms, the Bush administration waged a quiet campaign against Dr. ElBaradei and his agency, barring his inspectors from Iraq and working behind the scenes to keep him from a third term.
{'entity': 'B-MISC', 'score': 0.99979055, 'index': 3, 'word': 'American', 'start': 8, 'end': 16}
{'entity': 'B-PER', 'score': 0.9990933, 'index': 11, 'word': 'Bush', 'start': 58, 'end': 62}
{'entity': 'B-PER', 'score': 0.9969589, 'index': 21, 'word': 'El', 'start': 113, 'end': 115}
{'entity': 'I-PER', 'score': 0.9692212, 'index': 22, 'word': '##B', 'start': 115, 'end': 116}
{'entity': 'I-PER', 'score': 0.89878917, 'index': 23, 'word': '##ara', 'start': 116, 'end': 119}
{'entity': 'I-PER', 'score': 0.9170256, 'index': 24, 'word': '##de', 'start': 119, 'end': 121}
{'entity': 'I-PER', 'score': 0.9090824, 'index': 25, 'word': '##i', 'start': 121, 'end': 122}
{'entity': 'B-LOC', 'score': 0.999816, 'index': 36, 'word': 'Iraq', 'start': 167, 'end': 171}
He said he had been 99 percent decided against running until he learned that John R. Bolton, then Washingtons United Nations ambassador, was determined to block him.
{'entity': 'B-PER', 'score': 0.9997155, 'index': 15, 'word': 'John', 'start': 79, 'end': 83}
{'entity': 'I-PER', 'score': 0.99702376, 'index': 16, 'word': 'R', 'start': 84, 'end': 85}
{'entity': 'I-PER', 'score': 0.9947081, 'index': 17, 'word': '.', 'start': 85, 'end': 86}
{'entity': 'I-PER', 'score': 0.9996317, 'index': 18, 'word': 'Bolton', 'start': 87, 'end': 93}
{'entity': 'B-ORG', 'score': 0.9859278, 'index': 21, 'word': 'Washington', 'start': 100, 'end': 110}
{'entity': 'I-ORG', 'score': 0.9799915, 'index': 23, 'word': 'United', 'start': 113, 'end': 119}
{'entity': 'I-ORG', 'score': 0.99766964, 'index': 24, 'word': 'Nations', 'start': 120, 'end': 127}
Dr. ElBaradei recalled a sense of revulsion that such a personal decision should be made by anybody else.
{'entity': 'B-PER', 'score': 0.9992011, 'index': 3, 'word': 'El', 'start': 4, 'end': 6}
{'entity': 'I-PER', 'score': 0.98517907, 'index': 4, 'word': '##B', 'start': 6, 'end': 7}
{'entity': 'I-PER', 'score': 0.9496202, 'index': 5, 'word': '##ara', 'start': 7, 'end': 10}
{'entity': 'I-PER', 'score': 0.9795279, 'index': 6, 'word': '##de', 'start': 10, 'end': 12}
His wife said she had told him, Mohamed, you run  tomorrow!
{'entity': 'B-PER', 'score': 0.99759966, 'index': 9, 'word': 'Mohamed', 'start': 33, 'end': 40}
Ultimately, with no candidate of its own and no international support, the United States backed down.
{'entity': 'B-LOC', 'score': 0.99973345, 'index': 15, 'word': 'United', 'start': 75, 'end': 81}
{'entity': 'I-LOC', 'score': 0.99938726, 'index': 16, 'word': 'States', 'start': 82, 'end': 88}
In October 2005, a month into his new term, the Nobel call came.
{'entity': 'B-MISC', 'score': 0.98077536, 'index': 13, 'word': 'Nobel', 'start': 48, 'end': 53}
Breaking the Seals
{'entity': 'I-MISC', 'score': 0.86433566, 'index': 2, 'word': 'the', 'start': 9, 'end': 12}
Traceback (most recent call last):
  File "preprocess_wmt_train_data.py", line 150, in <module>
    main()
  File "preprocess_wmt_train_data.py", line 65, in main
    sentence, answers = mask_sentence(sentences[i], mask_chance, bert_ner, spacy_ner)
  File "preprocess_wmt_train_data.py", line 109, in mask_sentence
    combined[-1]['end'] = ner_results[i]['end']
IndexError: list index out of range
