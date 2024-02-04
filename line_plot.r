library(ggplot2)
library(readr)
library(dplyr)  

train_loss_file_path <- "train_loss.csv"
validation_loss_file_path <- "validation_loss.csv"

train_loss_data <- read_csv(train_loss_file_path)
validation_loss_data <- read_csv(validation_loss_file_path)

train_loss_data <- rename(train_loss_data, step = `train/global_step`, loss = `train/loss`)
validation_loss_data <- rename(validation_loss_data, step = `train/global_step`, loss = `eval/loss`)
train_loss_data$type <- "Train"
validation_loss_data$type <- "Validation"

combined_data <- rbind(train_loss_data, validation_loss_data)


ggplot(combined_data, aes(x=step, y=loss, color=type)) +
  geom_line() +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("Step") +
  ylab("Loss") +
  ggtitle("Training and Validation Loss") +
  scale_color_manual(values = c("Train" = "blue", "Validation" = "red"))
