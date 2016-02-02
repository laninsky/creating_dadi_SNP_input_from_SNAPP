Instructions for running dadi on windows
```
open IPython (Py2.7)

import numpy

import scipy

import matplotlib

import dadi

import matplotlib.pyplot as pyplot
```
The following instructions are for the "ingroup-SNP-optimized" file (opt1) created using creating_dadi_SNP_input_from_structure.R in this repository. This is step 3.3 from the dadi manual
```
dd = dadi.Misc.make_data_dict("C:/pathway_to_file/opt1_output.txt")
```
e.g.
```
dd = dadi.Misc.make_data_dict("C:/Users/a499a400/Dropbox/ceyx/dadi/opt1_output.txt")
```
Change your pop_ids in the following line to the population names you have used. For this file, we want to use polarized = False, automatically folding the spectra, because we aren't super confident in our ancestral states. To figure out the projections you should use, you might have to load the spectrum multiple times playing around with this. If you have no missing data, it should be 2N where N is your sample size for each populaiton. If you do have missing data, you need to assess the number of segregating sites for each combo using fs.S(). Our max ended up being (XXXX) for the following projection:
```
fs = dadi.Spectrum.from_data_dict(dd , pop_ids =['Pop1',	'Pop2', 'Pop3', 'Pop4'] ,projections =[6 , 22, 2, 2] ,polarized = False)
```

To output this final fs:
```
fs.to_file("C:/Users/a499a400/Dropbox/ceyx/dadi/spectrum_output.txt")
```

If you are doing a two-population comparison (the above is not), this then plots the spectrum so you can visualize it
```
dadi.Plotting.plot_single_2d_sfs( fs , vmin =1)
pyplot.show()
```
Calculating the Fst between your ingroup populations:
```
Fst = fs.Fst()
```
To assess significance, can scramble the population labels, sample, and see how that effects Fst:
```
d = {}
for i in range(1000):
scrambled = fs.scramble_pop_ids()
sample = scrambled.sample()
d[i] = sample.Fst()

sum(1 for i in d if d[i] > Fst)
```
To further examine presence of substructure, 

scrambled = fs.scramble_pop_ids()


Marginalizing the spectra in case we want to look at population-specific parameters (because we have only sampled across SNPs this seems a little dodgy, so I haven't actually implemented this for our data):
```
migratory = fs.marginalize([1])
sedentary = fs.marginalize([0])
#migratory.Watterson_theta()
#sedentary.Watterson_theta()
#migratory.pi()
#sedentary.pi()
migratory.Tajima_D()
sedentary.Tajima_D()
```



