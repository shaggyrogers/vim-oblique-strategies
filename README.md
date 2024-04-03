# vim-oblique-strategies

Vim plugin providing a collection of aphorisms.

Intended for use with [vim-startify](https://github.com/mhinz/vim-startify).

## Usage

With [vim-startify](https://github.com/mhinz/vim-startify):

    let g:startify_custom_header_quotes = map(obliqueStrategies#GetAll(), '[v:val]')

To include Startify's predefined quotes:

    let g:startify_custom_header_quotes = map(obliqueStrategies#GetAll(), '[v:val]')
        \ + startify#fortune#predefined_quotes()

Alternatively, use `obliqueStrategies#Get()` in your `g:startify_custom_header`.

## Sources

Primarily taken from:

* [Oblique Strategies, 4th Ed by Peter North and Brian Eno](http://www.rtqe.net/ObliqueStrategies/Ed4.html)
* [Oblique Strategies for Programmers by Rob Blackwell](https://github.com/RobBlackwell/oblique-strategies-for-programmers)
* [Oblique Strategies: Prompts for Programmers by Kevin Lawler](https://kevinlawler.com/prompts)
