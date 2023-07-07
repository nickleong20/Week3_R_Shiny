## Spectral Analysis Application

This repository contains a web-based application built with Shiny and R that aims to solve the problem of spectral analysis and matching for scientific and analytical purposes. The application provides a user-friendly interface for users to upload spectral data files and perform analysis using the OpenSpecy package.

### Problem Statement

Analyzing spectral data is a common task in various scientific fields, such as chemistry, biology, materials science, and environmental science. Researchers and analysts often need to compare their experimental spectra with reference spectra to identify compounds or understand the characteristics of their samples. However, this process can be time-consuming and require expertise in data processing and analysis.

### Solution

The Spectral Analysis Application offers a convenient solution to streamline spectral analysis and matching. With this application, users can easily upload spectral data files in different formats, such as CSV, ASP, JDX, SPC, SPA, and 0. The application processes the data, adjusts the spectral intensity, and matches the spectra with a pre-built FTIR (Fourier Transform Infrared) library using the OpenSpecy package.

The application allows users to explore different combinations of smoothing factors and background correction values to refine the analysis. The results are presented in an interactive table, providing insights into the best matching reference spectra, including information such as the sample name, spectrum identity, R-value (a measure of similarity), organization, and spectrum type (FTIR or Raman).

By using this application, researchers and analysts can save time and effort in their spectral analysis tasks. It simplifies the process of comparing experimental spectra with reference spectra, enabling users to gain valuable insights from their spectral data in a user-friendly and intuitive manner.

### Getting Started

To run the application locally, follow these steps:
1. Install the necessary R packages specified in the `app.R` file.
2. Clone this repository to your local machine.
3. Open the `app.R` file in RStudio or any other R IDE.
4. Run the code to start the application.
5. Access the application through your web browser and begin uploading spectral data files for analysis.

### Dependencies

The Spectral Analysis Application relies on the following R packages:
- shiny
- OpenSpecy
- dplyr
- DT
- progress

These packages will be automatically installed if not already available in your R environment.

### Contribution

Contributions to the Spectral Analysis Application are welcome. If you encounter any issues, have suggestions for improvement, or would like to add new features, please submit an issue or a pull request to this repository.

### License

The Spectral Analysis Application is released under the [MIT License](LICENSE). Feel free to use, modify, and distribute the code for both commercial and non-commercial purposes.
