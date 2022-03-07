# PE - Analysis Methodology
## File information & Header Analysis
- Use a <b>file</b> command to determine filetype
- Verify the file header using hex editor (e.g. HxD)

## Get Basic PE information
- Parse the PE header using a tool (e.g. PE Bear)
- Determine what ressources, DLL imports and librairies used
	- Example : If you see <b>Ws2_32.dll</b> it might be setting up a network conenction because it's used for setting up sockets
- Look for weird sections inside the section table
- File magic byte
- File architecture (e.g. x86 ou x64)

## Collect strings 
- Use the <b>string</b> command on Linux
- Use BinText on Windows
- Extract strings to find any clues

## Static analysis
- IDA

## Dynamic analysis 
- x64dbg