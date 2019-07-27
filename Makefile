pdf: cpp_core_guidelines.pdf

cpp_core_guidelines.md: CppCoreGuidelines.md
	perl instantiate_code_blocks.pl $^ > $@

cpp_core_guidelines.pdf: cpp_core_guidelines.md
	pandoc 	--standalone\
		--to latex $^\
		--output $@\
		--include-in-header preamble.tex\
		--highlight-style tango\
		--variable documentclass:report\
		--variable geometry:margin=2.5cm\
		--variable papersize:a4paper\
		--variable toc-title:'Table of contents'\
		--table-of-content\
		--variable lang:en

clean:
	rm cpp_core_guidelines.{pdf,md} -f
