# creating_dadi_SNP_input_from_structure v0.0
Do you want to chuck your SNPs through dadi, but are coming from stacks/SNAPP? This script might help

# How does it work?

This script expects a *structure.tsv file as input that you've created through stacks. This file will have a commented first row, followed by a row specifying the locus (as multiple SNPs can be accepted from one locus for structure). The next row is the data, with the sample name in the first column, assigned population in the next column, followed by the SNP call (1-4 for A-T, and 0 for missing) for each position of each locus (see example file). You can create a file which will work with this script from the output of https://github.com/laninsky/ambigoos_into_structure by deleting the second row of full_SNP_record.txt (the site-specific position of SNPs within each locus), and adding a row at the top of the file starting with a comment (e.g. #blahblah). Make sure the beginning of the row with locus IDs has two spaces at the beginning. This should also be a file that you have added the population designations to.

e.g.
```
#blahblahblah
  2 2 2 13 13 13 13
sample1 pop2 0 1 2 2 3 3 2 
sample1 pop2 0 1 1 2 3 3 4
sample2 pop3 1 1 1 2 3 3 4
sample2 pop3 2 1 1 2 3 3 4
sample3 outgroup 1 1 1 1 2 2 2
sample3 outgroup 1 1 1 1 2 2 2
```
# If your file doesn't have the pop_ID column and doesn't have the locus_IDs? 
You can add the pop_IDs using the code at: https://github.com/laninsky/ambigoos_into_structure#what-if-you-wanted-to-add-a-population-identifier-column-after-the-individual-column

# Adding locus IDs
After adding your pop_IDs (and if it has the header line) , if your structure file already has one SNP per locus, you can then add "fake" locus IDs with the code in this folder called "add_locusIDs.R". To run this:
```
echo structure_name > file_name
Rscript add_locusIDs.R
```

# What if the encoding for the SNPs is 0-3 for A-T, and -9 for missing? 
You can switch the encoding with the code in the folder called "switch_SNP_coding.R". This code assumes your file is otherwise ready to go (e.g. looks like the example file above, except with the SNP coding different).This code will need some modification, as it was cribbed from a similar but not exact situation.

# What if you don't have an outgroup?
You can run the add_outgroup.R code to arbritrarily duplicate the first sample in your file and call it the outgroup. This only makes sense if you are using the folded spectrum option below rather than the unfolded (where the ancestral state actually matters).
```
echo structure_name > file_name
Rscript add_outgroup.R
```

# To run the script
Using a tab-delimited file ("namelist.txt") with your sample names (just once, rather than duplicated for each allele as they are in the structure file) in the left column, and your species/population designations in the right hand column (with outgroup species labelled as "outgroup")...

e.g.
```
sample1 pop2
sample2 pop3
sample3 outgroup
```

...this script will create a SNP input file for dadi (pulling out one SNP per locus) using the following rules: For each locus, take the SNP with the least amount of missing data, and arbritrarily pick one of your outgroup species (because single SNPs without flanking bases cannot be used with the 'Spectrum.from_data_dict_corrected', this dataset would be more appropriate for use with polarized=False i.e. folded spectrum). The beauty about this is that if you don't have an outgroup you can just duplicate one of your samples and call it the outgroup, because it won't be used for any downstream calculations.

To actually call the script, paste the entire contents of creating_dadi_SNP_input_from_structure.R into your R console (or source it if you like). Then within the R window, you can execute it by:
```
creating_dadi_SNP_input_from_structure(working_dir,file_name)
```
where:
working_dir == pathway to the folder with your structure.tsv file e.g. "C:/blahblahblah" 
file_name == the name of your structure.tsv file e.g. "data.structure.tsv"
```
e.g.
creating_dadi_SNP_input_from_structure("C:\\Users\\Alana\\Dropbox\\katie","2_tweaked_input_file_outgroup.txt")
```

# Suggested citation
creating_dadi_SNP_input_from_structure was first published in:

Chan, K.O., Alexander, A.M., Grismer, L.L., Su, Y.C., Grismer, J.L., Quah, E.S. and Brown, R.M., 2017. Species delimitation with gene flow: A methodological comparison and population genomics approach to elucidate cryptic species boundaries in Malaysian Torrent Frogs. Molecular ecology, 26(20), pp.5435-5450.

If you want to cite the specific version of the script you used, I suggest the following:

Alexander, A. 2017. creating_dadi_SNP_input_from_structure v1.0.0. Available from hhttps://github.com/laninsky/creating_dadi_SNP_input_from_structure

This pipeline also wouldn't be possible without:

R: R Core Team. 2015. R: A language and environment for statistical computing. URL http://www.R-project.org/. R Foundation for Statistical Computing, Vienna, Austria. https://www.r-project.org/

Stringr: Hadley Wickham (2012). stringr: Make it easier to work with strings.. R package version 0.6.2. http://CRAN.R-project.org/package=stringr (for up-to-date citation information run citation("stringr" in R)

# Version history
0.0: Version used in Chan et al. (2017)
