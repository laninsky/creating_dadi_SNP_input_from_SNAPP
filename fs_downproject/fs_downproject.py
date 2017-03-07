import numpy
import scipy
import matplotlib
import dadi

with open('file_name', 'r') as myfile:
    dadi_input=myfile.read().replace('\n', '')

dd = dadi.Misc.make_data_dict(dadi_input)

with open(dadi_input, 'r') as myfile:
    headerline=myfile.readline().replace('\n', '').split('\t')

newheader = list()

for i in range(len(headerline)):
        if not ((headerline[i]=='ingroup') or (headerline[i]=='outgroup') or (headerline[i]=='Allele1') or (headerline[i]=='Allele2')):
            if newheader==[]:
                newheader = list(headerline[i].split)
                delimiter=''
                newheader = delimiter.join(newheader)
            else:
                newheader.append(headerline[i])

final_fs = 0
final spectrum = 0

fs = dadi.Spectrum.from_data_dict(dd , pop_ids =['Pop1',    'Pop2', 'Pop3', 'Pop4'] ,projections =[6 , 22, 2, 2] ,polarized = False)

fs.to_file("spectrum_output.txt")
