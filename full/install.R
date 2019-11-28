packages <- (
    ## Development
    "archivist",
    "drake",
    "testthat",
    "assertthat",
    ## Utilities,
    "zeallot",
    ## Data
    "rio",
    "roomba",
    "fst",
    "disk.frame",
    "glue",
    "validate",
    ## EDA
    "corrplot",
    "skimr",
    "lattice",
    "vcd",
    "ggforce",
    "gganimate",
    "patchwork",
    "naniar",
    ## Features
    "vip",
    "FactoMineR",
    "Boruta",
    ## Models
    ## --------------------
    ## Linear Regression
    "brms", # MCMC Bayesian
    "glmnet", # lasso
    "elasticnet", # L_p regularization
    "pls", # partial least squares and principal component regression
    ## Disciminant Analysis
    ## --------------------
    "DiscriMiner",
    "MASS", # lda, mca, qda
    "mda", # Mixture DA
    "sda" # Shrinkage DA
    "naivebayes",## Basis Expansion
    ## Splines, Kernel Smoothing, and Local Regression
    ## --------------------
    "crs", # Categorical Regression Splines
    "earth", # Multivariate Adaptive Regression Splines
    "KernelKnn",
    "kernlab",
    "nns", # nonparametric models using partial moments
    "np", # nonparametric kernel methods
    "polyspline", # Polynomial MARS
    ## Model Averaging
    ## --------------------
    "adabag",
    "ipred",
    ## Additive Models and Trees
    ## --------------------
    "gam",
    "party", "partykit",
    "rpart",
    "C50",
    "Cubist",
    ## Boosting
    ## --------------------
    "ada",
    "bst",
    "gbm"
    "caTools", # logicboost
    "mboost", # glmboost and gamboost
    ## Neural Networks and Projection Pursuit
    ## --------------------
    "nnet",
    "deepnet",
    ## Support Vector Machines
    ## --------------------
    "e1071",
    "liquidSVM",
    ## kernlab
    ## liquid svm
    ## swarm svm
    ## Prototype Methods and Nearest-Neighbors
    ## --------------------
    "kknn",
    "class",    
    "OneR",
    ## Random Forests
    ## --------------------
    "randomForest",
    "ranger",
    "Rborist",
    "rFerns",
    ## Ensembles
    ## --------------------
    ## Gaussian Processes
    ## --------------------
    "DiceKriging",
    "laGP",
    ## Time Series
    ## --------------------
    "forecast",
    "prophet",
    "smooth",
    ## Clustering
    ## --------------------
    "cluster",
    "clue",
    "fpc",
    "klaR",
    "mclust",
    ## Rules
    ## --------------------
    "arules",
    ## RcppCorels
    ## --------------------
    ## Optimization and Design
    ## --------------------
    "mlrMBO",
    ## Interpretation
    ## --------------------
    "DALEX",
    "DALEXtra")

## Not compatible with CUDA 10
## install.packages("liquidSVM", configure.args = "native /usr/local/cuda")

not_installed <- function(pkg) {
    !nzchar(system.file(package = pkg))
}

install_if_not <- function(pkgs) {
    sapply(pkgs, 
           function (pkg)
               if (not_installed(pkg))
                   install.packages(pkg)
           )
    return(NULL)
}

install_if_not(packages)
