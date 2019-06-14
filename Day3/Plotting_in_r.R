
# Clear global environment
rm(list = ls())

# Load necessary packages
library(Racmacs)

# Load necessary data
load("../Day3/files/dimensiontesting.RData")

min_stress_row <- which.min(results$sd_error)
results[min_stress_row,]

percent_excluded <- results$proportion_to_dont_care
rows_with10percent_excluded <- percent_excluded == 0.1


par(mar = c(5,5,4,2))

plot(x = results$number_of_dimensions[results$proportion_to_dont_care == 0.1],
     y = results$sd_error[results$proportion_to_dont_care == 0.1],
     ylim = c(0,1.6),
     xlab = "Number of dimensions",
     ylab = "sd(predicted - measured log titer)",
     main = "Dimension testing the map",
     type = "b",
     col = "darkgreen")

lines(x = results$number_of_dimensions[results$proportion_to_dont_care == 0.2],
      y = results$sd_error[results$proportion_to_dont_care == 0.2],
      type = "b",
      col = "red")

lines(x = results$number_of_dimensions[results$proportion_to_dont_care == 0.3],
      y = results$sd_error[results$proportion_to_dont_care == 0.3],
      type = "b",
      col = "blue")

abline(h = 1.1, lty = 2)






