
library("Racmacs")

# Assign objects to be numbers or characters (strings) or logical (TRUE or FALSE)
x <- 12
x <- "text"
x <- TRUE
x <- T

# You can assign objects to be equal to other objects
y <- x

# But the new object is a copy and changes don't affect the original object
y <- 3

# Pretty much everthing is stored as a vectors or a list

# All the things in a vector have to be the same type (number, character, logical)
# Automatic conversion occurs to make everything the same type
x <- c(1, 2, 3, 4)
x <- c(1, "a", "b", 4)
x <- c(TRUE, FALSE, TRUE)
x <- c(T, F, T)
x <- c(TRUE, "a", "b", 4)
x <- c(TRUE, FALSE, 3, 4)

# You can also convert formats yourself
x <- c(T,F,F,T)
x <- as.numeric(x)
x <- as.character(x)
x <- as.logical(x)

# You can also assign names in a vector (unusual)
x <- c(T, F, F, T)
x <- c(value1 = T, value2 = F, value3 = F, value4 = T)

# You can "concatenate" (join) two vectors into another vector
y <- c(F,F,F)
x <- c(x, y)

z <- c(1, c(2,3, c(4,5)))
z <- c(1, 2, 3, 4, 5) # The same

# A single value is also a vector (length 1)
x <- 1


# Lists
# Can contain any mixture (also lists)
x <- list(value1 = "a", value2 = 1:6, value3 = c(T,F), value4 = list(1,"a"))

# Happy with different data types
x <- list(TRUE, "a", "b", 4)

# Lists do "nest"
z <- list(1, list(2,3, list(4,5)))
z <- list(1, 2, 3, 4, 5) # Not the same


# Data frames and matrices

# Matrix
xbycol <- matrix(data = 1:10,
                 nrow = 5,
                 ncol = 2)

xbyrow <- matrix(data = 1:10,
                 nrow = 5,
                 ncol = 2,
                 byrow = TRUE)

# A matrix is a vector (underlying), it just has some additional attributes 
# number of rows and number of columns

# This explains why everything in a matrix must be the same type
x <- matrix(data = c(1,FALSE,"x",3), nrow = 2, ncol = 2)

# Is also explains why the length of a matrix is the number of values (not columns)
length(x)


# Data frames

# A data frame is stored as a list
# By default characters are set to factors, but you can turn this off
x <- data.frame(col1 = 1:10,
                col2 = LETTERS[1:10],
                stringsAsFactors = FALSE)

# You can convert between them
x <- as.matrix(x)
x <- as.data.frame(x)

# Both can have column and row names
xrownames <- rownames(x)
xcolnames <- colnames(x)

# You have to use a strange syntax to set columns and rows
rownames(x) <- LETTERS[1:10]
colnames(x) <- c("col1a", "col1b")

# You can also use this way to set properties of an acmap
map <- read.acmap("../Day1/files/h3map2004.ace")
ag_sizes <- agSize(map)
agSize(map) <- 10



## Reading in data
# Read csv
sequences <- read.csv("../Day2/files/h3_2004/sequences.csv",
                      colClasses = "character", # To make sure everything stays as a character
                      row.names = 1) # To tell it that the first column is actually row names

# Mostly when you read in a spreadsheet you get a data frame
is.data.frame(sequences)
class(sequences)



# Subsetting and assignment
vecx <- 1:10

## Numeric
x3 <- vecx[3] # Getting
vecx[3] <- 10 # Setting

x35 <- vecx[c(3,5)]       # Multiple getting
vecx[c(3,5)] <- c(20, 30) # Multiple setting

vecx[] <- 3 # Trick to assign to everything but keep same format

vecx[c(2,2,4,2,5)] # You can get the same thing twice, or in a different order


## Character
namedx <- c(pos1 = 1, pos2 = 2, pos3 = 3, pos4 = 4)
namedx[3]
namedx[c("pos3", "pos1", "pos3")]

## Logical
vecx <- 1:4
vecx <- 1:100

logical_selected <- vecx < 60 & vecx > 20
vecx[logical_selected]
vecx[vecx < 60 & vecx > 20]


# Reading in a map
map <- read.acmap(filename = "../Day1/files/h3map2004.ace")


# Making a function to read in excel
readxl <- function(
    file_path,         # Argument for the function
    rows_to_skip = 1,  # Argument with a default
    row_names_in_first_column = TRUE 
    ){
    
    # Read in using the read_excel function from the readxl package
    xltable <- readxl::read_excel(
        path = file_path,     # Take file path from the argument supplied
        skip = rows_to_skip,  # Take rows to skip from the argument supplied
        .name_repair = "minimal"
    )
    
    # Convert to a data frame
    xltable <- as.data.frame(xltable)
    
    if(row_names_in_first_column){
    
        # Set the row names from the first column values
        rownames(xltable) <- xltable[,1]
    
        # Remove the first column of row names (no longer needed)
        xltable <- xltable[,-1]
        
    }
    
    # Return the data frame
    xltable
        
}


# Using our function to read in data
table1 <- readxl(file_path = "../Day1/files/h3map_titrations/h3table 1.xlsx")
table2 <- readxl(file_path = "../Day1/files/h3map_titrations/h3table 2.xlsx", rows_to_skip = 2)
table3 <- readxl(file_path = "../Day1/files/h3map_titrations/h3table 3.xlsx", rows_to_skip = 2)
table4 <- readxl(file_path = "../Day1/files/h3map_titrations/h3table 4.xlsx", rows_to_skip = 2)

# Using cbind to join the tables together
mergetable <- cbind(table1, table2, table3, table4)

# Make an acmap from the table
map <- acmap(table = mergetable)

# Run 100 optimizations
map <- optimizeMap(
   map = map,
   number_of_dimensions = 2,
   number_of_optimizations = 100,
   minimum_column_basis = "none",
   move_trapped_points = "none"
)

# Find the optimization run that's selected
selectedOptimization(map)

# Rotate the map
map <- rotateMap(map, degrees = 20)
map <- realignOptimizations(map) # A procrustes transformation
map <- reflectMap(map)

# Plot or view map
plot(map)
view(map)

# Read in sequences
sequence <- read.csv(
    file        = "../Day2/files/h3_2004/sequences.csv", 
    row.names   = 1, 
    colClasses  = "character", # Keep everything as a character format
    check.names = FALSE # Don't change column names
)

# Get antigen names from the map
ag_names <- agNames(map)

# Get row names from the sequence
sequence_file_rownames <- rownames(sequence)

# Find which sequence rows match each antigen name
seq_match <- match(ag_names, sequence_file_rownames)

# Reorder the rows of the sequence file based on the match
sequence  <- sequence[seq_match,]

# Take the position at 145 and convert to a factor
pos145 <- as.factor(sequence[,145])

# Assign a color for each position
pos_cols  <- c("cyan", "blue", "red", "yellow", "green")

# Get the values of each position
pos_names <- levels(pos145)

# Now we make a vector of antigenic colors based on AA at position 145
ag_cols <- pos_cols[as.numeric(pos145)]

# Also works subsetting straight from factor
ag_cols <- pos_cols[pos145]

# Reassign our antigenic colors in the map to match the colors by AA
agFill(map) <- ag_cols

# Plot the map
plot(map)

# Add a legend
legend(x      = "topleft",
       legend = pos_names,
       fill   = pos_cols)

# View the map
view(map)


# Excluding and predicting titers (dimension testing)
map <- read.acmap("../Day1/files/h3map2004.ace")
results <- dimensionTestMap(map = map,
                            dimensions_to_test = 2:4,
                            test_proportion = 0.1,
                            minimum_column_basis = "none",
                            column_bases_from_master = TRUE)




