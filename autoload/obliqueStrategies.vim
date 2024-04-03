""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" obliqueStrategies.vim
" =====================
"
" Description:           A compilation of aphorisms intended to aid problem
"                        solving and inspire creativity.
" Author:                Michael De Pasquale <github.com/shaggyrogers>
" Creation Date:         2019-09-14
" Modification Date:     2024-04-03
"
" Sources
" -------
" Primarily taken from:
"
" * Oblique Strategies, 4th Ed by Peter North and Brian Eno
"   http://www.rtqe.net/ObliqueStrategies/Ed4.html
"
" * Oblique Strategies for Programmers by Rob Blackwell
"   https://github.com/RobBlackwell/oblique-strategies-for-programmers
"
" * Oblique Strategies: Prompts for Programmers by Kevin Lawler
"   https://kevinlawler.com/prompts
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Randomly select an aphorism from s:strategies.
function! obliqueStrategies#Get()
    return s:generator.Next()
endfunction

" Get the entire list of aphorisms.
function! obliqueStrategies#GetAll()
    return s:generator.lines
endfunction

" Builds a random aphorism generator.
function! s:RandomSelector() abort "{{{
    if !has('lambda')
        throw 'Error: lambda must be supported.'
    endif

    " Build single list from sub-lists
    let l:lines = []

    for l in values(s:strategies)
        call extend(l:lines, l)
    endfor

    let l:generator = {'i': 0, 'count': len(l:lines), 'lines': l:lines}

    function l:generator.RandomSeed() dict
        " Use microseconds for random seed
        return str2nr(split(string(reltimefloat(reltime())), '\m\.')[0])
    endfunction

    " Return the current aphorism and select the next
    function l:generator.Next() dict
        let l:result = self.lines[self.state]
        let self.state = (self.state + 65537) % self.count
        let self.i += 1

        if self.i % self.count == 0
            let self.state = (self.RandomSeed() + 48271) % self.count
        endif

        return l:result
    endfunction

    " Randomly select first aphorism
    let l:generator.state = l:generator.RandomSeed() % l:generator.count

    return l:generator
endfunction "}}}


let s:strategies = {
    \ '4th_ed': [
        \ "Abandon desire.",
        \ "Abandon normal instructions.",
        \ "Accept advice.",
        \ "Adding on.",
        \ "Always the first steps.",
        \ "Ask your body.",
        \ "Be dirty.",
        \ "Be extravagant.",
        \ "Be less critical.",
        \ "Breathe more deeply.",
        \ "Bridges\r - build\r - burn.",
        \ "Change ambiguities to specifics.",
        \ "Change nothing and continue consistently.",
        \ "Change specifics to ambiguities.",
        \ "Consider transitions.",
        \ "Discard an axiom.",
        \ "Discover your formulas and abandon them.",
        \ "Display your talent.",
        \ "Do nothing for as long as possible.",
        \ "Do something boring.",
        \ "Do something sudden, destructive and unpredictable.",
        \ "Do the last thing first.",
        \ "Do the words need changing?",
        \ "Don't avoid what is easy.",
        \ "Don't stress one thing more than another.",
        \ "Emphasize differences.",
        \ "Emphasize the flaws.",
        \ "Faced with a choice, do both.",
        \ "Find a safe part and use it as an anchor.",
        \ "Give the game away",
        \ "Go outside. Shut the door.",
        \ "Go to an extreme, come part way back.",
        \ "How would someone else do it?",
        \ "How would you have done it?",
        \ "Is it finished?",
        \ "Is something missing?",
        \ "Is the style right?",
        \ "It is simply a matter of work.",
        \ "Just carry on.",
        \ "Listen to the quiet voice.",
        \ "Look at the order in which you do things.",
        \ "Magnify the most difficult details.",
        \ "Make what's perfect more human.",
        \ "Move towards the unimportant.",
        \ "Not building a wall; making a brick",
        \ "Once the search has begun, something will be found",
        \ "Only a part, not the whole",
        \ "Only one element of each kind",
        \ "Openly resist change",
        \ "Remove a restriction",
        \ "Repetition is a form of change",
        \ "Retrace your steps",
        \ "Slow preparation, fast execution",
        \ "State the problem as clearly as possible",
        \ "Take a break",
        \ "Take away the important parts",
        \ "The most easily forgotten thing is the most important",
        \ "Think\r - inside the work \r - outside the work",
        \ "Tidy up",
        \ "Turn it upside down",
        \ "Use an old idea",
        \ "Use disciplined self-indulgence.",
        \ "Use something nearby as a model",
        \ "Use your own ideas",
        \ "Voice your suspicions",
        \ "What context would look right?",
        \ "What is the simplest solution?",
        \ "What mistakes did you make last time?",
        \ "What to increase? What to reduce? What to maintain?",
        \ "What were you really thinking about just now?",
        \ "What would your closest friend do?",
        \ "What wouldn't you do?",
        \ "When is it for? Who is it for?",
        \ "Where is the edge?",
        \ "Which parts can be grouped?",
        \ "Work at a different speed",
        \ "Would anyone want it?",
        \ "Your mistake was a hidden intention",
    \ ],
    \ 'diary': [
        \ "Back up a few steps. What else could you have done?",
        \ "List the qualities it has. List those you'd like.",
        \ "Steal a solution.",
        \ "Take away as much mystery as possible. What is left?",
        \ "Try faking it",
        \ "What most recently impressed you? What can you learn from it? What could you take from it?",
    \ ],
    \ 'klawler': [
        \ "A blink lasts 300 milliseconds.",
        \ "Add constraints.",
        \ "Change your mind.",
        \ "Don't worry about mistakes, you can clean it up later.",
        \ "Forget about optimizing your code. Leave a TODO and fix it later.",
        \ "Get red and green right before mixing yellow.",
        \ "Get water flowing through the pipe. Use dummy sections where necessary.",
        \ "If an avenue appears exhausted, your assumptions may be wrong.",
        \ "Look for a good enough approximation.",
        \ "Look for a hack. Cut corners.",
        \ "Relax the problem wherever possible.",
        \ "Solve the problem directly.",
        \ "Start with the most interesting part, and branch from there.",
        \ "Stop and think it through.",
        \ "Take a closer look.",
        \ "Take a guess.",
        \ "Truth will sooner come out of error than from confusion.",
        \ "Try the naive solution first.",
        \ "Use a novel combination of high-level strategies.",
        \ "Verify your assumptions.",
        \ "Verify your fears.",
    \ ],
    \ 'rblackwell': [
        \ "Are you fooling yourself?",
        \ "Are you looking in the right place?",
        \ "Are you solving the right problem?",
        \ "Are you using the right tools for the job?",
        \ "Can you automate this?",
        \ "Change one thing at a time. Try to predict what will happen.",
        \ "Consult the literature.",
        \ "Deleted code is debugged code.",
        \ "Do it manually.",
        \ "Do your names and abstractions correspond with the real world? Is your code model driven?",
        \ "Don't reinvent the wheel. If there's a library, use it.",
        \ "Go outside and get some fresh air.",
        \ "How did they do it without computers?",
        \ "Is it broken by design?",
        \ "Is there a standard approach?",
        \ "Is there a test or simulation that you could run?",
        \ "Is this a symptom or a cause?",
        \ "Is this really necessary?",
        \ "KISS: Keep It Short and Simple. Keep It Simple Stupid!",
        \ "Read a book on the subject.",
        \ "Read the documentation thoroughly.",
        \ "Start from scratch.",
        \ "Stop guessing and look at the facts.",
        \ "Take a break.",
        \ "The simplest explanation is most likely the correct one.",
        \ "What's the simplest thing that could possibly work?",
        \ "Write more unit tests.",
    \ ],
    \ 'misc': [
        \ "Avoid repetition at all costs.",
        \ "Break it down into smaller parts.",
        \ "Commit early and often.",
        \ "Commit to the next idea that occurs to you.",
        \ "Cut your losses.",
        \ "Do one thing well, not many things poorly.",
        \ "Do something unnecessary.",
        \ "Don't hesitate to start again if necessary. It will probably save you time.",
        \ "Enjoy the absence of a clear solution.",
        \ "Follow the path of least resistance.",
        \ "Good programmers know what to write. Great ones know what to rewrite and reuse.",
        \ "If in doubt, improvise.",
        \ "Perfect is the enemy of good.",
        \ "Perfection in design is achieved when there is nothing more to take away.",
        \ "Quality thought is a result of quality time.",
        \ "Resurrect a dead idea",
        \ "Second guess your doubts,",
        \ "Trim the fat.",
        \ "What do you do best?",
        \ "What is least important?",
        \ "What is true of one part may not be true of the whole.",
        \ "What is true of the whole may not be true of one part.",
    \ ],
\ }

let s:generator = s:RandomSelector()

" vim: set ts=4 sw=4 tw=79 fdm=marker fenc=utf-8 et :
