
Koch { alfabeto     = [F, +, -]
     ; inicio       = [F]
     ; producciones = [ F -> [F,+,F,-,F,-,F,+,F] ]
     }

Algae 
    { alfabeto = [Fa, Fb]
    ; inicio   = [Fa]
    ; producciones = [ Fa -> [Fa, Fb]
                     ; Fb -> [Fa]
                     ]
    }

Fibonacci numbers 
    { alfabeto = [Fa,Fb]
    ; inicio   = [Fa]
    ; producciones = [ Fa -> [Fb]
                     ; Fb -> [Fa,Fb]
                     ]
    }

Cantor 1 
    { alfabeto = [Fa, Fb]
    ; inicio   = [Fa]
    ; producciones = [ Fa -> [Fa,Fb,Fa]
                     ; Fb -> [Fb,Fb,Fb]
                     ]
    }

Cantor 2
    { alfabeto = [F,f,]
    ; inicio   = [F]
    ; producciones = [ F -> [F,f,F]
                     ; f -> [f,f,f]
                     ]
    }

C Koch 
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,-,F,+,F,+,F,F,-,F,-,F,+,F] ]
     }

CKochis 
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,+,F,F,-,F,F,-,F,-,F,+,F,+,F,F,-,F,-,F,+,F,+,F,F,+,F,F,-,F] ]
     }

C Kochil 
     { alfabeto     = [F, f,+, -]
     ; inicio       = [F,+,F,+,F,+,F]
     ; producciones = [ F -> [F,+,f,-,F,F,+,F,+,F,F,+,F,f,+,F,F,-,f,+,F,F,-,F,-,F,F,-,F,f,-,F,F,F]
                      ; f -> [f,f,f,f,f,f]]
     }

Koch A 
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,F,-,F,-,F,-,F,-,F,-,F,+,F] ]
     }

Koch B
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,F,-,F,-,F,-,F,-,F,F] ]
     }

Koch C
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,F,-,F,+,F,-,F,-,F,F] ]
     }

Koch D
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,F,-,F,-,-,F,-,F] ]
     }

Koch E 
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,-,F,F,-,-,F,-,F] ]
     }

Koch F
     { alfabeto     = [F, +, -]
     ; inicio       = [F,-,F,-,F,-,F]
     ; producciones = [ F -> [F,-,F,+,F,-,F,-,F] ]
     }

Dragon Curve
    { alfabeto = [Fl,Fr,+,-, red, blue]
    ; inicio   = [Fl]
    ; producciones = [ Fl -> [red, Fl,+,Fr,+]
                     ; Fr -> [blue,-,Fl,-,Fr]
                     ]
    }

Sierpinski gasket
    { alfabeto = [Fl,Fr,+,-]
    ; inicio   = [Fr]
    ; producciones = [ Fl -> [Fr,+,Fl,+,Fr]
                     ; Fr -> [Fl,-,Fr,-,Fl]
                     ]
    }

Hexagonal Gosper curve
    { alfabeto = [Fl,Fr,+,-]
    ; inicio = [Fl]
    ; producciones = [ Fl -> [Fl, +,Fr, +,+,Fr, -,Fl, -,-,Fl, Fl, -,Fr, +]
                     ; Fr -> [-,Fl, +,Fr, Fr, +,+,Fr, +,Fl, -,-,Fl, -,Fr]
                     ]
    }

Quadratic Gosper Curve
    { alfabeto = [Fr,Fl,+,-]
    ; inicio   = [-,Fr]
    ; producciones = [ Fl -> [ Fl, Fl, -,Fr, -,Fr, +,Fl, +,Fl, -,Fr, -,Fr, Fl, +,Fr, +,Fl, Fl, Fr, -,Fl, +,Fr, +,Fl, Fl, +,Fr, -,Fl, Fr, -,Fr, -,Fl, +,Fl, +,Fr, Fr, -]
                     ; Fr -> [+,Fl, Fl, -,Fr, -,Fr, +,Fl, +,Fl, Fr, +,Fl, -,Fr, Fr, -,Fl, -,Fr, +,Fl, Fr, Fr, -,Fl, -,Fr, Fl, +,Fl, +,Fr, -,Fr, -,Fl, +,Fl, +,Fr, Fr]
                     ]
    }

3 x 3 Macrotile 
    { alfabeto = [L,R,F,+,-]
    ; inicio   = [L]
    ; producciones = [ L -> [L,F,R,F,L,-,F,-,R,F,L,F,R,+,F,+,L,F,R,F,L]
                     ; R -> [R,F,L,F,R,+,F,+,L,F,R,F,L,-,F,-,R,F,L,F,R]
                     ]
    }

5 x 5 Macrotile
    { alfabeto = [L,R,F,+,-]
    ; inicio = [L]
    ; producciones = [ L -> [L,+,F,+,R,-,F,-,L,+,F,+,R,-,F,-,L,-,F,-,R,+,F,+,L,-,F,-,R,-,F,-,L,+,F,+,R,-,F,-,L,-,F,-,R,-,F,
                             -,L,+,F,+,R,+,F,+,L,+,F,+,R,-,F,-,L,+,F,+,R,+,F,+,L,-,R,-,F,+,F,+,L,+,F,+,R,-,F,-,L,+,F,+,R,-,F,-,L]
                     ; R -> [R,-,F,-,L,+,F,+,R,-,F,-,L,+,F,+,R,+,F,+,L,-,F,-,R,+,F,+,L,+,F,+,R,-,F,-,L,+,F,+,R,+,F,+,L,+,F,+,
                             R,-,F,-,L,-,F,-,R,-,F,-,L,+,F,+,R,-,F,-,L,-,F,-,R,+,F,+,L,-,F,-,R,-,F,-,L,+,F,+,R,-,F,-,L,+,F,+,R]
                     ]

    }

