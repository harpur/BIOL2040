# Functions for marking

This repo contains functions used for marking, chiefly for BIOL2040. 

These functions assume that the file is delineated as per BIOL2040, and that there are multiple files per class
<pre><code>
ID	LN	FN	EM	L	TUT	AP	Ind	Grp
21222222	Lastname Namefirst		email@gmail.ca	LECT01	 TUTR06	P	12	12
214333333	Namelast	Firstname	email@hotmail.com	LECT01	 TUTR06	P	14	14
</code></pre>

## FileChecker.r
This function loads in a single file and ensures the students on it match a master list and that all cells within the file are filled out correctly

As of right now, the script isn't an exceutable. I'll have that ready after I am sure I've hit all the potential errors that can come from this type of munging.