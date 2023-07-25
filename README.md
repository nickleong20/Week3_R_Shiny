# Week 3: R Shiny
## Spectral Analysis Application

The Spectral Analysis Application is a web-based tool built with Shiny and R that simplifies the process of analyzing and matching spectral data. It allows users to upload spectral data files, perform analysis using the OpenSpecy package, and visualize the results in an interactive table. Whether you're a researcher, analyst, or scientist working with spectral data, this application provides a user-friendly interface to streamline your analysis workflow. To get started, visit the [Code](code/) section of this repository and follow the instructions to run the application locally. Explore the power of spectral analysis and make the most out of your data with this convenient tool.

## How to Use

This GitHub repository contains code for a Shiny application that performs spectral analysis on different types of files and displays the results in a data table. Here's how you can use this repository to run the Shiny app:

### Install Required Packages

1. Make sure you have R and RStudio installed on your system.

2. Open RStudio and set the working directory to the root of the cloned repository.

3. Install the required R packages by running the following code in the RStudio console:

```R
install.packages(c("shiny", "OpenSpecy", "dplyr", "DT", "progress"))
```

### Run the Shiny App

1. In RStudio, open the `app.R` file located in the cloned repository. You can find it in the root folder of the repository.

2. Click the "Run App" button in the top-right corner of the RStudio script editor. Alternatively, you can run the app by typing the following in the RStudio console:

```R
shiny::runApp()
```

3. This will start the Shiny app, and a new window or tab will open in your web browser.

### Upload a File

1. In the Shiny app, you'll see a file input area labeled "Upload a file."

2. Click the "Browse" button and select the spectral data file you want to analyze. The supported file types are CSV, ASP, JDX, SPC, SPA, and 0.

3. The app will automatically process the data, apply intensity adjustment, background subtraction, and determine whether the spectrum is of type "Raman" or "FTIR."

### View Results

1. After the data processing is complete, the results will be displayed in a dynamic data table.

2. The table will show various combinations of smoothing intensity, baseline correction, sample name, spectrum identity, R-value, organization, and spectrum type.

3. You can interact with the data table by sorting, filtering, and searching for specific results.

That's it! You can use this GitHub repository to run the Shiny app and perform spectral analysis on your own data files. Feel free to explore the code and customize the app according to your needs. If you encounter any issues or have suggestions for improvements, you can contribute to the repository by creating a pull request or opening an issue. Happy analyzing!

## How it Works
R Shiny is a framework that lets you build interactive web applications with R. It simplifies the process of creating dynamic interfaces and data-driven dashboards, even if you're not an expert in web development. You can use your existing R code to create web apps that users can access through their browsers. Shiny enables users to interact with the application, input data, make selections, and see instant updates based on their actions. It handles the behind-the-scenes communication between the browser and the R server to ensure smooth interactivity and responsive visualizations.

In Shiny, you combine the user interface (UI) and server logic. The UI section defines the layout, appearance, and input controls of your app using R functions. On the server side, you write R code that determines how the app responds to user inputs and data changes. Shiny's reactive programming allows your app to automatically update outputs in real-time. It takes care of managing the interplay between the UI and server, ensuring that changes in inputs trigger the necessary computations and updates. You can run the resulting app locally or deploy it to a web server for wider accessibility. With Shiny, R users can easily create interactive web apps that facilitate data exploration, analysis, and communication through a user-friendly interface.

## Get in Touch

Thank you for your interest in my project! If you have any questions, suggestions, or feedback, feel free to contact me. I'd be happy to hear from you.

- **Email:** [nick@mooreplasticresearch.org](mailto:nick@mooreplasticresearch.org)
- **Website:** [www.mooreplasticresearch.org](https://mooreplasticresearch.org/)
- [**Discussion Board**](https://github.com/nickleong20/Week3_OpenSpecy/discussions/1)
  
[![Twitter Follow](https://img.shields.io/twitter/follow/MoorePlasticRes?style=social)](https://twitter.com/MoorePlasticRes)
![Discord](https://img.shields.io/badge/Discord-Placeholder-7289DA?logo=discord&logoColor=white)
![Facebook](https://img.shields.io/badge/Facebook-Placeholder-3b5998?logo=facebook&logoColor=white)


Please maintain a professional and respectful environment. When you contact me, please follow the project's code of conduct and provide clear and concise information about your question or feedback. 

Thank you once again for your interest in the project. I look forward to hearing from you and collaborating with the community.

## Contributions
We encourage contributions of all kinds!

Please refer to our [contributing guidelines](https://github.com/nickleong20/Week2_OpenSpecy/blob/main/CONTRIBUTING.md) when contributing to this project. We also ask that you follow our [code of conduct](). 

