# ggplot2

# Instalacion de la libreria 
# install.packages('tidyverse')


# Cargar librerias 
library(tidyverse)
library(readxl)


# seccion de trabajo
setwd("C:/Users/luisj/Dropbox/Ciencia_de_datos/Portafolio/R/03_ggplot")

# Datos datos excel. Base de datos del inegi, muestreo de los ingresos 
# de las personas

enoe <- read_xlsx("mu_enoe.xlsx")

# Conocer el tipo de datos.
class(enoe)
# Obsevaciones vs variables
dim(enoe)

#nombres de las  variables
colnames(enoe)

# Gráficas en ggplot

# En este caso estamos viendo si hay correlacion entre años de escolaridad 
# con el ingreso mensual. 

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual))

# modificaiones

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual), color = "blue")

# Mapeos estéticos
# identificar empleos formales contra informales por medio de color.

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual, color = tipo_empleo))

