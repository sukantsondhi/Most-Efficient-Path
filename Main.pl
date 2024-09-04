% Ground Layout and Cost

room(outside, porch1).
room(porch1, kitchen).
room(kitchen, livingRoom).
room(corridor, bedroom).
room(corridor, wc).
room(corridor, masterBedroom).
room(corridor, livingRoom).
room(livingRoom, porch2).
room(outside, porch2).

connected(X,Y):-
    room(X,Y) ; room(Y,X).

room(outside, porch1, 1).
room(porch1, kitchen, 1).
room(kitchen, livingRoom, 3).
room(corridor, bedroom, 2).
room(corridor, wc, 2).
room(corridor, masterBedroom, 2).
room(corridor, livingRoom, 1).
room(livingRoom, porch2, 5).
room(outside, porch2, 1).

connected(X,Y,C):-
    room(X,Y,C) ; room(Y,X,C).


% 3.1

find(O,D,List):-
    tSame(O,D), !, fail;
    travel(O,D,[O],List) ->
        printIt(List) ; write('Either the Origin or the Destination does not Exist.').
    

travel(O,D,Pointer,List):-
    connected(O,D),
    List = [D|Pointer].
travel(O,D,Pointer,List):-
    connected(O,X),
    X \== D,
    \+member(X,Pointer),    
    travel(X,D,[X|Pointer],List).

printIt(List):-
    reverse(ProperList,List),
    member(Element,ProperList), 
    (write(Element), write(' -> ')), fail; true,
    write(' Destination_Reached'), nl, nl.


%  Test(s)

tSame(O,D):-
    O==D,
    write('You are already at the Destination.').


% 3.2

% If you uncomment the code below the, you can see som more detail information.

bdSearch(O1,O2,D,_Path):-
    % tSame(O1,D), !, fail;
    % tSame(O2,D), !, fail;
    travel(O1,D,[O1],O1toD) ->
        
        % write('Path from '), write(O1), write(' to '), write(D), write(' is:- '),
        % nl, 
        % printIt(O1toD),
        travel(D,O2,[D],DtoO2) ->    
            % write('Path from '), write(D), write(' to '), write(O2), write(' is:- '),        
            % nl, 
            % printIt(DtoO2),
            deleteLast(DtoO2,DtoO2_Cut),
            nl, write('Path from '), write(O1), write(' to '), write(O2), write(' via '), write(D), write(' is:- '),
            append(DtoO2_Cut,O1toD,Path),        
            nl, printIt(Path).
        

 % Deleting last element 
 
deleteLast([_], []).
deleteLast([Head, Next|Tail], [Head|NTail]):-
  deleteLast([Next|Tail], NTail).


 % 3.3

find(A,B,Path,Len) :-
    tSame(A,B), !, fail;
    travel(A,B,[A],Path,Len).

travel(A,B,P,[B|P],L) :- 
    connected(A,B,L).
travel(A,B,Visited,Path,L) :-
    connected(A,C,D),           
    C \== B,
    \+member(C,Visited),
    travel(C,B,[C|Visited],Path,L1),
    L is D+L1.  

shortest(A,B,Path,Length) :-
   setof([P,L],find(A,B,P,L),Set),
   Set = [_|_],
   minimal(Set,[Path,Length]).

minimal([F|R],M) :- min(R,F,M).

min([],M,M).
min([[P,L]|R],[_,M],Min) :- L < M, !, min(R,[P,L],Min). 
min([_|R],M,Min) :- min(R,M,Min).
                                                                                                                      
bdSearchShortest(O1,O2,D,Path,Length):-
    shortest(O1,D,O1toD,O1toD_L),
    % printIt(O1toD),
    shortest(D,O2,DtoO2,DtoO2_L),
    % printIt(DtoO2),
    deleteLast(DtoO2,DtoO2_Cut),
    Length is O1toD_L + DtoO2_L,
    append(DtoO2_Cut,O1toD,Path),
    printIt(Path).

