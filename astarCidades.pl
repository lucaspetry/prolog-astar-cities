%Grafo:
cidade('Florianópolis').
cidade('Palhoça').
cidade('Itajaí').
cidade('Bom Retiro').
cidade('Laguna').
cidade('Araranguá').
cidade('Lages').
cidade('Ponte Alta').
cidade('Campos Novos').
cidade('Navegantes').
cidade('Blumenau').
cidade('Joinville').
cidade('Mafra').
cidade('Porto União').
cidade('Canoinhas').
cidade('Monte Castelo').
cidade('Herval d’Oeste').
cidade('Capinzal').
cidade('Chapecó').
cidade('Xanxerê').
cidade('São Lourenço').
cidade('Campo Erê').
cidade('Dionísio Cerqueira').
cidade('Maravilha').
cidade('São Miguel do Oeste').
cidade('Itapiranga').
cidade('Iraí').

aresta('Florianópolis', 'Palhoça', 20).
aresta('Florianópolis', 'Itajaí', 70).
aresta('Palhoça', 'Itajaí', 80).
aresta('Palhoça', 'Bom Retiro', 100).
aresta('Palhoça', 'Laguna', 100).
aresta('Laguna', 'Araranguá', 70).
aresta('Laguna', 'Bom Retiro', 120).
aresta('Araranguá', 'Bom Retiro', 190).
aresta('Araranguá', 'Lages', 220).
aresta('Lages', 'Bom Retiro', 50).
aresta('Lages', 'Ponte Alta', 40).
aresta('Lages', 'Campos Novos', 60).
aresta('Itajaí', 'Bom Retiro', 140).
aresta('Itajaí', 'Navegantes', 10).
aresta('Navegantes', 'Blumenau', 50).
aresta('Navegantes', 'Joinville', 70).
aresta('Joinville', 'Mafra', 80).
aresta('Mafra', 'Porto União', 130).
aresta('Mafra', 'Canoinhas', 70).
aresta('Mafra', 'Monte Castelo', 85).
aresta('Monte Castelo', 'Canoinhas', 80).
aresta('Canoinhas', 'Porto União', 80).
aresta('Monte Castelo', 'Ponte Alta', 90).
aresta('Monte Castelo', 'Blumenau', 85).
aresta('Ponte Alta', 'Blumenau', 110).
aresta('Ponte Alta', 'Campos Novos', 30).
aresta('Campos Novos', 'Herval d’Oeste', 30).
aresta('Campos Novos', 'Capinzal', 45).
aresta('Capinzal', 'Herval d’Oeste', 15).
aresta('Capinzal', 'Chapecó', 110).
aresta('Herval d’Oeste', 'Porto União', 135).
aresta('Herval d’Oeste', 'Xanxerê', 80).
aresta('Porto União', 'São Lourenço', 140).
aresta('Xanxerê', 'São Lourenço', 80).
aresta('São Lourenço', 'Campo Erê', 25).
aresta('Campo Erê', 'Dionísio Cerqueira', 27).
aresta('Campo Erê', 'Maravilha', 25).
aresta('Dionísio Cerqueira', 'São Miguel do Oeste', 40).
aresta('São Miguel do Oeste', 'Maravilha', 15).
aresta('São Miguel do Oeste', 'Itapiranga', 35).
aresta('Itapiranga', 'Iraí', 17).
aresta('Iraí', 'Maravilha', 8).
aresta('Iraí', 'Chapecó', 65).
aresta('Chapecó', 'Xanxerê', 40).
aresta('Chapecó', 'Maravilha', 70).

conectado(X, Y, V) :- aresta(X, Y, V).
conectado(X, Y, V) :- aresta(Y, X, V).

%Heurística:
coordenadas('Araranguá', -28.9354535, -49.485649).
coordenadas('Blumenau', -26.9136, -49.0688).
coordenadas('Bom Retiro', -27.798993, -49.486994).
coordenadas('Campo Erê', -26.393056, -53.085614).
coordenadas('Campos Novos', -27.3908, -51.2161).
coordenadas('Canoinhas', -26.176591, -50.395001).
coordenadas('Capinzal', -27.3436968, -51.611081).
coordenadas('Chapecó', -27.100448, -52.61519).
coordenadas('Dionísio Cerqueira', -26.2604681, -53.634638).
coordenadas('Florianópolis', -27.5958016, -48.542915).
coordenadas('Herval d’Oeste', -27.1751826, -51.496401).
coordenadas('Iraí', -27.1950701, -53.254328).
coordenadas('Itajaí', -26.9113112, -48.670852).
coordenadas('Itapiranga', -27.165856, -53.716603).
coordenadas('Joinville', -26.3018, -48.8415).
coordenadas('Lages', -27.8109906, -50.318241).
coordenadas('Laguna', -28.483118, -48.781199).
coordenadas('Mafra', -26.12092, -49.7897).
coordenadas('Maravilha', -26.766529, -53.173699).
coordenadas('Monte Castelo', -26.460989, -50.232724).
coordenadas('Navegantes', -26.8915778, -48.648487).
coordenadas('Palhoça', -27.645518, -48.669661).
coordenadas('Ponte Alta', -27.483497, -50.376404).
coordenadas('Porto União', -26.245075, -51.075858).
coordenadas('São Lourenço', -26.35566, -52.849837).
coordenadas('São Miguel do Oeste', -26.7242132, -53.516339).
coordenadas('Xanxerê', -26.874694, -52.403579).

%Fila de prioridade:
newPrioQ([ ]).
isEmptyPrioQ([ ]).


insert(E, [ ], [E]).
insert(E, [H|T], [E,H|T]) :- value(E,VE), value(H,VH), VE =< VH.
insert(E, [H|Q], [H|Q2]) :- insert(E, Q, Q2).

delete(E, [E|Q], Q).

peekPrioQ(E,[E|_]).

%A*:
astar(CidadeInicial, CidadeDestino) :- calcularHeuristica(CidadeInicial, H), astar([vertice(CidadeInicial, 0, H, nil)], [CidadeInicial], VerticeFinal, CidadeDestino), !, imprimirCaminho(VerticeFinal), imprimirDistancia(VerticeFinal).

astar(Fila, _, vertice('Não há caminho', nil, nil, nil), _) :- isEmptyPrioQ(Fila).
astar(Fila, _, Vertice, CidadeDestino) :- peekPrioQ(Vertice, Fila), eCidadeDestino(Vertice, CidadeDestino).
astar(Fila, Explorados, VerticeFinal, CidadeDestino) :- delete(Vertice, Fila, Fila2), expandir(Vertice, Explorados, NovosExplorados, Fila2, NovaFila), astar(NovaFila, NovosExplorados, VerticeFinal, CidadeDestino).

eCidadeDestino(vertice(CidadeDestino, _, _, _), CidadeDestino).

expandir(Vertice, Explorados, NovosExplorados, Fila, NovaFila) :- findall(N, pai(Vertice, N), NovosVertices), adicionaNovosVertices(NovosVertices, Explorados, NovosExplorados, Fila, NovaFila).

pai(vertice(Cidade1, G1, F1, Avo), vertice(Cidade2, G2, F2, vertice(Cidade1, G1, F1, Avo))) :- conectado(Cidade1, Cidade2, V), calcularHeuristica(Cidade2, H), G2 is G1 + V, F2 is G2 + H.

adicionaNovosVertices([], Explorados, Explorados, Fila, Fila).
adicionaNovosVertices([Vertice|Vertices], Explorados, NovosExplorados, Fila, NovaFila) :- cidadeJaExplorada(Vertice, Explorados), adicionaNovosVertices(Vertices, Explorados, NovosExplorados, Fila, NovaFila).
adicionaNovosVertices([Vertice|Vertices], Explorados, NovosExplorados, Fila, NovaFila) :- adicionaCidadeAsExploradas(Vertice, Explorados, Explorados2), insert(Vertice, Fila, Fila2), adicionaNovosVertices(Vertices, Explorados2, NovosExplorados, Fila2, NovaFila).

cidadeJaExplorada(vertice(Cidade, _, _, _), Explorados) :- member(Cidade, Explorados).

adicionaCidadeAsExploradas(vertice(Cidade, _, _, _), Explorados, [Cidade|Explorados]).

imprimirCaminho(nil).
imprimirCaminho(vertice(Cidade, _, _, Pai)) :- imprimirCaminho(Pai), write(' --> '), write(Cidade), caminhoTotal(C), atom_concat(' --> ', Cidade, X1), atom_concat(C, X1, NovoCaminho), retractall(caminhoTotal(_)), assertz(caminhoTotal(NovoCaminho)).
imprimirDistancia(nil).
imprimirDistancia(vertice(_, G, _, _)) :- write('\nDistância total: '), write(G), write('km'), assertz(distanciaFinal(G)).

:- dynamic caminhoTotal/1.
caminhoTotal('').

calcularHeuristica(Cidade, H) :- destino(Destino), coordenadas(Destino, XD, YD), coordenadas(Cidade, XC, YC), hipotenusa(XD, YD, XC, YC, Hip), H is Hip.

hipotenusa(Xa, Ya, Xb, Yb, Hip) :- A is Xa - Xb, A2 is A * A, B is Ya - Yb, B2 is B * B, Hip is sqrt(A2 + B2).

value(vertice(_, _, F, _), F).

%Calcular caminho
acharCaminho(Origem, Destino, Caminho, Distancia) :- cidade(Origem), cidade(Destino), retractall(destino(_)), retractall(distanciaFinal(_)), retractall(caminhoTotal(_)), assertz(caminhoTotal('')), assertz(destino(Destino)), astar(Origem, Destino), caminhoTotal(Caminho), distanciaFinal(Distancia).

