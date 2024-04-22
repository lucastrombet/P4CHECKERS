action gerarsaida(inout bit<672> saida){
	bit<8> item0; bit<8> item1;	bit<8> item2; bit<8> item3; bit<8> item4; bit<8> item5; bit<8> item6; bit<8> item7; bit<8> item8; bit<8> item9;
	bit<8> item10; bit<8> item11; bit<8> item12; bit<8> item13; bit<8> item14; bit<8> item15; bit<8> item16; bit<8> item17; bit<8> item18; bit<8> item19;
	bit<8> item20; bit<8> item21; bit<8> item22; bit<8> item23; bit<8> item24; bit<8> item25; bit<8> item26; bit<8> item27; bit<8> item28; bit<8> item29;
	bit<8> item30; bit<8> item31; bit<8> item32; bit<8> item33; bit<8> item34; bit<8> item35; bit<8> item36; bit<8> item37; bit<8> item38; bit<8> item39;
	bit<8> item40; bit<8> item41; bit<8> item42; bit<8> item43; bit<8> item44; bit<8> item45; bit<8> item46; bit<8> item47; bit<8> item48; bit<8> item49;
	bit<8> item50; bit<8> item51; bit<8> item52; bit<8> item53; bit<8> item54; bit<8> item55; bit<8> item56; bit<8> item57; bit<8> item58; bit<8> item59;
	bit<8> item60; bit<8> item61; bit<8> item62; bit<8> item63; 

	
	checkerboard.read(item0 ,0);
	checkerboard.read(item1 ,1);
	checkerboard.read(item2 ,2);
	checkerboard.read(item3 ,3);
	checkerboard.read(item4 ,4);
	checkerboard.read(item5 ,5);
	checkerboard.read(item6 ,6);
	checkerboard.read(item7 ,7);
	checkerboard.read(item8 ,8);
	checkerboard.read(item9 ,9);
	
	checkerboard.read(item10 ,10);
	checkerboard.read(item11 ,11);
	checkerboard.read(item12 ,12);
	checkerboard.read(item13 ,13);
	checkerboard.read(item14 ,14);
	checkerboard.read(item15 ,15);
	checkerboard.read(item16 ,16);
	checkerboard.read(item17 ,17);
	checkerboard.read(item18 ,18);
	checkerboard.read(item19 ,19);
	
	checkerboard.read(item20 ,20);
	checkerboard.read(item21 ,21);
	checkerboard.read(item22 ,22);
	checkerboard.read(item23 ,23);
	checkerboard.read(item24 ,24);
	checkerboard.read(item25 ,25);
	checkerboard.read(item26 ,26);
	checkerboard.read(item27 ,27);
	checkerboard.read(item28 ,28);
	checkerboard.read(item29 ,29);
	
	
	checkerboard.read(item30 ,30);
	checkerboard.read(item31 ,31);
	checkerboard.read(item32 ,32);
	checkerboard.read(item33 ,33);
	checkerboard.read(item34 ,34);
	checkerboard.read(item35 ,35);
	checkerboard.read(item36 ,36);
	checkerboard.read(item37 ,37);
	checkerboard.read(item38 ,38);
	checkerboard.read(item39 ,39);
	
	checkerboard.read(item40 ,40);
	checkerboard.read(item41 ,41);
	checkerboard.read(item42 ,42);
	checkerboard.read(item43 ,43);
	checkerboard.read(item44 ,44);
	checkerboard.read(item45 ,45);
	checkerboard.read(item46 ,46);
	checkerboard.read(item47 ,47);
	checkerboard.read(item48 ,48);
	checkerboard.read(item49 ,49);
	
	checkerboard.read(item50 ,50);
	checkerboard.read(item51 ,51);
	checkerboard.read(item52 ,52);
	checkerboard.read(item53 ,53);
	checkerboard.read(item54 ,54);
	checkerboard.read(item55 ,55);
	checkerboard.read(item56 ,56);
	checkerboard.read(item57 ,57);
	checkerboard.read(item58 ,58);
	checkerboard.read(item59 ,59);

	checkerboard.read(item60 ,60);
	checkerboard.read(item61 ,61);
	checkerboard.read(item62 ,62);
	checkerboard.read(item63 ,63);
	
	
	saida = (bit<16>)0x0D0A ++ item0 ++ item1 ++ item2 ++ item3 ++ item4 ++ item5 ++ item6 ++ item7 ++ (bit<16>)0x0D0A ++ 	
			item8 ++ item9 ++ item10 ++ item11 ++ item12 ++ item13 ++ item14 ++ item15 ++ (bit<16>)0x0D0A ++ 
			item16 ++ item17 ++ item18 ++ item19 ++ item20 ++ item21 ++ item22 ++ item23 ++ (bit<16>)0x0D0A ++ 
			item24 ++ item25 ++ item26 ++ item27 ++ item28 ++ item29 ++ item30 ++ item31 ++ (bit<16>)0x0D0A ++ 	
			item32 ++ item33 ++ item34 ++ item35 ++ item36 ++ item37 ++ item38 ++ item39 ++ (bit<16>)0x0D0A ++ 	
			item40 ++ item41 ++ item42 ++ item43 ++ item44 ++ item45 ++ item46 ++ item47 ++ (bit<16>)0x0D0A ++ 	
			item48 ++ item49 ++ item50 ++ item51 ++ item52 ++ item53 ++ item54 ++ item55 ++ (bit<16>)0x0D0A ++ 	
			item56 ++ item57 ++ item58 ++ item59 ++ item60 ++ item61 ++ item62 ++ item63 ++ (bit<16>)0x0D0A ++ (bit<16>)0x0D0A
			; 
			
	
}


action iniciarmapa(){
	
	bit<8> brancas;
	bit<8> pretas;
	bit<8> livre;
	bit<8> espaco;
	brancas = 0x31;
	pretas = 0x32;
	livre = 0x30;
	espaco = 0x2d;
	//desenhar mapa 
	//Primeira linha
	checkerboard.write(0, brancas);
	checkerboard.write(1, espaco);
	checkerboard.write(2, brancas);
	checkerboard.write(3, espaco);
	checkerboard.write(4, brancas);
	checkerboard.write(5, espaco);
	checkerboard.write(6, brancas);
	checkerboard.write(7, espaco);
	//Segunda linha
	checkerboard.write(8, espaco);
	checkerboard.write(9, brancas);
	checkerboard.write(10, espaco);
	checkerboard.write(11, brancas);
	checkerboard.write(12, espaco);
	checkerboard.write(13, brancas);
	checkerboard.write(14, espaco);
	checkerboard.write(15, brancas);
	//Terceira linha
	checkerboard.write(16, brancas);
	checkerboard.write(17, espaco);
	checkerboard.write(18, brancas);
	checkerboard.write(19, espaco);
	checkerboard.write(20, brancas);
	checkerboard.write(21, espaco);
	checkerboard.write(22, brancas);
	checkerboard.write(23, espaco);
	//Quarta linha
	checkerboard.write(24, espaco);
	checkerboard.write(25, livre);
	checkerboard.write(26, espaco);
	checkerboard.write(27, livre);
	checkerboard.write(28, espaco);
	checkerboard.write(29, livre);
	checkerboard.write(30, espaco);
	checkerboard.write(31, livre);
	//Quinta linha
	checkerboard.write(32, livre);
	checkerboard.write(33, espaco);
	checkerboard.write(34, livre);
	checkerboard.write(35, espaco);
	checkerboard.write(36, livre);
	checkerboard.write(37, espaco);
	checkerboard.write(38, livre);
	checkerboard.write(39, espaco);
	//Sexta linha
	checkerboard.write(40, espaco);
	checkerboard.write(41, pretas);
	checkerboard.write(42, espaco);
	checkerboard.write(43, pretas);
	checkerboard.write(44, espaco);
	checkerboard.write(45, pretas);
	checkerboard.write(46, espaco);
	checkerboard.write(47, pretas);
	//Sétima linha
	checkerboard.write(48, pretas);
	checkerboard.write(49, espaco);
	checkerboard.write(50, pretas);
	checkerboard.write(51, espaco);
	checkerboard.write(52, pretas);
	checkerboard.write(53, espaco);
	checkerboard.write(54, pretas);
	checkerboard.write(55, espaco);
	//Oitava linha
	checkerboard.write(56, espaco);
	checkerboard.write(57, pretas);
	checkerboard.write(58, espaco);
	checkerboard.write(59, pretas);
	checkerboard.write(60, espaco);
	checkerboard.write(61, pretas);
	checkerboard.write(62, espaco);
	checkerboard.write(63, pretas);
	
	
}

action verificarnumero(inout int<8> valida_num, in bit<8> num){
	if(
		(num == 0x38) ||
		(num == 0x31) ||
		(num == 0x32) ||
		(num == 0x33) ||
		(num == 0x34) ||
		(num == 0x35) ||
		(num == 0x36) ||
		(num == 0x37) 
		
		){
		valida_num = 0;
	}else{
		valida_num = 1; 
	}
	
}

action inttobit(inout bit<32> bitout, in int<8> intin){
	
	int<32> inttest = (int<32>) intin;
	bitout = (bit<32>) inttest;
	
}




action bittoint(inout int<8>saida, in bit<8> entrada){
	
	if(entrada == 0x31) {saida = 1;}
	else if(entrada == 0x32) {saida = 2;}
	else if(entrada == 0x33) {saida = 3;}
	else if(entrada == 0x34) {saida = 4;}
	else if(entrada == 0x35) {saida = 5;}
	else if(entrada == 0x36) {saida = 6;}
	else if(entrada == 0x37) {saida = 7;}
	else if(entrada == 0x38) {saida = 8;}
	
}

action verificaorigem(inout BOOL_T verif,in bit<8> rowin, in bit<8> colin){
	
	int<8> rowint;
	int<8> colint;
	bittoint(rowint, rowin);
	bittoint(colint, colin);
	bit<8> ori_teste;
	bit<32> pos;
	int<8> posint;
	
	/*Posicao array*/ 
	posint = (rowint-1)*8 + colint-1;
	inttobit(pos , posint);
	/*LOGS*/
	log_msg("Rowint {}", {rowint});
	log_msg("Colint {}", {colint});
	log_msg("Posint {}", {posint});
	
	/*Busca array*/
	checkerboard.read(ori_teste, pos);
	
	log_msg("Origem {}", {ori_teste});
	
	/*Busca turno*/
	bit<1> teste_verificaturno;
	checkers_turn.read(teste_verificaturno, 0);
	BOOL_T turn = (BOOL_T)(bit<1>) teste_verificaturno ;
	
	//Origem branca
	if(turn == 0){
		verif = (BOOL_T)(bit<1>)(ori_teste == 0x31);
	}
	//Origem preta
	else{
		verif = (BOOL_T)(bit<1>)(ori_teste == 0x32);
	}
		
}

action acharadversario(inout bit<8> adversario, in int<8> posadv){
	bit<32> posadvb;
	//bit<8> adversario;
	inttobit(posadvb , posadv);
	checkerboard.read(adversario, posadvb);
	log_msg("Adversario {}", {adversario});
}




action verificadestino(inout BOOL_T verif, in bit<8> rowout, in bit<8> colout, in bit<8> rowin, in bit<8> colin){
	
	int<8> rowinint;
	int<8> colinint;
	int<8> rowint;
	int<8> colint;
	bit<8> ori_teste;	
	bittoint(rowint, rowout);
	bittoint(colint, colout);
	bittoint(rowinint, rowin);
	bittoint(colinint, colin);
	bit<32> pos;
	int<8> posint;
	posint = (rowint-1)*8 + colint-1;
	log_msg("Rowint {}", {rowint});
	log_msg("Colint {}", {colint});
	log_msg("Posint {}", {posint});
	inttobit(pos , posint);
	log_msg("!!!!!!!!!!!!!Pos {}", {pos});
	checkerboard.read(ori_teste, pos);
	log_msg("Destino {}", {ori_teste});
	verif = (BOOL_T)(bit<1>)(ori_teste == 0x30);
	
	/*Busca turno*/
	bit<1> teste_verificaturno;
	checkers_turn.read(teste_verificaturno, 0);
	BOOL_T turn = (BOOL_T)(bit<1>) teste_verificaturno ;
	
	//Verificar se a casa de destino é valida 2 situacoes
	//Caso 1: Casa adjacente está vazia = 0
	//No turno das brancas - Casa tem que ser para baixo
	BOOL_T andar;
	andar = (BOOL_T)(bit<1>) 0;
	if (turn == 0){
		if( (rowint - rowinint) == 1){ //linha maior que a entrada por uma unidade
			if(((colint - colinint) == 1) || ((colinint - colint) == 1)){
				//Jogada valida
				andar = (BOOL_T)(bit<1>) 1;
			}
		}
	}
	else{
		if( (rowinint - rowint) == 1){ //linha menor que a entrada por uma unidade
			if(((colint - colinint) == 1) || ((colinint - colint) == 1)){
				//Jogada valida
				andar = (BOOL_T)(bit<1>) 1;
			}
		}		
	}
		
	//Caso 2: Comer (casa adjacente está com peça do adversario) e a proxima está vazia
	BOOL_T comer;
	comer = (BOOL_T)(bit<1>) 0;
	
	int<8> posadv;
	bit<8> adversario;
	posadv = 1;
	
	if (turn == 0){
		if( (rowint - rowinint) == 2){ //linha maior que a entrada por uma unidade
			if((colint - colinint) == 2) {
				//Verificar se casa anterior tem um adversario
				posadv = (rowint-2)*8 + colint-2;
			}
			if((colinint - colint) == 2){
				//Verificar se casa anterior tem um adversario
				posadv = (rowint-2)*8 + colint;
			}
		}
	}
	else{
		if( (rowinint - rowint) == 2){ //linha menor que a entrada por uma unidade
			if((colint - colinint) == 2) {
				//Verificar se casa anterior tem um adversario
				posadv = (rowinint-2)*8 + colint-2;
			}
			if((colinint - colint) == 2){
				//Verificar se casa anterior tem um adversario
				posadv = (rowinint-2)*8 + colint;
			}
		}		
	}
	
	
	
	log_msg("!!!!!!!!POSADV {}", {posadv});
	acharadversario(adversario, posadv);
	
	
	if (turn == 0){
		comer = (BOOL_T)(bit<1>)(adversario == 0x32);
	}
	else{
		comer = (BOOL_T)(bit<1>)(adversario == 0x31);
	}
	
	
	
	log_msg("Verif {}", {verif});
	log_msg("Andar {}", {andar});
	log_msg("Comer {}", {comer});
	
	
	//Verif
	verif = verif & ( andar | comer );
	
}





action verificarjogada(inout BOOL_T valida_jogada, in bit<64> msg){
	
	
	log_msg("Entrou verificar jogada");
	bit<8> rowin;
	bit<8> colin;
	bit<8> rowout;
	bit<8> colout;
	
	int<8> valida_rowin;
	int<8> valida_colin;
	int<8> valida_rowout;
	int<8> valida_colout;
	
	rowin = msg[63:56];
	colin = msg[47:40];
	rowout = msg[31:24];
	colout = msg[15:8];
	log_msg("Entrou verificar numeros");
	verificarnumero(valida_rowin, rowin);
	verificarnumero(valida_colin, colin);
	verificarnumero(valida_rowout, rowout);
	verificarnumero(valida_colout, colout);
	
	int<8> vj;
	vj = valida_rowin + valida_colin + valida_rowout + valida_colout;
	valida_jogada = (BOOL_T)(bit<1>)(vj == 0);
	
	BOOL_T verori;
	BOOL_T verdest;
	
	log_msg("Verifica Origem");
	verificaorigem(verori, rowin, colin);
	log_msg("Verifica Destino");
	verificadestino(verdest, rowout, colout, rowin, colin);
	
	BOOL_T verfin;
	
	verfin = verdest & verori;
	log_msg("Verori {}", {verori});
	log_msg("Vesdest {}", {verdest});
	log_msg("Verfin {}", {verfin});
	log_msg("Validajog_antes {}", {valida_jogada});
	
	valida_jogada = valida_jogada & verfin;
	log_msg("Validajog_depois {}", {valida_jogada});

}

action jogar(in bit<64> msg){
	
	log_msg("Entrou jogar");
	bit<8> rowin;
	bit<8> colin;
	bit<8> rowout;
	bit<8> colout;
	
	
	rowin = msg[63:56];
	colin = msg[47:40];
	rowout = msg[31:24];
	colout = msg[15:8];
	
	int<8> rowinint;
	int<8> colinint;
	bittoint(rowinint, rowin);
	bittoint(colinint, colin);
	
	bit<32> pos;
	int<8> posint;
	
	/*Posicao array*/ 
	posint = (rowinint-1)*8 + colinint-1;
	inttobit(pos , posint);
	// Zera a origem
	checkerboard.write(pos, 0x30);
	
	
	int<8> rowoutint;
	int<8> coloutint;
	bittoint(rowoutint, rowout);
	bittoint(coloutint, colout);
	
	posint = (rowoutint-1)*8 + coloutint-1;
	inttobit(pos , posint);
	
	bit<8> peca;
	bit<1> teste_verificaturno;
	checkers_turn.read(teste_verificaturno, 0);
	BOOL_T turn = (BOOL_T)(bit<1>) teste_verificaturno ;
	if (turn == 0){ //BRANCAS
		peca = 0x31;
	}else{
		peca= 0x32;
	}
	
	checkerboard.write(pos, peca);
	
	//Se comer peca
	
	int<8> posadv;
	bit<8> adversario;
	posadv = 1;
	
	if (turn == 0){
		if( (rowoutint - rowinint) == 2){ //linha maior que a entrada por uma unidade
			if((coloutint - colinint) == 2) {
				//Verificar se casa anterior tem um adversario
				posadv = (rowoutint-2)*8 + coloutint-2;
			}
			if((colinint - coloutint) == 2){
				//Verificar se casa anterior tem um adversario
				posadv = (rowoutint-2)*8 + coloutint;
			}
		}
	}
	else{
		if( (rowinint - rowoutint) == 2){ //linha menor que a entrada por uma unidade
			if((coloutint - colinint) == 2) {
				//Verificar se casa anterior tem um adversario
				posadv = (rowinint-2)*8 + coloutint-2;
			}
			if((colinint - coloutint) == 2){
				//Verificar se casa anterior tem um adversario
				posadv = (rowinint-2)*8 + coloutint;
			}
		}		
	}
	
	bit<8> peca2;
	bit<32> posadvb;
	if (posadv ==1){
		peca2 = 0x2d;
	}
	else{
		peca2 = 0x30;
	}
	inttobit(posadvb , posadv);
	checkerboard.write(posadvb, peca2);
	
}

/*verifica_soma(bit<8> row, bit<8> col){
	if (row[0] | col[0]) == 0){
		return 1;
	}
}

int verifica origem(int row, int col){
	bit<8> ori_teste;
	checkerboard.read(ori_teste, (row-1)*8 + col-1);
	//Origem branca
	if(turn == 0){
		if(ori_teste == 0x31){
			return 1;
		}
		else{
			return 0;
		}
	}
	//Origem preta
	else{
		if(ori_teste == 0x32){
			return 1;
		}
		else{
			return 0;
		}
	}
}

int verifica destino(int row, int col){
	bit<8> dest_teste;
	checkerboard.read(ori_teste, (row-1)*8 + col);
	//Verifica se o espaço está vazio
	if (dest_teste == 0x30){
		return 1;
	}
	
}
*/


