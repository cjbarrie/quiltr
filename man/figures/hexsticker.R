library(hexSticker)
library(ggplot2)
library(ggimage)

p <- ggplot(data.frame(x=1,y=1,image="man/figures/hexgoogledraw1.png"), aes(x,y)) +
  geom_image(aes(image=image), size=1.06) + theme_void()

s <- sticker(p,
             package = "quiltr",
             s_x = 1,
             s_y = 1,
             s_width = 2.163,
             s_heigh = 2.5,
             p_x = 1,
             p_y = 1.4,
             h_color = "white",
             h_fill = "transparent",
             h_size = 1,
             p_color = "black",
             p_size = 72,
             dpi = 800,
        filename="man/figures/quiltrhex.png")
