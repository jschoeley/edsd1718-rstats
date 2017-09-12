rm(list = ls())

pdf("figarray.pdf", width=10, height=8)

plot(1:7, 1:7, t="n", ylim=c(0.3,5), xlab="", ylab="", xlim=c(0.3, 7),
     axes=FALSE)
polygon(x=c(3,7,7,3), y=c(3,3,5,5), lwd=4, col="white")
segments(x0=4, y0=3, x1=4, y1=5, col="grey", lty=2)
segments(x0=5, y0=3, x1=5, y1=5, col="grey", lty=2)
segments(x0=6, y0=3, x1=6, y1=5, col="grey", lty=2)
segments(x0=3, y0=4, x1=7, y1=4, col="grey", lty=2)

polygon(x=c(2,6,6,2), y=c(2,2,4,4), lwd=4, col="white")
segments(x0=3, y0=2, x1=3, y1=4, col="grey", lty=2)
segments(x0=4, y0=2, x1=4, y1=4, col="grey", lty=2)
segments(x0=5, y0=2, x1=5, y1=4, col="grey", lty=2)
segments(x0=2, y0=3, x1=6, y1=3, col="grey", lty=2)

polygon(x=c(1,5,5,1), y=c(1,1,3,3), lwd=4, col="white")
segments(x0=2, y0=1, x1=2, y1=3, col="grey", lty=2)
segments(x0=3, y0=1, x1=3, y1=3, col="grey", lty=2)
segments(x0=4, y0=1, x1=4, y1=3, col="grey", lty=2)
segments(x0=1, y0=2, x1=5, y1=2, col="grey", lty=2)

text(1.5, 2.5, "[1,1,1]", cex=1.7)
text(1.5, 1.5, "[2,1,1]", cex=1.7)
text(2.5, 2.5, "[1,2,1]", cex=1.7)
text(2.5, 1.5, "[2,2,1]", cex=1.7)
text(3.5, 2.5, "[1,3,1]", cex=1.7)
text(3.5, 1.5, "[2,3,1]", cex=1.7)
text(4.5, 2.5, "[1,4,1]", cex=1.7)
text(4.5, 1.5, "[2,4,1]", cex=1.7)

text(2.5, 3.5, "[1,1,2]", cex=1.7)
text(3.5, 3.5, "[1,2,2]", cex=1.7)
text(4.5, 3.5, "[1,3,2]", cex=1.7)
text(5.5, 3.5, "[1,4,2]", cex=1.7)
text(5.5, 2.5, "[2,4,2]", cex=1.7)

text(3.5, 4.5, "[1,1,3]", cex=1.7)
text(4.5, 4.5, "[1,2,3]", cex=1.7)
text(5.5, 4.5, "[1,3,3]", cex=1.7)
text(6.5, 4.5, "[1,4,3]", cex=1.7)
text(6.5, 3.5, "[2,4,3]", cex=1.7)

arrows(x0=0.8, y0=1, x1=0.8, y=3, code=3, length=0.1)
text(0.5, 2, "rows", cex=1.7)

arrows(x0=1, y0=0.8, x1=5, y=0.8, code=3, length=0.1)
text(3, 0.5, "columns", cex=1.7)

arrows(x0=1, y0=3.2, x1=2.8, y=5, code=3, length=0.1)
text(1.8, 4.3, "layers", cex=1.7, srt=45)
dev.off()











##END
