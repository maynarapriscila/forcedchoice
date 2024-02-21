library(RecodeFCit)
library(lavaan)
library(thurstonianIRT)
library(readr)

#### carregar o banco ####
data <- read.csv(
  url(
    "https://github.com/maynarapriscila/forcedchoice/raw/main/data.csv"
  ), sep =  ";"
)

#### para ajustar o banco ####
?recodeErrors
data2<-recodeErrors(banco,Cd=c("a","b","c"))

?recodeData
datacod <- recodeData(data2, Cd=c ("a", "b","c"))
dataLavaan <- datacod[-c(1,2),]

#### define os blocos de itens ####
blocks <-
  set_block(c("i1", "i2", "i3"), traits = c("t1", "t2", "t4"), 
            signs = c(1, 1, 1)) +
  set_block(c("i4", "i5", "i6"), traits = c("t1", "t4", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i7", "i8", "i9"), traits = c("t1", "t2", "t3"), 
            signs = c(1, 1, 1)) +
  set_block(c("i10", "i11", "i12"), traits = c("t1", "t3", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i13", "i14", "i15"), traits = c("t1", "t2", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i16", "i17", "i18"), traits = c("t1", "t3", "t4"), 
            signs = c(-1, -1, -1)) +
  set_block(c("i19", "i20", "i21"), traits = c("t1", "t3", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i22", "i23", "i24"), traits = c("t1", "t4", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i25", "i26", "i27"), traits = c("t1", "t2", "t3"), 
            signs = c(1, 1, -1)) +
  set_block(c("i28", "i29", "i30"), traits = c("t1", "t3", "t5"), 
            signs = c(1, 1, -1)) +
  set_block(c("i31", "i32", "i33"), traits = c("t1", "t2", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i34", "i35", "i36"), traits = c("t1", "t3", "t4"), 
            signs = c(1, -1, 1)) +
  set_block(c("i37", "i38", "i39"), traits = c("t2", "t3", "t4"), 
            signs = c(-1, -1, -1)) +
  set_block(c("i40", "i41", "i42"), traits = c("t2", "t3", "t5"), 
            signs = c(-1, -1, -1)) +
  set_block(c("i43", "i44", "i45"), traits = c("t2", "t4", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i46", "i47", "i48"), traits = c("t2", "t3", "t4"), 
            signs = c(-1, 1, 1)) +
  set_block(c("i49", "i50", "i51"), traits = c("t2", "t4", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i52", "i53", "i54"), traits = c("t2", "t4", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i55", "i56", "i57"), traits = c("t3", "t4", "t5"), 
            signs = c(1, 1, 1)) +
  set_block(c("i58", "i59", "i60"), traits = c("t2", "t3", "t4"), 
            signs = c(1, 1, 1))

#### gerar os dados ####
?make_TIRT_data
triplets_long <- make_TIRT_data(data = dataLavaan,
                                blocks = blocks,
                                format = "pairwise")

#### Ajuste dos dados usando o Lavaan ####
?fit_TIRT_lavaan
fit <- fit_TIRT_lavaan(triplets_long,
                       estimator = 'WLSMV')

summary(fit, fit.measures=T, standardized = T)
