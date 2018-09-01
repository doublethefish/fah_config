#graph test123 {
#	a -- b -- c;
#	a -- {x y};
#	x -- c [w=10.0];
#	x -- y [w=5.0,len=3];
#}
num = {
	"1" : "one",
	"2" : "two",
	"3" : "three",
	"4" : "four",
	"5" : "five",
	"6" : "six",
	"7" : "seven",
	"8" : "eight",
	"9" : "nine",
	"0" : "zero",
}

def dotSafe(fname) :
	#fname = fname.replace(".", "_")#.replace("2", "Two")
	#for n in num :
	#	if(fname[0].find(n) == 0):
	#		fname.replace( n, num[n])
	return '"' + fname.lower() + '"'

def outputDot(d_fileObjects):
	dg = "graph frank {\n"
	for fileObjectName in d_fileObjects :
		fileObject = d_fileObjects[fileObjectName][0]
		dg += dotSafe(fileObjectName) + " -- { "
		#deps = fileObject.getProjectDependancies(False)
		#deps = fileObject.getIndirectProjectDependancies(False)
		#deps = fileObject.getDirectDependants()
		deps = fileObject.getDirectProjectDependancies()
		files = []
		for fo in deps :
			files.append(dotSafe(fo.filename))
		dg += " ".join(files)
		dg += " };\n"
	dg += "}\n"

	dot_graph = open("dot_graphs/f.dot", "w+")
	dot_graph.write(dg)
	dot_graph.close()


if __name__ == "__main__":
	print("can't be this way");
