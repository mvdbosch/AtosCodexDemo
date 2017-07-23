# Atos Codex Data Scientist Workbench Demo
Code used for the Atos Codex Data Scientist Workbench (DSW) demonstration

## Instructions ##

Clone this repository on a CentOS Linux environment, which has the blueprint of Atos Codex 2.3 Fabric or PaaS installed.
(Note: It is possible to execute this demo on a different environment. However, this would require a manual component setup, similar to
the Atos Codex PaaS blueprint)

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


## Some screenshots

![Screenshot 1](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot1.png)

![Screenshot 2](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot2.png)

![Screenshot 3](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot3.png)

![Screenshot 4](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot4.png)

![Screenshot 5](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot5.png)

![Screenshot 6](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot6.png)

![Screenshot 7](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot7.png)

![Screenshot 8](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot8.png)

![Screenshot 9](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot9.png)

![Screenshot 10](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot10.png)

![Screenshot 11](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot11.png)

![Screenshot 12](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot12.png)

![Screenshot 13](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot13.png)

![Screenshot 14](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot14.png)

![Screenshot 15](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot15.png)

![Screenshot 16](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot16.png)

![Screenshot 17](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot17.png)

![Screenshot 18](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot18.png)

![Screenshot 19](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot19.png)

![Screenshot 20](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot20.png)

![Screenshot 21](https://github.com/mvdbosch/AtosCodexDemo/blob/master/Screenshots/screenshot21.png)

