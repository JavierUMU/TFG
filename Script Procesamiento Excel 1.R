library(readxl)
library(openxlsx)

# Establecer la ubicación del directorio que contiene los archivos Excel
directorio_excel <- "C:/Users/Javi PC/Desktop/1-Modificaciones"

# Obtener la lista de archivos Excel en el directorio especificado
archivos_excel <- list.files(directorio_excel, pattern = "\\.xlsx$", full.names = TRUE)

# Inicializar un vector para almacenar todas las palabras únicas
todas_las_columnas <- character(0)

# Leer cada archivo Excel y extraer los nombres de las columnas
for (archivo_excel in archivos_excel) {
  nombres_columnas <- colnames(read_excel(archivo_excel))
  todas_las_columnas <- union(todas_las_columnas, nombres_columnas)
}

print(todas_las_columnas)

#writeLines(paste('"', todas_las_columnas, '"', sep = "", collapse = ", "), "archivo2.txt")

#ESTA PARTE DEL SCRIPT REMPLAZA LAS COLUMNAS DE LAS HOJAS EXCEL Y LAS RENOMBRA (SE PUEDE CAMBIAR COMO SE CONVENGA)
# Definir un diccionario de mapeo para los nombres de columnas
mapeo_columnas <- c("OBSER" = "OBSERVACIONES-1",
                    "OBSERVACIONES 2" = "OBSERVACIONES-2",
                    "OBSERVACIONES.2" = "OBSERVACIONES-2",
                    "DUREZA" = "DUREZ",
                    "Código" = "Codigo",
                    "D2021" = "DESCE",
                    "mantener/cortar 2023" = "Mantener/Cortar",
                    "mantener/cortar.2023" = "Mantener/Cortar",
                    "AÑO" = "YEAR",
                    "BROTA" = "BP",
                    "FLORA" = "FP",
                    "FP-DESMAYO" = "FL-DESMAYO",
                    "FP-FERRAGNES" = "FL-FERRAGNES",
                    "FL-FERRGANES" = "FL-FERRAGNES",
                    "FP-TARDONA" = "FL-TARDONA",
                    "FP-PENTA" = "FL-PENTA",
                    "FP-S5133" = "FL-S5133",
                    "FP-R1000" = "FL-R1000",
                    "FP-ACHAAK" = "FL-ACHAAK",
                    "FAMIL" = "FAMILIA",
                    "AUTSP" = "AC",
                    "AUTO" = "AC",
                    "AUTO-SP" = "AC",
                    "AUTAR" = "AUTPC"
)

# Iterar sobre los archivos Excel
for (archivo_excel in archivos_excel) {
  # Leer el archivo Excel
  datos_excel <- read_excel(archivo_excel)
  
  # Obtener los nombres de las columnas
  nombres_columnas <- colnames(datos_excel)
  
  # Iterar sobre los nombres de las columnas y renombrar según criterios
  for (i in seq_along(nombres_columnas)) {
    if (nombres_columnas[i] %in% names(mapeo_columnas)) {
      nombres_columnas[i] <- mapeo_columnas[nombres_columnas[i]]
    }
  }
  
  # Asignar los nuevos nombres de columnas al conjunto de datos
  colnames(datos_excel) <- nombres_columnas
  
  # Escribir los datos con los nuevos nombres de columnas de vuelta al archivo Excel
  write.xlsx(datos_excel, archivo_excel)
}
  
#NO PUEDO COMBINAR AUTPO NI AUTOPO EN AUTPI OSEA QUE LO TENGO QUE HACER MANUALMENTE

#ESTA PARTE DEL SCRIPT SE REALIZA UN DATAFRAME CON TODAS LAS COLUMNAS Y SE VA AÑADIENDO LOS VALORES DE LOS CARACTERES DESDE LAS HOJAS EXCEL
# Crear un dataframe vacío con columnas para cada nombre de columna única
DF <- data.frame(matrix(ncol = length(todas_las_columnas), nrow = 0))
colnames(DF) <- todas_las_columnas

# Leer archivos Excel y llenar dataframe
for (archivo_excel in archivos_excel) {
  # Leer el archivo Excel
  datos_excel <- read_excel(archivo_excel)
  
  # Asegurarse de que los nombres de las columnas coincidan
  nombres_columnas_excel <- colnames(datos_excel)
  nombres_faltantes <- setdiff(todas_las_columnas, nombres_columnas_excel)
  for (nombre_faltante in nombres_faltantes) {
    datos_excel[[nombre_faltante]] <- NA
  }
  
  # Reordenar las columnas para que coincidan con DF
  datos_excel <- datos_excel[, todas_las_columnas]
  
  # Agregar los datos del archivo Excel al dataframe combinado
  DF <- rbind(DF, datos_excel)
}

# Visualizar los primeros registros del dataframe combinado
head(DF)
write.xlsx(DF, "C:/Users/Javi PC/Desktop")

