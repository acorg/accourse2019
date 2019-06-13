# Introduction to R

## Brief functions intro

`plot(x = 1, y = 2)`

## Data types

### Vectors & Lists
(Be aware of coercion)

### Matrices & Data frames
(`cbind` and `rbind`)

### Vectorization of statement
```R
x <- 1:10
y <- 1:10
z <- x+y
```



## Subsetting
Different types of subsetting

- Integer (and negative integer)
- Logical
- Character

<br/>

| | Simplifying   | Preserving  |
| ------------- | -------------:| -----:|
| Vector      | `x[[1]]` | `x[1]` |
| List      | `x[[1]]` | `x[1]` |
| Matrix | `x[, 1]`  | `x[, 1, drop = F]` |
| Data frame | `x[, 1]`  | `x[, 1, drop = F]` |

<br/>

### Subsetting and assignment

All subsetters work with assignment  
  
`x[] <- 1` to preserve type


## Writing your own functions
Principles of functions  
What happens when a variable is not found

## For loops
