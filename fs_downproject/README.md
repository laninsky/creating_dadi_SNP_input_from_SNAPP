The fs_downproject.sh will carry out downsampling through dadi and return you the projected down size that optimizes the fs.

You will need your dadi input file (created following the instructions in the main repository:  https://github.com/laninsky/creating_dadi_SNP_input_from_structure)

You'll need fs_downproject.sh, fs_downproject.R and fs_downproject.py in the same directory as your dadi input file. 

To run:

```
export i=your_dadi_input_file
#e.g. i=opt1_output.txt

bash fs_downproject.sh
```

If you are going to take this file into fastsimcoal2, just be aware they differ a little in layout. Dadi will spit out a SFS where the numbers of diploid copies for populations on the "title line" are one larger than what they should be for fastsimcoal. Fastsimcoal also expects this line to start with the actual number of populations followed by the sample size. Finally, Dadi also has an additional line fastsimcoal doesn't want explaining whether the site is monomorphic or not. e.g. output from Dadi
```
13 3 13 19 17 folded "larutensis" "west1" "west2" "west3" "west4"
1667.057478796622 486.6223247788935 169.5761557922856 46.9420557216375 17.84681997328152 [...]
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [...]
```
Versus what this would look like formatted for fastsimcoal2
```
1 observations. No. of demes and sample sizes are on next line
5       12      2       12      18      16
1667.057478796622 486.6223247788935 169.5761557922856 46.9420557216375 17.84681997328152 [...]
```
Depending on where your data came from (e.g. RADseq), you might want to think about adding information on loci with no polymorphisms back into the monomorphic entry (the first one in the SFS) - check the fastsimcoal manual/google group for why this might be helpful.
