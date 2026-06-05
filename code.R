library(wooldridge)
data("countymurders")
 
#Construção/Alteração do dataset
countymurders <- countymurders[countymurders$year==1980 & countymurders$density <= 11000,]
data2 <- countymurders[,c(1,3,5,6,7,8,13)]

View(data2)

#Cálculo dos percentis (25, 50 e 75) 
q <- quantile(data2$density, probs = seq(0, 1, 0.25), na.rm = TRUE)

#Quantil1 = 0%; Quantil2 = 25% ...
data2$density_cat <- ifelse(data2$density <= q[2], "Low",
                            ifelse(data2$density <= q[3], "Lower-Mid",
                                   ifelse(countymurders$density <= q[4], "Upper-Mid", "High")))

table(data2$density_cat)

#Seleção das variáveis a serem estudadas
data2 <- data2[,c(1,3,4,5,6,7,8)]

str(data2)

#Transformação das classes de variáveis
data2$density_cat <- as.factor(data2$density_cat)
data2$arrests <- as.numeric(data2$arrests)
data2$murders <- as.numeric(data2$murders)

#Tratamento de Missing Values
sum(is.na(data2$arrests))
data2 <- data2[!is.na(data2$arrests), ]
sum(is.na(data2$arrests)) #verificar se foi retirado

#Considerar High Murder Zone, counties com murders>25 e Non High Murder Zone, counties com murders<=25
attach(data2)
HighMrdZone <- data2[murders > 25, ]
View(HighMrdZone)

NHighMrdZone <- data2[murders <= 25, ]
View(NHighMrdZone)

# Descriptive Statistics/Análise Numérica

data2$highmrdzone_var <- ifelse(murders>25, 1, 0)
attach(data2)

# Arrests

par(mfrow=c(3,2))
hist(arrests, freq = FALSE, xlim = c(0,1664), breaks=50) 
boxplot(arrests) 

hist(HighMrdZone$arrests, freq = FALSE, xlim = c(0,1664), breaks=50) 
boxplot(HighMrdZone$arrests) 

hist(NHighMrdZone$arrests, freq = FALSE, xlim = c(0,1664), breaks=50)
#zoom in
#hist(NHighMrdZone$arrests, freq = FALSE, xlim = c(0,60), breaks=50)
boxplot(NHighMrdZone$arrests)

#Gráficos muito assimétricos, então usamos a mediana e a diferença interquartil para analisar esta variável

tapply(arrests, highmrdzone_var,
       function(x){round(c(median(x),IQR(x)), 3)})

#HighZone: 43, 42   NonHighZone: 1, 3

median(arrests) #1
IQR(arrests) #4

par(mfrow=c(1,2))
boxplot(arrests ~ highmrdzone_var) 
boxplot(arrests ~ highmrdzone_var, ylim=c(0, 500))
#boxplot(arrests ~ highmrdzone_var, ylim=c(0, 100)) #dá para ver uma grande diferenca
wilcox.test(arrests ~ highmrdzone_var) 
#Rejeitamos H0, logo podemos dizer que as medianas são significamente diferentes
#p-value:2.2e-16

# Percentage of people of age 10-19

par(mfrow=c(3,2))
hist(perc1019, freq = FALSE, breaks=50) 
boxplot(perc1019)

hist(HighMrdZone$perc1019, freq = FALSE, breaks=50) 
boxplot(HighMrdZone$perc1019) 

hist(NHighMrdZone$perc1019, freq = FALSE, breaks=50) 
boxplot(NHighMrdZone$perc1019) 

#Gráficos relativamente simétricos, logo usamos a média e erro padrão

tapply(perc1019, highmrdzone_var,
       function(x){round(c(mean(x),sd(x)), 3)})

#HighZone: 17.339  1.294   NonHighZone: 17.687  1.705

mean(perc1019) # 17.67162
sd(perc1019) # 1.689984

par(mfrow=c(1,1))
boxplot(perc1019 ~ highmrdzone_var) 
t.test(perc1019 ~ highmrdzone_var) 
t.test(HighMrdZone$perc1019, NHighMrdZone$perc1019) #exatamente o mesmo valor
#Rejeitamos H0, pois sd é muito pequeno e a sample é muito grande, então o teste deteta uma diferença significativa entre as médias

# Percentage of people of age 20-29

par(mfrow=c(3,2))
hist(perc2029, freq = FALSE, breaks=50) 
boxplot(perc2029) 

hist(HighMrdZone$perc2029, freq = FALSE, breaks=50)
boxplot(HighMrdZone$perc2029) 

hist(NHighMrdZone$perc2029, freq = FALSE, breaks=50) 
boxplot(NHighMrdZone$perc2029) 

#O primeiro histograma aparenta ser simétrico, já o seu boxplot sugere a presença de muitos outliers dum lado
#Segundo histograma muito assimétrico e dados com muitos outliers, logo assumimos usar a mediana e a diferença interquartil para analisar esta variável

tapply(perc2029, highmrdzone_var,
       function(x){round(c(median(x),IQR(x)), 3)})

#HighZone: 18.65  2.44    NonHighZone: 15.750  2.735

median(perc2029) #15.86
IQR(perc2029) #2.945

par(mfrow=c(1,1))
boxplot(perc2029 ~ highmrdzone_var) 
wilcox.test(perc2029 ~ highmrdzone_var) 
#Rejeitamos H0, p-value:2.2e-16

# Percentage of Black

par(mfrow=c(3,2))
hist(percblack, freq = FALSE, breaks=50) 
boxplot(percblack) 

hist(HighMrdZone$percblack, freq = FALSE, breaks=50) 
boxplot(HighMrdZone$percblack) 

hist(NHighMrdZone$percblack, freq = FALSE, breaks=50) 
boxplot(NHighMrdZone$percblack) 

#Gráficos muito assismétricos, então usamos a mediana e a diferença interquartil para analisar esta variável

tapply(percblack, highmrdzone_var,
       function(x){round(c(median(x),IQR(x)), 3)})
#HighZone: 10.84 13.91    NonHighZone: 1.150 7.392

median(percblack) #1.4
IQR(percblack) #8.71

par(mfrow=c(1,1))
boxplot(percblack ~ highmrdzone_var)
wilcox.test(percblack ~ highmrdzone_var)
#Rejeitamos H0 para um valor do p-value: 2.2e-16, há uma diferença muito significativa entre as medianas

# Percentage of Male

par(mfrow=c(3,2))
hist(percmale, freq = FALSE, breaks=50) 
boxplot(percmale) 

hist(HighMrdZone$percmale, freq = FALSE, breaks=50) 
boxplot(HighMrdZone$percmale) 

hist(NHighMrdZone$percmale, freq = FALSE, breaks=50) 
boxplot(NHighMrdZone$percmale) 

#Assumimos a simetria dos gráficos, logo usamos a média e erro padrão

tapply(percmale, highmrdzone_var,
       function(x){round(c(mean(x),sd(x)), 3)})
#HighZone: 40.965  1.293    NonHighZone: 41.388  1.602

mean(percmale) #41.36858
sd(percmale) #1.591416

par(mfrow=c(1,1))
boxplot(percmale ~ highmrdzone_var)
t.test(percmale ~ highmrdzone_var) 
#Rejeitamos H0 para p-value: 0.002962

# Murders

par(mfrow=c(3,2))
hist(murders, freq = FALSE, breaks=50) 
boxplot(murders) 

hist(HighMrdZone$murders, freq = FALSE, breaks=50) 
boxplot(HighMrdZone$murders) 

hist(NHighMrdZone$murders, freq = FALSE, breaks=50) 
boxplot(NHighMrdZone$murders) 

#Gráficos muito assimetricos, então usamos a mediana e a diferença interquartil para analisar esta variável

tapply(murders, highmrdzone_var,
       function(x){round(c(median(x),IQR(x)), 3)})
#HighZone: 48 60    NonHighZone: 1 3

median(murders) #1
IQR(murders) #4

par(mfrow=c(1,1))
boxplot(murders ~ highmrdzone_var) #nao da ver a diferenca
boxplot(murders ~ highmrdzone_var, ylim=c(0, 300)) #ja da pra ver uma clara diferenca e faz sentido que haja esta diferenca pois nos definimos highmrdzone como zonas com maior numero de murders
wilcox.test(murders ~ highmrdzone_var)
#p-value:2.2e-16

# Density Category

table(density_cat)
prop.table(table(density_cat))

table(density_cat, highmrdzone_var)
prop.table(table(density_cat, highmrdzone_var),2) #soma das colunas da 1 (100%)

chisq.test(table(density_cat, highmrdzone_var)) 
#Rejeitamos H0


#Visualização dos Gráficos

library(ggplot2)
attach(data2)
#Scatter Plot para Análise das relações entre as variáveis murders, 
#percblack, arrests e perc2029
ggplot(data2[murders<50,], aes(x=percblack, y=murders, color=perc2029, size=arrests)) +
  geom_point(alpha=0.7) +
  scale_color_gradient(low="lightgreen", high="darkred") +
  labs(title="Homicídios vs % População Negra",
       x="% População Negra", y="Nº de homicídios",
       color="% Pop. 20-29 anos", size="Detenções")
#só é possível ver uma relação entre o número de murders com o número de arrests

#Scatter Plot para Análise das relações entre as variáveis murders, percblack, 
#arrests e perc1019
ggplot(data2[murders<50,], aes(x=percblack, y=murders, color=perc1019, size=arrests)) +
  geom_point(alpha=0.7) +
  scale_color_gradient(low="yellow", high="brown") +
  labs(title="Homicídios vs % População Negra",
       x="% População Negra", y="Nº de homicídios",
       color="% Pop. 10-19 anos", size="Detenções")
#situação igual ao gráfico anterior

cor(percblack, murders)
cor.test(percblack, murders) #correlação significativa mas não relevante

cor.test(murders, arrests)#significativa e relevante

#Gráfico da relação entre o número de homicídios e o número de detenções, 
#com a variável percblack representada com cor
ggplot(data2[murders<50,], aes(x=murders, y=arrests, color=percblack)) +
  geom_point() +
  geom_smooth(method=lm, formula= y ~ x) +
  scale_color_gradient(low="orange", high="black") +
  labs(title="Relação entre Nº de Homicídios e Nº de Detenções",
       x="Nº de Homicídios", y="Nº de Detenções",
       color="% Pop. Negra")
#relacao entre homicidios e detencoes

#Gráfico de Homicídios vs. Densidade Populacional, com a percentagem de 
#população masculina representada nas cores dos pontos
ggplot(data2[murders<50,], aes(x=density_cat, y=murders, color=percmale)) +
  geom_boxplot()+
  geom_jitter(width=0.15)+
  scale_color_gradient(low="lightpink", high="darkblue")+
  labs(title="Homicídios vs Densidade Populacional",
       x="Densidade Populacional", y="Nº de homicídios",
       color="% Pop. Masculina") +
  scale_x_discrete(limits=c("Low", "Lower-Mid", "Upper-Mid", "High"))
#relacao entre densidade pop e murders
cor.test(percmale, murders)
#p-value: 0.1515, a correlação não é significativamente diferente de 0


#Violin Plot para Análise da Distribuição da variável perc2029
#em relação à variável highmrdzone_var
ggplot(data2, aes(x=factor(highmrdzone_var), y=perc2029, fill=factor(highmrdzone_var))) +
  geom_violin() +
  labs(x="Zona homicídios altos",
       y="% População 20–29",
       title="Distribuição % Pop. 20–29") +
  scale_fill_manual(values=c("pink", "red")) +
  theme_minimal()
#diferenca pequena

#Violin Plot para Análise da Distribuição da variável percblack 
#em relação à variável highmrdzone_var
ggplot(data2, aes(x=factor(highmrdzone_var), y=percblack, fill=factor(highmrdzone_var))) +
  geom_violin() +
  labs(x="Zona homicídios",
       y="% populacao negra",
       title="Distribuição % Pop. negra") +
  scale_fill_manual(values=c("pink", "red")) +
  theme_minimal()
#diferenca pequena

#Violin Plot para Análise da Distribuição da variável perc1019
#em relação à variável highmrdzone_var
ggplot(data2, aes(x=factor(highmrdzone_var), y=perc1019,fill=factor(highmrdzone_var))) +
  geom_violin() +
  labs(x="Zona homicídios altos",
       y="% População 10–19",
       title="Distribuição % Pop. 20–29") +
  scale_fill_manual(values=c("pink", "red")) +
  theme_minimal()
#diferenca pequena