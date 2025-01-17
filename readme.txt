Pyrolysis Polymer Search (PPS)

Version 0.11
Date: 9/24/2024

Contact edward.erisman@nist.gov

Requirements: Windows operating system

Usage:  A data file must be processed by NIST AMDIS to extract the mass spectra and calculate retention index of the pyrolysates.  
To start PPS simply click "PPS.bat".  A command window will appear, followed by a window (or tab) of the default internet browser (internet connection not necessary) with the PPS interface.    

Pyrolysis Polymer Search (PPS) uses the *.elu output from AMDIS and creates a *.MSPEC file (combining all the spectra into one file).  The searching is done with NIST pepsearch (included in the app) using a minimum match factor of 700, retention index window of 10, a stong RI penalty (100), and a maximum number of 5 hits for each pyrolysate.  The penalty to the match factor based on RI is 0 if the query RI is within the RI window of the library RI and penalty = |query RI - library RI| * penalty rate / RI tolerance if the query RI is outside the RI window of the library RI.  The hitlist is filtered so that an individual pyrolysate only appears once.  The polymer score is calculated by the average match factor times the fraction of pyrolysates appearing in the hit list to the number of pyrolysates in the library.  The actual identity of each pyrolysate is not inferred.  Sample data *.elu files are in the ./data/ folder.  PPPS1.elu and PPPS3.elu are both mixtrues of isotatic polypropylene and polystyrene of differing amounts.  MIX1.elu is a mixture of polyethylene and isotatic polyproplyene.  MIX 2.elu is a mixture of polyethylene, polystryene, and polybutene.  The pyrolysis library in NIST format (readable with NIST MS Search) is located in the ./pepsearch/SearchLibraries/ folder.  

License:
This software was developed by employees of the National Institute of Standards and Technology (NIST), an agency of the Federal Government and is being made available as a public service. Pursuant to title 17 United States Code Section 105, works of NIST employees are not subject to copyright protection in the United States. This software may be subject to foreign copyright. Permission in the United States and in foreign countries, to the extent that NIST may hold copyright, to use, copy, modify, create derivative works, and distribute this software and its documentation without fee is hereby granted on a non-exclusive basis, provided that this notice and disclaimer of warranty appears in all copies.

THE SOFTWARE IS PROVIDED 'AS IS' WITHOUT ANY WARRANTY OF ANY KIND, EITHER EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, ANY WARRANTY THAT THE SOFTWARE WILL CONFORM TO SPECIFICATIONS, ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND FREEDOM FROM INFRINGEMENT, AND ANY WARRANTY THAT THE DOCUMENTATION WILL CONFORM TO THE SOFTWARE, OR ANY WARRANTY THAT THE SOFTWARE WILL BE ERROR FREE. IN NO EVENT SHALL NIST BE LIABLE FOR ANY DAMAGES, INCLUDING, BUT NOT LIMITED TO, DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES, ARISING OUT OF, RESULTING FROM, OR IN ANY WAY CONNECTED WITH THIS SOFTWARE, WHETHER OR NOT BASED UPON WARRANTY, CONTRACT, TORT, OR OTHERWISE, WHETHER OR NOT INJURY WAS SUSTAINED BY PERSONS OR PROPERTY OR OTHERWISE, AND WHETHER OR NOT LOSS WAS SUSTAINED FROM, OR AROSE OUT OF THE RESULTS OF, OR USE OF, THE SOFTWARE OR SERVICES PROVIDED HEREUNDER.

