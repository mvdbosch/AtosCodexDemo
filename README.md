# Atos Codex Data Scientist Workbench Demo
Code used for the Atos Codex Data Scientist Workbench (DSW) demonstration

## Instructions ##

Clone this repository on a CentOS Linux environment.

Target location should be in the user's document directory, e.g.: /home/marcel/Documents/

Use the following command: 

```bash
git clone https://www.github.com/mvdbosch/AtosCodexDemo.git
```

## Requirements

The demo requires the following CentOS / YUM packages to be installed on the operating system.

```Bash
yum install libpng-devel libjpeg-devel libxml2-devel geos-devel
```

The R code is requiring the following R libraries to be installed. This can be done by the following command:

```R
install.packages(c('shiny','data.table','ggplot2','ggmap','grid','gridExtra','stringr','XML','pmml'))
```

The following Python packages are required. You can install them using pip or pip3 (for Python3)

```Bash
pip3 install pandas numpy geopandas matplotlib  ipywidgets IPython sklearn scipy scikit-learn 
```

## High-level demo storyline

1. Perform git clone from github page
2. Create new Talend project + Click on Jobs, import the components from the "Talend ETL code" directory. + Execute main
3. Open KNIME and Import KNIME Workflow. Reset + Execute
4. Rstudio : Step by step walkthrough of "ExploreAndVisualize.R"
5. Rstudio : Full execution of the Shiny App "ExploreCBS_ShinyApp.R")
6. Jupyter Notebook : Step by step walkthrough of "Explore the CBS Crime and Demographics Dataset.ipynb"







