// ask for a file to be imported
	
	fileName = File.openDialog("Select the file to import");
	allText = File.openAsString(fileName);
	//fn = split(fileName,".");
	// get file format {txt, csv}
	//fn_raw = fn[0];
	// parse text by lines
	text = split(allText, "\n");

//define your path, this is where files will be saved
	
	//path =  "B:\114\114_20180920_time course redux slide scan\_CP\v3_wholeslide_TB72only\_imgexport"
	//dir = File.getParent(fileName);
	//File.makeDirectory(fileName)
	//dir = getDirectory("Choose a Directory")

//clear results in case there is something you don't want in your output Results file

	run("Clear Results")
	rename("IMG")
	//run("Split Channels")


// define array for points and image URLS
	
	var X1points = newArray;
	var Y1points = newArray;
	var SLICEnum = newArray;	

//label you columns by number here (starting at 0, not 1)
	
	hdr = split(text[0]);

	iSLICE = 1;
	iX1 = 2;
	iY1 = 3;
				
// loading and parsing each line
	for (i = 1; i < (text.length); i++)
	{
	   //we split each line in the csv at commas 
	   line = split(text[i],",");
	   setOption("ExpandableArrays", true);   

	   //this loads the data from the csv into the arrays me setup before so that we can iterate over each line (i)
	   //these are specifically for the HCMV ac and nucleus, but you can change them if you need.

	   X1points[i-1] = parseInt(line[iX1]);
	   Y1points[i-1] = parseInt(line[iY1]);
	   SLICEnum[i-1] = parseInt(line[iSLICE]);

	   //now that the data is loaded from the csv, we can perform our operations
	   //open each image using the URL, draw a line with 150 width, perform a linescan and save the data to a column in the results tab 
	   //open(C1url[i-1]);
	   selectWindow("IMG");
	   setSlice((SLICEnum[i-1]));
	   //run("Duplicate...", " ");
	   //run("Canvas Size...", "width=3548 height=3548 position=Center zero"); //expand canvas to 2048 + 750*2 for ROI on each side
	  
	    makeArrow(X1points[i-1]+30,Y1points[i-1]-30,X1points[i-1]+8,Y1points[i-1]-8, "filled");
		Roi.setStrokeWidth(5);
		Roi.setStrokeColor("white");
		run("Draw", "slice");
			   
	 
	  	makeArrow(X1points[i-1]+30+800,Y1points[i-1]-30,X1points[i-1]+8+800,Y1points[i-1]-8, "filled");
		Roi.setStrokeWidth(5);
		Roi.setStrokeColor("white");
		run("Draw", "slice");
			   

	   
	   
	   //merge all of these channles, cut out a 750x750 region and rotate to align every image on the axis of the linescan
	   //run("Merge Channels...", "c1=C1 c2=C2 c3=C3 create");
	   //makeRectangle(Xmidpoints[i-1]-375,Ymidpoints[i-1]-375,750,750);
	   //Roi.setStrokeWidth(2);
	   //setForegroundColor(255, 255, 255);
	   //run("Draw");
	   
	   
	   //run("Canvas Size...", "width=350 height=350 position=Center zero"); //expand canvas to 2048 + 750*2 for ROI on each side
	   //makeRectangle(Xmidpoints[i-1],Ymidpoints[i-1],50,50); //note here we compensated for canvas size expansion
	   //run("Duplicate...", "duplicate");
	   //save(path+ImageID[i-1]);

	
	}