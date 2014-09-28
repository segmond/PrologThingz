fileviewer(Dir):-
    new(DirObj, directory(Dir)),
    new(F, frame('File Viewer')),
    send(F, append(new(B, browser))),
    send(new(D, dialog), below(B)),
    send(D, append(button(view, message(@prolog, view, DirObj, B?selection?key)))),
    send(D, append(button(quit, message(F, destroy)))),
    send(B, members(DirObj?files)),
    send(F, open).

view(DirObj, F):-
    send(new(V, view(F)), open),
    get(DirObj, file(F), FileObj),
    send(V, load(FileObj)).
        
