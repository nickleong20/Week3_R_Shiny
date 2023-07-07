# OpenSpecy Spectral Analysis

This application allows you to analyze and match spectral data uploaded from various file formats, such as CSV, ASP, JDX, SPC, SPA, and 0. It utilizes the OpenSpecy package for spectral analysis and provides interactive visualization of the matched spectrum.

Features:
- Upload spectral data files in various formats.
- Adjust spectral intensity, smooth, and background-correct the spectrum.
- Match the spectrum with a library and retrieve metadata.
- Display the matched spectrum in a table.
- Determine the type of spectra (FTIR or Raman) based on the highest "r" value.
- Display information about the selected spectrum type, data status (processed or unprocessed), and region status (full spectrum or peaks).

The code for this application performs the following steps:

1. It checks if the required packages are installed and installs them if needed. These packages provide functions and tools for data analysis and visualization.

2. The necessary packages are loaded into the application.

3. The FTIR library, which contains reference spectra for analysis, is fetched.

4. The user interface (UI) is defined using the Shiny framework. It includes a file upload widget for the user to upload a spectral data file. The supported file formats are specified.

5. The server logic is defined. It handles the processing of the uploaded file and generates the analysis results.

6. When a file is uploaded, the server code reads the file and performs various data processing steps, such as adjusting the spectral intensity and identifying the type of spectrum (Raman or FTIR).

7. Different combinations of smoothing factors and background correction values are generated for analysis.

8. For each combination, the uploaded spectrum is processed by applying the selected smoothing factor and background correction. The processed spectrum is then matched with the FTIR library to find the best matching reference spectra.

9. The analysis results, including the smoothing intensity, baseline correction, sample name, spectrum identity, R-value (a measure of similarity), organization, and spectrum type (Raman or FTIR), are stored in a table.

10. The results table is displayed in the application's main panel using the DataTable library, allowing for interactive exploration and filtering of the results.

In summary, this application provides a user-friendly interface to upload and analyze spectral data. It performs various data processing steps, matches the uploaded spectrum with a reference library, and presents the analysis results in a table format.
