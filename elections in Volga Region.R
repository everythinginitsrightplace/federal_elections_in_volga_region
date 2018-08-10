library(ggplot2)
library(ggthemes)
library(sf)
library(tidyverse)
library(ggplot2)
library(mapview)
library(rvest)
library(magrittr)
library(rgdal)
library(ggthemes)
library(hrbrthemes)
g <- read.csv("Выборы выборы - Лист1.csv", header = T, encoding = "UTF-8")


Russian_regions <- st_read("C:/Users/user/Desktop/all_shapefields/modern_russia_borders.shp")
head(Russian_regions)


# Отбираем регионы Приволжского федерального округа
Volga_Region_1 <- Russian_regions[Russian_regions$NL_NAME_1 == c("Татарстан", "Чувашия", "Ульяновская область", "Оренбургская область", "Башкортостан", "Саратовская область", "Самарская область", "Марий Эл",
                                                                 "Пермский край", "Пензенская область", "Мордовия", "Кировская область", "Нижегородская область", "Удмуртия"),]

Volga_Region_1 <- Russian_regions[Russian_regions$NL_NAME_1 == "Татарстан",]
Volga_Region_1 <- Volga_Region_1[-(1:10), ]
Volga_Region_2 <- Russian_regions[Russian_regions$NL_NAME_1 == "Чувашия",]
Volga_Region_2 <- Volga_Region_2[-(1:10), ]
Volga_Region_3 <- Russian_regions[Russian_regions$NL_NAME_1 == "Ульяновская область",]
Volga_Region_3 <- Volga_Region_3[-(1:10), ]
Volga_Region_4 <- Russian_regions[Russian_regions$NL_NAME_1 == "Оренбургская область",]
Volga_Region_4 <- Volga_Region_4[-(1:10), ]
Volga_Region_5 <- Russian_regions[Russian_regions$NL_NAME_1 == "Башкортостан",]
Volga_Region_5 <- Volga_Region_5[-(1:10), ]
Volga_Region_6 <- Russian_regions[Russian_regions$NL_NAME_1 == "Саратовская область",]
Volga_Region_6 <- Volga_Region_6[-(1:10), ]
Volga_Region_7 <- Russian_regions[Russian_regions$NL_NAME_1 == "Самарская область",]
Volga_Region_7 <- Volga_Region_7[-(1:10), ]
Volga_Region_8 <- Russian_regions[Russian_regions$NL_NAME_1 == "Марий Эл",]
Volga_Region_8 <- Volga_Region_8[-(1:10), ]
Volga_Region_9 <- Russian_regions[Russian_regions$NL_NAME_1 == "Пермский край",]
Volga_Region_9 <- Volga_Region_9[-(1:10), ]
Volga_Region_10 <- Russian_regions[Russian_regions$NL_NAME_1 == "Пензенская область",]
Volga_Region_10 <- Volga_Region_10[-(1:10), ]
Volga_Region_11<- Russian_regions[Russian_regions$NL_NAME_1 == "Мордовия",]
Volga_Region_11 <- Volga_Region_11[-(1:10), ]
Volga_Region_12 <- Russian_regions[Russian_regions$NL_NAME_1 == "Кировская область",]
Volga_Region_12 <- Volga_Region_12[-(1:10), ]
Volga_Region_13 <- Russian_regions[Russian_regions$NL_NAME_1 == "Нижегородская область",]
Volga_Region_13 <- Volga_Region_13[-(1:10), ]
Volga_Region_14 <- Russian_regions[Russian_regions$NL_NAME_1 == "Удмуртия",]
Volga_Region_14 <- Volga_Region_14[-(1:10), ]



Volga_Region <- rbind(Volga_Region_1, Volga_Region_2, Volga_Region_3, Volga_Region_4, Volga_Region_5,
                      Volga_Region_6, Volga_Region_7, Volga_Region_8, Volga_Region_9, Volga_Region_10,
                      Volga_Region_11, Volga_Region_12, Volga_Region_13, Volga_Region_14)



# Проверяем посредством построения карты ПФО
ggplot(data = Volga_Region) + 
  geom_sf() + 
  scale_fill_viridis_c()


### Далее работаем с таблицей,в которой представлены результаты выборов в ПФО


g <- g[c(1, 3, 11, 13, 2, 7, 6, 5, 9, 14, 12, 10, 8, 4), ]


# Объединяем два получившихся датафрейма
temp_1  <- merge(Volga_Region, g, by.x = "NL_NAME_1", by.y = "Regions") 
colnames(temp_1)




picture <-  ggplot(data = temp_1, aes(fill =as.numeric(as.character(temp_1$X2016)))) + 
  geom_sf() + 
  labs(title="Выборы в Госдуму 2016 года в ПФО")+
  scale_fill_viridis_c(direction = -1, name="% голосов за партию \n
                       Единая Россия", limits=c(10, 95), aesthetics = "fill") +
  #guides(fill = guide_legend(reverse=TRUE)) +
  #guide_legend("Жители региона старше 59 лет")+
  theme(legend.position="bottom")+
  theme_modern_rc()
