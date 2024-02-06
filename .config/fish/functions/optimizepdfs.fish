function optimizepdfs
	mkdir -p optimized && find . -maxdepth 1 -name '*.pdf' -exec ps2pdf -dPDFSETTINGS=/ebook {} optimized/{} \;
end
