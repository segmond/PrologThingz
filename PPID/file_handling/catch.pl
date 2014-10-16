test_catch1:-
    catch(bad_stuff,_,fail).

test_catch2:-
    catch(good_stuff,_,fail).

recover:-
    writeln('Recovering after catch').

% not working
test_catch3:-
    catch(bad_stuff,fail,recover).

good_stuff.
bad_stuff:- fail.
