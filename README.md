# creating_dadi_SNP_input_from_structure [still a work in progress i.e. I haven't finished coding it...]
Do you want to chuck your SNPs through dadi, but are coming from stacks/SNAPP? This script might help

#How does it work?#

This script expects a *structure.tsv file as input that you've created through stacks. This file will have a commented first row, followed by a row specifying the locus (as multiple SNPs can be accepted from one locus for structure). The next row is the data, with the sample name in the first column, assigned population in the next column, followed by the SNP call (0-4) for each position of each locus (see example file).

Using a tab-delimited file with your sample names in the left column, and your species/population designations in the right hand column (with outgroup species labelled as "outgroup"), this script will create a SNP input file for dadi (pulling out one SNP per locus) using two slightly different implementations:
1) For each locus, take the SNP with the least amount of missing data, and arbritrarily pick one of your outgroup species (because single SNPs without flanking bases cannot be used with the 'Spectrum.from_data_dict_corrected', this dataset would be more appropriate for use with polarized=False)
2) For each locus, take the SNP where your multiple outgroups have the same 'ancestral' state (if multiple SNPs are in this category, then take the SNP with the least amount of missing data for the ingroup species). This will hopefully reduce some of the bias detailed by Hernandez et al. 2007: http://mbe.oxfordjournals.org/content/24/8/1792
