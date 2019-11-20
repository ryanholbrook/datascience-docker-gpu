install.packages(
    ## Development
    "packrat",
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
    "cowplot",
    "naniar",

    ## Features
    "vip",
    "FactoMineR",
    "Boruta",

    ## Models
    ## ------
    ## Linear Regression
    "brms", # MCMC Bayesian
    "glmnet", # lasso
    "elasticnet", # L_p regularization
    "pls", # partial least squares and principal component regression

    ## Linear Classification
    "DiscriMiner", # discriminant analysis
    "MASS", # lda, mca, qda
    "mda", # Mixture DA
    "sda" # Shrinkage DA

    ## Basis Expansion
    ## Splines, Kernel Smoothing, and Local Regression
    "crs", # Categorical Regression Splines
    "earth", # Multivariate Adaptive Regression Splines
    "KernelKnn",
    "kernlab",
    "naivebayes",
    "nns", # nonparametric models using partial moments
    "np", # nonparametric kernel methods
    "polyspline", # Polynomial MARS

    ## Model Averaging
    "adabag",
    "ipred",

    ## Additive Models and Trees
    "gam",
    "party", "partykit",
    "rpart",

    ## Boosting and Additive Trees
    "ada",
    "bst",
    "gbm"
    "caTools", # logicboost
    "mboost", # glmboost and gamboost
    "C50",
    "Cubist",

    ## Neural Networks and Projection Pursuit
    "deepnet",
    "nnet",

    ## Support Vector Machines
    "e1071",
    ## kernlab
    ## liquid svm
    ## swarm svm

    ## Prototype Methods and Nearest-Neighbors
    "kknn",
    "class",    
    "OneR",

    ## Random Forests
    "randomForest",
    "ranger",
    "Rborist",
    "rFerns",

    ## Ensembles

    ## Gaussian Processes
    "DiceKriging",
    "laGP",

    ## Time Series
    "forecast",
    "prophet",
    "smooth",

    ## Clustering
    "cluster",
    "clue",
    "fpc",
    "klaR",
    "mclust",

    ## Rules
    "arules",
    ## RcppCorels 

    # Optimization and Design
    "mlrMBO",
    "rsm",
    
    # Interpretation
    "DALEX",
    "DALEXtra")

install.packages("liquidSVM", configure.args = "native /usr/local/cuda")
