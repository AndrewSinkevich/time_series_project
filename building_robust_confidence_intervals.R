library("lubridate") # работа с датами
library("sandwich") # робастные стандартные ошибки
library("lmtest") # тесты
library("zoo") # временные ряды
library("dplyr") # манипуляции с данными
library("ggplot2") # построение графиков


data("Investment")



d<-as.zoo(Investment) # неупорядоченный временной ряд

autoplot(d[,1:2]) # построим графики 1-го и 2-го столбика из Investment

autoplot(d[,1:2], facets = NULL) # построим графики 1-го и 2-го столбика из Investment на одном графике


model<-lm(data=d, RealInv~RealInt+RealGNP)

summary(model)


coeftest(model)#посмотрим на проверку гипотез о равенстве коэффициентов 0

confint(model)#доверительные интервалы для коэффициентов модели


library(broom)
d_aug<- augment(model, as.data.frame(d))#добавляем в 


#as.data.frame(d) потому что d надо перевести из формата временного ряда в формат дата фрейма - таблички

glimpse(d_aug)#посмотрим как теперь выглядит наша дополненная таблица

qplot(data=d_aug, lag(.resid), .resid)#построим график, где по горизонтали предшествующее значение остатка, по вертикали сам остаток


vcov(model)#ковариационная матрица оценок коэффициентов

vcovHAC(model)#ковариационная матрица оценок коэффициентов, устойчивая к автокорреляции


#Коррекция на автокорреляцию
coeftest(model, vcov.=vcovHAC(model)) #робастные коффициенты

#робастные доверительные интервалы
conftable<-coeftest(model, vcov.=vcovHAC(model))

ci<-data.frame(estimate=conftable[,1], se_ac=conftable[,2])
ci

ci<-mutate(ci, left95= estimate - 1.96*se_ac , right95= estimate + 1.96*se_ac)
ci
