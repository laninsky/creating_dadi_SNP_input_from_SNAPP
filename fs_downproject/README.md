The fs_downproject.sh will carry out downsampling through dadi and return you the projected down size that optimizes the fs.

You will need your dadi input file (created following the instructions in the main repository:  https://github.com/laninsky/creating_dadi_SNP_input_from_structure)

You'll need fs_downproject.sh, fs_downproject.R and fs_downproject.py in the same directory as your dadi input file. 

To run:

```
i=your_dadi_input_file
#e.g. i=opt1_output.txt

bash fs_downproject.sh
```
