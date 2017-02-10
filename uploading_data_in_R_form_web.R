library("quantmod") # пакет для загрузки с finance.google.com

#finance.google.com

#загрузим цены акций компании Apple


help("Sys.setlocale")
Sys.getlocale()
Sys.setlocale("LC_TIME","C")


getSymbols(Symbols = "AAPL", from="2017-01-01", to="2017-02-01", source="google")


head(AAPL)


tail(AAPL)# как мы видим загрузился временной ряд с 01-01 по 01-02.
