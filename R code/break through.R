head(mpg)
str(mpg)
qplot(displ, hwy, data = mpg, colour = factor(cyl))

p <- qplot(displ, hwy, data = mpg, colour = factor(cyl))  ## �إ߹ϧ�
print(p)                                                  ## �L�X�ϧ�
ggsave("plot.png", width = 480, height =240)              ## �O�s�ϧ�
summary(p)                                                ## �i�ܹϧΤ��e
save(p, file = "qplot.rdata")                              ## �O�s�ϧι�H
load("qplot.rdata")                                        ## ���J�ϧι�H