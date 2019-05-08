setBatchMode(true);

// first (because i can't figure out how to do regex in java...) use the bulk rename tool to chane the name to GFP and RFP (as depending on the channels you will use this might change). Though this is provided in WAVENAME1 and WAVENMAE2

fileName = File.openDialog("Select the first non-thumbnail file in the directory");

dir = File.getParent(fileName)

//var experimentID = dir; 
var sampleID = newArray;
var stageID = newArray;

fileName2 = File.openDialog("Select the stageID CSV");
allText = File.openAsString(fileName2);
tmp = split(fileName2,".");
// get file format {txt, csv}
posix = tmp[lengthOf(tmp)-1];
// parse text by lines
text = split(allText, "\n");

hdr = split(text[0]);

istageID = 0;
isampleID = 1;

	for (i = 1; i < (text.length); i++)
	{
			//we split each line in the csv at commas 
			line = split(text[i],",");
			setOption("ExpandableArrays", true);   
			
			sampleID[i-1] = line[isampleID];
			stageID[i-1] = parseInt(line[istageID]);
			
			run("Image Sequence...", "open=["+fileName+"] file=_GFP_s" + stageID[i-1] + "_ sort");
			rename("GFP");
			run("Image Sequence...", "open=["+fileName+"] file=_RFP_s" + stageID[i-1] + "_ sort");
			rename("RFP");
			run("Merge Channels...", "c1=RFP c2=GFP create");
			//rename(experimentID +"_"+ sampleID[i-1] +"_"+ stageID[i-1]);
			save(dir + "/"+ sampleID[i-1] +"_"+ stageID[i-1] + "_merged");
			close();
	}

//THEN TAKE the metamorph output file which has the stage position list and names, and cycle through the entire folder using "s" + STAGEPOSITION + "_" as the regex

