setwd("~/Desktop/Alpha/fitModel/prfreq_archive")
max.p <- 0.075 #grid range

#load and do the grid search one by one with each model
#########################
#search s grid
#human(chimp) 2 epoch -s 
x <- read.table("pos_div_s-human-2epoch", header = TRUE) 
neg.div = 38043
Dns = 44665
Ncurr = 16539.26
human2epoch.grid.s <- gridSearch.s()

#human(chimp) 3 epoch - s
x <- read.table("~/Desktop/Alpha/fitModel/prfreq_archive/pos_div_s-3epoch", header=T) #human-chimp-3epoch
neg.div <- 30029
Dns <- 44665
Ncurr <- 16539.26
human.grid.s <- gridSearch.s()

#human(mac) 3 epoch - s
x <- read.table("pos_div_s_mac_3epoch", header=T) #human-chimp-3epoch
neg.div <- 128628
Dns <- 182532
Ncurr <- 16539.26
humanMac.grid.s <- gridSearch.s()

#fly 3 epoch - s
x <- read.table("pos_div_s_fly-3epoch", header=TRUE) #fly-3epoch
neg.div <- 57470 #3epoch
Dns <- 177936
Ncurr <- 7616700
fly.grid.s <- gridSearch.s()

#fly 2 epoch -s
x <- read.table("pos_div_s-fly-2epoch", header=TRUE) #fly-3epoch
neg.div = 73892.521424 #2epoch
Dns <- 177936
Ncurr <- 7616700
fly2epoch.grid.s <- gridSearch.s()

# mice 2 epoch -s 
x <- read.table("pos_div_s-mice-2epoch", header=TRUE) #mice-rat-2epoch
neg.div <- 320817.4114
Dns <- 613281
Ncurr <- 488948.1
mice2epoch.grid.s <- gridSearch.s()

# mice 3 epoch -s 
x <- read.table("pos_div_s-mice-3epoch", header=TRUE)
neg.div <- 379350.549982
Dns <- 613281
Ncurr <- 488948.1
mice3epoch.grid.s <- gridSearch.s()

#########################
#search ns (gamma) grid
#human(chimp) 2 epoch -ns
x = read.table("pos_div-human-ns-2epoch", header =T) #gamma, div
neg.div = 38043
Dns = 44665
Ncurr = 16539.26
human2epoch.grid.ns <- gridSearch.ns()

#human(chimp) 3 epoch -ns
x <- read.table("pos_div-3epoch", header=T) #human-chimp-3epoch
neg.div <- 30029
Dns <- 44665
Ncurr <- 16539.26
human.grid.ns <- gridSearch.ns()

#human(mac) 3 epoch - ns
x <- read.table("pos_div_mac_3epoch", header=T) #human-chimp-3epoch
neg.div <- 128628
Dns <- 182532
Ncurr <- 16539.26
humanMac.grid.ns <- gridSearch.ns()

#fly 3 epoch -ns
x <- read.table("pos_div_fly-3epoch", header=TRUE) 
neg.div <- 57470 #3epoch
#neg.div = 73892.521424 #2epoch
Dns <- 177936
Ncurr <- 7616700
fly.grid.ns <- gridSearch.ns()

#fly 2 epoch -ns
x <- read.table("pos_div-fly-ns-2epoch", header=TRUE) 
neg.div = 73892.521424 #2epoch
Dns <- 177936
Ncurr <- 7616700
fly2epoch.grid.ns <- gridSearch.ns()

#mice 2 epoch -ns
x <- read.table("pos_div_ns-mice-2epoch", header=TRUE) #mice-rat-2epoch
neg.div <- 320817.4114
Dns <- 613281
Ncurr <- 488948.1
mice2epoch.grid.ns <- gridSearch.ns()

# mice 3 epoch -ns
x <- read.table("pos_div_ns-mice-3epoch", header=TRUE)
neg.div <- 379350.549982
Dns <- 613281
Ncurr <- 488948.1
mice3epoch.grid.ns <- gridSearch.ns()

#save gridSearch data
save(fly.grid.ns, fly.grid.s, fly2epoch.grid.ns, fly2epoch.grid.s, human.grid.ns,human.grid.s, human2epoch.grid.ns, human2epoch.grid.s, humanMac.grid.ns, humanMac.grid.s, mice2epoch.grid.ns, mice2epoch.grid.s, mice3epoch.grid.ns, mice3epoch.grid.s, file="alpha.grids.Rda")

#############functions############
#grid search for log10s
gridSearch.s <- function(){
  y <- matrix(nrow=nrow(x)*1001, ncol=4, dimnames=list(c() ,c("p", "gamma", "log.s", "LL")))
  m=1
  for (n in 1:nrow(x)){
    pos.div = x$div[n]
    for (p in seq(0,max.p,max.p/1000)){
      Dns.exp = p*pos.div + (1-p)*neg.div
      LL = dpois(Dns, Dns.exp, log = TRUE) 
      gamma = (10**x$log10s[n])*2*Ncurr
      y[m,] <- c(p,gamma,x$log10s[n],LL)
      m=m+1
    }
  }
  return(y)
}

#grid search for gamma
gridSearch.ns <- function(){
  y <- matrix(nrow=nrow(x)*1001, ncol=4, dimnames=list(c() ,c("p", "gamma", "log.s", "LL")))
  m=1
  for (n in 1:nrow(x)){
    pos.div = x$div[n]
    for (p in seq(0,max.p,max.p/1000)){
      Dns.exp = p*pos.div + (1-p)*neg.div
      LL = dpois(Dns, Dns.exp, log = TRUE) 
      log10s = log10(x$gamma[n]/(2*Ncurr))
      y[m,] <- c(p,x$gamma[n],log10s,LL)
      m=m+1
    }
  }
  return(y)
}