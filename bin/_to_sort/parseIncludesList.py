#!/usr/bin/python3

def warn(msg) :
	print( getTabs() + msg )
	return

import sys

if len(sys.argv) != 2 and len(sys.argv) != 3:
	print("please give me a file to parse!")
	sys.exit(1)

fname = sys.argv[1]

fileDetail = False
if( len(sys.argv)==3 ):
	fileDetail = sys.argv[2]

print( "about to parse file '{0}'".format(fname) )

# read data from files
includeFile = open( fname, 'r' )
l_lines = includeFile.readlines()
includeFile.close()

# mode of file parsing
mode = 0

# results data structs
#d_files = {}
d_fileObjects = {}
l_ignores = []

class CFileException(Exception) :
	def __init__(self, value):
		self.value = value

	def __str__(self):
		return repr(self.value)

def getFilename(fullpath) :
	""" get filename parts """
	fullpath = fullpath.replace( '\\', '/' )
	l_parts = fullpath.split( '/' ) # split into a list of path componets
	filename = l_parts.pop() # remove the filename off the end
	path = "/".join(l_parts)
	l_parts.reverse # reverse the path for comparisons
	return (filename, l_parts, path)

def findFileObj( path ) :
	""" finds a best match for a file object from its path """
	global d_fileObjects
	filename, l_parts, fullpath = getFilename(path)

	if filename not in d_fileObjects :
		raise CFileException( "file '{0}' not found in d_fileObjects! fullpath: '{1}'".format( filename, path ) )

	num_parts = len(l_parts)

	l_candidateFileObjs = d_fileObjects[filename]
	best_candidate = l_candidateFileObjs[0]
	best_match_len = -1

	for candFileObj in l_candidateFileObjs:
		num_cand_parts = len(candFileObj.l_path)
		matches = True
		match_len = 0
		for id in range(min(num_parts, num_cand_parts)) :

			part = l_parts[id]
			candPart = candFileObj.l_path[id]

			if part != candPart :
				matches = False
				break
			else:
				match_len += 1

		if matches :
			if match_len > best_match_len :
				best_candidate = candFileObj

	return best_candidate

g_depth = 0
def getTabs() :
	global d_depth
	ret = "" #str(g_depth)
	for i in range(g_depth) :
		ret += "|\t"
	return ret

def incDepth() :
	global g_depth
	g_depth += 1
	if g_depth > 10 :
		raise Exception("fah max depth reached!")
	#print(g_depth)

def decDepth() :
	global g_depth
	g_depth -= 1
	#print(g_depth)

class CFile :
	filename = ""
	fullpath = ""
	l_path = []
	s_path = ""
	dependancies = []
	externalDependancies = []
	dependants = []

	d_fileObjects =  {}


	def __init__ (self, fullpath) :
		self.filename, self.l_path, self.s_path = getFilename(fullpath)
		self.fullpath = "/".join((self.s_path, self.filename))
		self.dependancies = []
		self.externalDependancies = []
		self.dependants = []
		l_path = self.l_path
		l_path.reverse
		self.s_path = "/".join(l_path)

	def __str__(self) :
		return "{0}:{1}:{2}:dep({3})".format( self.filename, self.fullpath, id(self), id(self.dependancies) )


	def setData(self, d_fileObjects) :
		self.d_fileObjects = d_fileObjects


	def scan(self):
		pass


	def parseline(self, line) :
		pass


	def addDependancy(self, includePath) :
		""" add file which this (self) depends upon """
		fileObj = None
		try :
			fileObj = findFileObj( includePath )
		except CFileException as e :
			global l_ignores
			if includePath not in l_ignores :
				warn( "non-project dependancy found : '{0}'".format(includePath) )
				l_ignores.append( includePath )

			if includePath not in self.externalDependancies :
				self.externalDependancies.append( includePath )
			return

		cur_id = id(self)
		new_obj_id = id(fileObj)
		if cur_id == new_obj_id :
			raise Exception( "cannot add a file to itself as a dependancy '{0}' == '{1}'".format( self.fullpath, includePath ) )
		if self.filename == fileObj.filename :
			raise Exception( "cannot add a file to itself as a dependancy '{0}' == '{1}'".format( self.fullpath, includePath ) )
		#print( "adding '" + str(fileObj) + "' to '" + str(self) + "'"  )
		print( getTabs() + "adding dep ", str(fileObj), id(fileObj), " to : " , str(self), id(self))
		self.dependancies.append( fileObj )

	def getDirectProjectDependancies(self) :
		l_ret = self.dependancies[:]
		return l_ret

	def getProjectDependancies(self, doprint) :
		l_ret = self.getDirectProjectDependancies()
		subDeps = self.getIndirectProjectDependancies(doprint)
		for subDep in subDeps :
			if subDep not in l_ret :
				l_ret.append( subDep )

		return l_ret

	def getIndirectProjectDependancies(self, doprint) :
		l_ret = []
		numDeps = len(self.dependancies)
		for dependancy in self.dependancies :
			if id(dependancy) == id(self) :
				continue # a raise Exception( "A dependancy has the same id() as its dependee", str(self), id(self), str(dependancy), id(dependancy) )
			if dependancy.filename == self.filename :
				raise Exception( "A dependancy has the same name as its dependee", str(self), id(self), str(dependancy), id(dependancy) )

			if doprint :
				print( getTabs() + str(dependancy) )
			incDepth()

			l_ret.extend( dependancy.getProjectDependancies(doprint) )

			decDepth()

		if numDeps != len(self.dependancies) :
			raise Exception("self.dependancies has grown by", numDeps - len(self.dependancies), "!" )
		return l_ret

	def getDependancyCount(self) :
		""" returns the number of files that this file directly includes
		(i.e. has an #inlcude directive for) """
		numDeps = (len(self.dependancies)) + (len(self.externalDependancies))
		return numDeps

	def getIndirectDependancyCount(self) :
		""" returns the number of files that this file indirectly
		includes (i.e. files listed in #include directives /and/ files
		listed in those files in #include directives) """
		numDeps = (len(self.getProjectDependancies(False))) + (len(self.externalDependancies))
		return numDeps

	def getAllDependants(self) :
		""" return the list of file which directly depend upon this one
		"""
		searchObject = self
		l_deps = []
		for fileObjectName in d_fileObjects :
			for fileObject in d_fileObjects[fileObjectName] :
				deps = fileObject.getProjectDependancies(False)
				if searchObject in deps :
					l_deps.append(fileObject)
		return l_deps

	def getAllDependantsCount(self):
		""" returns the number of files that directly depend upon this file
		"""
		l_deps = self.getAllDependants()
		numDeps = len(l_deps)
		return numDeps

	def getDirectDependants(self) :
		searchObject = self
		l_deps = []
		for fileObjectName in d_fileObjects :
			for fileObject in d_fileObjects[fileObjectName] :
				deps = fileObject.getDirectProjectDependancies()
				if searchObject in deps :
					l_deps.append(fileObject)
		return l_deps



def parseProjectFileData(line) :
	""" parse project line """

	filename,l_parts,path  = getFilename(line)

	if filename not in d_fileObjects :
		d_fileObjects[filename] = []
	else:
		warn( "'{0}' allready in file list!".format(filename) )
		for existingObject in d_fileObjects[filename] :
			warn( "\t{0}".format( existingObject.s_path) )
		warn( "\t{0}".format(path))

	print( getTabs() + "adding '{0}' to list".format( filename ) )
	newFileObj = CFile(line)
	#print( newFileObj )
	d_fileObjects[filename].append( newFileObj )


def parseIncludeLineData(line) :
	""" parse include line """
	cpos = line.find(':')
	containerFileFullPath = line[:cpos]
	rest = line[cpos+1:]
	cpos = rest.find(':')
	linenum = rest[:cpos]
	unparsedIncludeCode = rest[cpos+1:]
	commentpos = rest.find('//')
	if commentpos != -1 :
		unparsedIncludeCode2 = unparsedIncludeCode[:commentpos-2]

		if len(unparsedIncludeCode2)<=2 :
			print( str(commentpos) + "!!!" + unparsedIncludeCode + "|||" + unparsedIncludeCode2 + ":::" + line )
			return


	containerFile, l_containerPath, containerFilePath = getFilename(containerFileFullPath)

	if containerFile not in d_fileObjects :
		raise Exception( "Dependee file '{0}' not listed/found in the d_fileObjects struct".format( containerFileFullPath ) )

	try :
		fileObject = findFileObj( containerFile )
	except CFileException as e :
		warn( "Dependant file '{0}' not found in project files, assuming is 3rd party".format( containerFileFullPath ) )
		warn( e )
		return

	# parse the #include directive so we end up with just the filename
	parsedString = unparsedIncludeCode
	# sanitise filename delimiters
	for replaceme in ('<','"', '>' ) :
		parsedString = parsedString.replace( replaceme, '§' ).strip()

	loc = parsedString.find( '§' )
	if( loc != -1 ) :
		parsedString = parsedString[loc+1:]
		loc = parsedString.find('§')
		parsedString = parsedString[:loc]

		fileObject.addDependancy( parsedString )
	else :
		print( getTabs() + "unable to parse line '" + line + "'" )
		return

	#print(containerFile, linenum, unparsedIncludeCode, parsedString)

#iterate over the file's lines
# ripping
#    * the project files
#    * the includes data
for line in l_lines :
	line = line.strip()

	# handle mode setting/changin lines
	if( line == "---FILES---" ):
		# mode is parsing project files
		# these files are considered to be
		# non-library or 3rd party files
		print( "---------------------------" )
		print( "Parsing project file object" )
		mode = 1
	elif( line == "---INLCUDES---" ):
		# mode is parsing includes information
		# whilst in this mode each line is
		# expected to be in the format
		# <conatinerfile>:<lineno>:<includemacroline>
		print( "---------------------------" )
		print( "Parsing #include directives" )
		mode = 2
	else :

		if( mode == 1 ):
			#---FILES---
			incDepth()
			parseProjectFileData(line)
			decDepth()

		elif( mode == 2 ):
			#---INLCUDES---
			incDepth()
			parseIncludeLineData(line)
			decDepth()

		else :
			raise Exception("invalid input file! {0}, {1}".format(line, mode))


def debugPrint(fileObjects):
	""" debugPrint discovered data """
	print( "---------------------------" )
	print( "debug printing fileObjects" )
	print( "---------------------------" )
	for fileObjectName in fileObjects :
		fileObjectList = fileObjects[fileObjectName]
		for fileObject in fileObjectList  :
			print( "\t" + str(fileObject) )
			#print( "\t depends upon :" + str(id(fileObject.dependancies)) )
			for depObject in fileObject.dependancies :
				print("\t\t" + str(depObject) )
				if id(fileObject.dependancies)==id(depObject.dependancies) :
					raise Exception( str(fileObject) + " shares a dep list with " + str(depObject) )
	print( "---------------------------" )
	print( "/debug printing fileObjects" )
	print( "---------------------------" )
	print( "----------------------------" )
	print( "debug printing dependancies" )
	print( "----------------------------" )
	for fileObjectName in fileObjects :
		fileObjectList = fileObjects[fileObjectName]
		for fileObject in fileObjectList  :
			print( str(fileObject) )
			incDepth()
			fileObject.getProjectDependancies(True)
			decDepth()
	print( "----------------------------" )
	print( "/debug printing dependancies" )
	print( "----------------------------" )

#debugPrint(d_fileObjects)

#------------------------------
print("______________________")
print("____DEPENDANCIES______")
print("______________________")
def cmpf(a) :
	fileObject = d_fileObjects[a][0]
	numDeps = fileObject.getDependancyCount()
	return numDeps

l_sortedFiles = sorted(d_fileObjects, key=cmpf, reverse=True)
for filename in l_sortedFiles[:15] :
	fileObject = d_fileObjects[filename][0]
	numDeps = fileObject.getDependancyCount()
	print( "{0} : has {1} dependancies".format(filename, numDeps) )
	for dep in fileObject.externalDependancies :
		print( "\t({1:2}) {0} (direct, non proj)".format(dep, numDeps) )
		numDeps -= 1
	for dep in fileObject.dependancies :
		print( "\t({1:2}) {0} (direct)".format(dep.filename, numDeps) )
		numDeps -= 1


#------------------------------
print("_______________________")
print("_INDIRECT_DEPENDANCIES_")
def cmpg(a) :
	fileObject = d_fileObjects[a][0]
	numDeps = fileObject.getIndirectDependancyCount()
	return numDeps

l_sortedFiles2 = sorted(d_fileObjects, key=cmpg, reverse=True)
for filename in l_sortedFiles2[:15] :
	fileObject = d_fileObjects[filename][0]
	numDeps = fileObject.getIndirectDependancyCount()
	print( "{0} : has {1:2} dependancies".format(filename, numDeps) )
	bExtended = False
	deps = None
	incDepth()
	if bExtended :
		print( getTabs() + "All:" )
		incDepth()
		deps = fileObject.getProjectDependancies(True) + fileObject.externalDependancies[:]
		decDepth()
	bExtended = True
	if bExtended :
		print( getTabs() + "Unique:" )
		incDepth()
		idx = numDeps
		if deps == None :
			deps = fileObject.getProjectDependancies(False) + fileObject.externalDependancies[:]
		for dep in deps :
			idx-=1
			print( getTabs() + "({0:2})".format(idx) + str(dep) )
		decDepth()
	decDepth()

"""
for filename in d_files :
"""

print("______________________")
print("______DEPENDANTS______")
def cmph(a) :
	searchObject = d_fileObjects[a][0]
	l_deps = searchObject.getDirectDependants()
	numDeps = len(l_deps)
	return numDeps

l_sortedFiles3 = sorted(d_fileObjects, key=cmph, reverse=True)
for filename in l_sortedFiles3[:15] :
	print("{} objects depend upon {}".format(cmph(filename),d_fileObjects[filename][0]) )

if fileDetail != False :
	print("________________________________________")
	print("{0} depends upon".format(fileDetail))
	incDepth()
	count = 0
	for fileObject in d_fileObjects[fileDetail] :
		count += len(fileObject.getProjectDependancies(True))
	if count == 0 :
		print( "no files!" )
	decDepth()

	print("______________________")
	print("{0} is depended upon by:".format(fileDetail))
	searchObject = d_fileObjects[fileDetail][0]
	l_deps = []
	for fileObjectName in d_fileObjects :
		for fileObject in d_fileObjects[fileObjectName] :
			deps = fileObject.getProjectDependancies(False)
			#for dep in deps :
			#	print(id(dep), str(dep), id(searchObject))
			if searchObject in deps :
				l_deps.append(fileObject)
	def cmpi(fileObject) :
		numDeps = fileObject.getAllDependantsCount()
		return numDeps
	l_deps = sorted(l_deps, key=cmpi, reverse=True)
	print("... {} objects".format(len(l_deps)) )
	incDepth()
	for fileObject in l_deps :
		l_subdeps = fileObject.getAllDependants()
		numDeps = len(l_subdeps)
		print(getTabs() + "(causes {:2} indirect deps) {}".format(numDeps, fileObject))
		incDepth()
		l_subdeps = sorted(l_subdeps, key=cmpi, reverse=True)
		for subFileObject in l_subdeps :
			numDeps = subFileObject.getAllDependantsCount()
			print( getTabs() + "({}) ".format(numDeps) + str(subFileObject) )
		decDepth()
	decDepth()


from includeAsDotGraph import *

outputDot(d_fileObjects)
