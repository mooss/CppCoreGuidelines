use strict;
use warnings;
use v5.14;

# Transform the tab-based code blocks of a markdown file into specific C++ code blocks.
# Used on CppCoreGuidelines in conjunction with pandoc in order to produce a prettified pdf suiting my taste.

my @codelines = ();
my $current_indentation = 0;
while(my $line = <>){
    my $indentation = 0;
    if($line =~ m/^( +)/){
        $indentation = length($1);
    }

    my $inside_code_block = $indentation >= $current_indentation || $line =~ m/^$/;
    $line =~ s/^    //;

    if($inside_code_block){
        if(@codelines > 0){
            # Code block already started.
            push @codelines, $line;
        }
        elsif($indentation < 4){
            # Not inside pre-existing code block and empty line.
            print $line;
        }
        else{
            # First proper line of code block.
            $current_indentation = $indentation;
            push @codelines, $line;
        }
    }
    else{
        if(@codelines > 0){
            # Do not include leading and trailing empty lines into the code block.
            my @head = ();
            my @tail = ();
            while(1){
                last if @codelines == 0 or $codelines[0] ne "\n";
                push @head, shift @codelines;
            }
            while(1){
                last if @codelines == 0 or $codelines[-1] ne "\n";
                push @tail, pop @codelines;
            }

            # Print head, codeblock proper and tail.
            print join "", @head;
            if(@codelines > 0){
                say "```C++";
                print join "", @codelines;
                say "```";
            }
            print join "", @tail;
            @codelines = ();
            $current_indentation = 0;
        }
        print $line;
    }
}
