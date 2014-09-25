% translating procedural style code to prolog fast
% just an idea, not meant to be executed.
a(X)
{
    b;
    if X=0 {
        c 
    }else {
        d
    }
    e
}


a(X):-
    b,
    cd(X),
    e.

cd(0):- c.
cd(X):- X<>0, d.


foo() {
    username = getUsername();
    id = getUserId(username);
    pass = getPassword();
    if (isValid(id, pass)) {
        login();
    } else {
        deny();
    }
}

foo():-
    getUsername(Name),
    getUserId(Name, Id),
    getPassword(Pass),
    isValid(Id, Pass).

isValid(Id, Pass) -> login() ; deny().
