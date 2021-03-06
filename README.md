# REM (retrieving effectively from memory) model for MATLAB

*Information*: This set of MATLAB scripts implements the REM model
(retrieving effectively from memory) following:

1) Shiffrin, R., & Steyvers, M. (1997). A model for recognition memory: REM—retrieving effectively from memory. 
Psychonomic Bulletin & Review. Retrieved from http://www.springerlink.com/index/C6G85741088R3247.pdf

2) Malmberg, K. J., Zeelenberg, R., & Shiffrin, R. M. (2004). Turning up the Noise or Turning Down the Volume? On the Nature of the Impairment of Episodic Recognition Memory by Midazolam. 
Journal of Experimental Psychology: Learning Memory and Cognition, 30(2), 540–549. https://doi.org/10.1037/0278-7393.30.2.540

*Description*: The script simulates the word frequency mirror effect (WFME)
in a hypothetical recognition experiment. One participant is first 
presented during a study phase with a list of words (with high and
low frequency items) and subsequently in a test phase is presented with
test items which can be either novel words or studied words. The
simulated agent implements the basic formulation for REM for encoding of
features in memory images and retrieval from memory using Bayesian
Inference. The modeled experiment has a 2X3 with
the following factors: word frequency with 2 levels (high vs. low), item
presentations at study (1,2,4).

*Usage*: REM_SIM.m is the top-level script which then calls lower level
functions. The user can adjust this script to generate simulated results with different experimental conditions (i.e. list length, item repetitions, study time, etc.)

*Note*: The script is intended as an exploratory tool to understand memory
phenomena within the context of SAM-REM theory. Therefore the code favors 
transparency rather than computational efficiency. 


*Acknowledgement*: This set of scripts was developed as part of ESCOP 2010, 
a big thanks to all of the instructors!

