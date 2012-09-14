SRC = ./src/

all: uuagc
	ghc -i$(SRC) --make -o lsystem $(SRC)Main.hs -outputdir out
    
uuagc:
	uuagc -P$(SRC) --data --module --semfuns --catas --signature $(SRC)SistemaL.ag
