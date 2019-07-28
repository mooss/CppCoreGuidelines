pdf: cpp_core_guidelines.pdf

cpp_core_guidelines.md: CppCoreGuidelines.md
	perl instantiate_code_blocks.pl $^ > $@

cpp_core_guidelines.pdf: cpp_core_guidelines.md
	pandoc 	--standalone\
		--to latex $^\
		--output $@\
		--template template.tex\
		--highlight-style tango\
		--variable toc-title:'Table of contents'\
		--variable toc-depth:2\
		--variable lang:en\
		--table-of-content

clean:
	rm cpp_core_guidelines.{pdf,md} -f
