# Notes for next time
- Only displaying FTIR, try to make sure that it chooses the right one and can display both
- Fix the placement of the new box


# OpenSpecy Spectral Analysis

This application allows you to analyze and match spectral data uploaded from various file formats, such as CSV, ASP, JDX, SPC, SPA, and 0. It utilizes the OpenSpecy package for spectral analysis and provides interactive visualization of the matched spectrum.

Features:
- Upload spectral data files in various formats.
- Adjust spectral intensity, smooth, and background-correct the spectrum.
- Match the spectrum with a library and retrieve metadata.
- Display the matched spectrum in a table.
- Determine the type of spectra (FTIR or Raman) based on the highest "r" value.
- Display information about the selected spectrum type, data status (processed or unprocessed), and region status (full spectrum or peaks).

Prerequisites:
- R environment with the necessary packages installed (shiny, OpenSpecy, dplyr, DT).
- Spectral library files compatible with the OpenSpecy package.

Instructions:
1. Install the required packages if not already installed by running the following commands in R:
   if (!require("shiny")) install.packages("shiny")
   if (!require("OpenSpecy")) install.packages("OpenSpecy")
   if (!require("dplyr")) install.packages("dplyr")
   if (!require("DT")) install.packages("DT")

2. Load the necessary libraries by running the following commands in R:
   library(shiny)
   library(OpenSpecy)
   library(dplyr)
   library(DT)

3. Fetch the FTIR library by running the following command in R:
   get_lib()

4. Load the FTIR library into the global environment by running the following command in R:
   spec_lib <- load_lib()

5. Run the application by running the following command in R:
   shinyApp(ui = ui, server = server)

6. In the application interface:
   - Click on the "Upload a file" button to select a spectral data file.
   - Choose the file format from the available options (CSV, ASP, JDX, SPC, SPA, 0).
   - Click the "Analyze" button to process and match the spectrum.

7. The matched spectrum will be displayed in a table, and additional information about the selected spectrum type, data status, and region status will be shown below the data input section.

Notes:
- Make sure to have the required spectral library files compatible with the OpenSpecy package for accurate matching.
- The code assumes that the "match_spec" function returns the "r" values as part of the match results. Verify that your "match_spec" function provides the necessary information for the comparison.
- This code can be modified and customized according to specific requirements.

