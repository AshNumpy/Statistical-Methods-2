#---------------
# Verilerin i�eri aktar�lmas�
#---------------
library(readxl)
data = read_excel(path = "C:/Users/lenovo/Documents/GitHub/StatMeth2/Statistical-Methods-2/Latin_Square/data_ls.xlsx",
                col_names = TRUE)

head(data)
str(data)

#--------------------
# Veri yap�s�na bak�l�p sat�r ve s�tunlara ait de�erler girildi�inde:
#---1-2-3-4-
#-1-B-D-C-A-
#-2-C-A-D-B-
#-3-A-C-B-D-
#-4-D-B-A-C-
# �eklinde Latin Kare yap�m�z ortaya ��k�yor


#--------------------
# De�i�kenlerin yap�s�n� fakt�re d�n��t�rme
#--------------------
data$Row <- as.factor(data$Row)
data$Column <- as.factor(data$Column)
data$Varieties <- as.factor(data$Varieties)
str(data)

attach(data)

#------------------------------------
# 'Model' de�i�kenine ANOVA uygulama
#------------------------------------
model <- lm(Yield ~ Row+Column+Varieties)
anova(model)#�e�itlerin verdi�i verimler aras� fark var

#--------------------
# Ortalama Kar��la�t�rma testi
#--------------------
library(agricolae)
# LSD test
LSD.test(y = model,
         trt = "Varieties",
         DFerror = model$df.residual,
         MSerror = deviance(model)/model$df.residual,
         alpha = 0.05,
         group = TRUE,
         console = TRUE)


# SNK test
SNK.test(y = Yield,
         trt = Varieties,
         DFerror = model$df.residual,
         MSerror = deviance(model)/model$df.residual,
         alpha = 0.05,
         group = TRUE,
         console = TRUE)


#--------------------
# LSD ve SNK testine g�re s�ylenebilir ki A �e�idinin verimi di�erlerinden farkl�d�r.
#--------------------