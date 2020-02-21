library(xlsx)
library(reshape2)
library(ggplot2)
library(ggalt)
###test

###

fieldwork_EQLS <- read.xlsx("data/fieldworkprogress.xlsx", sheetIndex=1, header=T, colIndex = c(2:29))
fieldwork_EQLS$week <- rownames(fieldwork_EQLS)
fieldwork_EWCS <- read.xlsx("data/fieldworkprogress.xlsx", sheetIndex=2, header=T, colIndex = c(2:29))
fieldwork_EWCS$week <- rownames(fieldwork_EWCS)

EQLS_melt <- melt(fieldwork_EQLS)
EQLS_melt$Survey <- "EQLS"
EWCS_melt <- melt(fieldwork_EWCS)
EWCS_melt$Survey <- "EWCS"

df <- rbind(EQLS_melt,EWCS_melt)
df$week <- as.numeric(df$week)

ggplot(df, aes(x=week,y=value, fill=Survey, group=Survey, colour=Survey)) +
  scale_fill_manual(values=EF_2c2) +
  scale_colour_manual(values=EF_2c2) +
  geom_density(stat="identity", alpha=0.5) +
    facet_wrap(~variable) +
  ylab("Share of interviews") +
  xlab("Fieldwork week") +
  theme_minimal() + 
  theme(legend.position=c(.9,.05))

###

RR <- read.xlsx("data/response_rates.xlsx", sheetIndex=1, header=T)
RR$dif <- sqrt((RR$EWCS-RR$EQLS)^2)

ggplot(RR, aes(x=EQLS,xend=EWCS, y=reorder(Country, dif))) +
 geom_dumbbell(colour="grey80", size=1,
               colour_x=EF_green,size_x = 3.5,
               colour_xend=EF_orange, size_xend = 3.5) +
               geom_vline(xintercept=43,linetype="dashed",colour=EF_orange) + 
               geom_vline(xintercept=37,linetype="dashed",colour=EF_green)+ 
   expand_limits(y = c(-1, 30)) +
   geom_rect(xmin=0,xmax=80,ymin=28.5,ymax=30,fill="white")+
   geom_rect(xmin=0,xmax=80,ymin=-1,ymax=0.5,fill="white")+
   scale_x_continuous(breaks=c(0,10,20,30,40,50,60,70)) +
   annotate("text", x = 25, y = 29, label = "EQLS", colour=EF_green,fontface="bold", size=3.3) +
   annotate("text", x = 64, y = 29, label = "EWCS", colour=EF_orange,fontface="bold", size=3.3) +
   annotate("text", x = 36, y = 0, label = "EQLS total", colour=EF_green,fontface="bold", size=3.3) +
   annotate("text", x = 44, y = 0, label = "EWCS total", colour=EF_orange,fontface="bold", size=3.3) +
   xlab("Response rate") +
   theme_minimal() +
   theme(axis.title.y=element_blank(),
         axis.title.x=element_text(size=9))


