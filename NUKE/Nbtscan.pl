#!c:\perl\bin\perl.exe

#get files to use

print("NetBios Scanner Version 0.1 Beta\n");
print("By Logic_Box	logic_box\@email.com\n");
print("Input File: ");
$infile = <STDIN>;
print("\n");
print("Output File: ");
$out = <STDIN>;
print("\n");
chop($infile);
chop($out);


#start doing work

#open our files
open (INFILE, $infile);

#let the scanning begin
$line = <INFILE>;
while ($line ne "") {
	print ("Now Scanning $line\n");
	system ("nbtstat -A $line >> $out");
	$line = <INFILE>;
}
close (INFILE);
