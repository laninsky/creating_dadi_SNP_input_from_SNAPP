import numpy
import scipy
import matplotlib
import dadi

with open('file_name', 'r') as myfile:
    dadi_input=myfile.read().replace('\n', '')

dd = dadi.Misc.make_data_dict(dadi_input)

with open(dadi_input, 'r') as myfile:
    headerline=myfile.readline().replace('\n', '').split('\t')

headerline.remove('ingroup')
headerline.remove('outgroup')
headerline.remove('Allele1')
headerline.remove('Allele2')

no_of_pops = (len(headerline)-2)/2
pop_name = headerline[0:no_of_pops]

final_fs = 0
final_spectrum = 0




fs = dadi.Spectrum.from_data_dict(dd , pop_ids =pop_name ,projections =[6 , 22, 2, 2,3] ,polarized = False)
if fs.S() > final_fs:
    final_fs=fs.S()
    final_spectrum = fs


final_spectrum.to_file("spectrum_output.txt")
