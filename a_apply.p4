BOOL_T lstart;

if (hdr.genhdr_uid1.isValid()){
	hdr.genhdr_uid2.setValid();
	#define OUTPUT_HEADER_SIZE 41
	BOOL_T l;
	BOOL_T l1;
	BOOL_T l2;
	
	bit<64> start_game;
	bit<64> jog1;
	bit<64> jog2;

	start_game = 0x302030203020300A;
	jog1 = 0x312031203220320A;
	jog2 = 0x312033203220320A;
	
	bit<96> msg_tmp;
	msg_tmp = 0x48656c6c6f20576f726c6421;
	bit<376> jog_inv;
	jog_inv = 0x6A6F6761646120696E76616C696461202020202020202020202020202020202020202020202020200A;
	
	bit<376> not_your_turn;
	not_your_turn = 0x6E6F7420796F7572207475726E0A;

	//l = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == msg_tmp);
	lstart = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == start_game);

	l1 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog1);
	l2 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog2);
	//l3 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog3);
	//l4 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog4);
	//l5 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog5);
	bit<1> a = 0;
	bit<1> b = 1;
	bit<1> teste;
	checkers_turn.read(teste, 0);
	BOOL_T turn = (BOOL_T)(bit<1>) teste ;
	//Vez das Brancas
	if(turn == 0 ){
		//Verificar se o mapa já foi iniciado
		bit<1> teste_jogo_iniciado;
		jogo_iniciado.read(teste_jogo_iniciado, 0);
		//Se o mapa não tiver sido iniciado 
		if(teste_jogo_iniciado == 0){
			// Se a entrada for 0 0 0 0
			if(lstart == 1){
				//mapa de inicio
				bit<376> mapa_t;
				mapa_t = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D302D302D300A312D312D312D0A0A;
				map.write(0, mapa_t);
				jogo_iniciado.write(0, 1);
				hdr.genhdr_uid2.msg_out = mapa_t;
				meta.postprocessing = SENDBACK;
			}
			else{
				//Aviso de precisar começar o jogo
				bit<376> aviso = 0x796F75206D7573742074797065203020302030203020746F2073746172740A;
				hdr.genhdr_uid2.msg_out = aviso;
				meta.postprocessing = SENDBACK;
			}
		}
		else{
			if (l1==1){
				hdr.genhdr_uid2.msg_out = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D312D302D300A302D312D312D0A0A;
				teste = (bit<1>) 1;
				checkers_turn.write(0, teste);
			}
			else{
				if(l2==1){
					hdr.genhdr_uid2.msg_out = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D312D302D300A312D302D312D0A0A;
					teste = (bit<1>) 1;
					checkers_turn.write(0, teste);
				}
				else{
					hdr.genhdr_uid2.msg_out = jog_inv;
					meta.postprocessing = SENDBACK;
				}
				
			}
		}
	}
	else{
		hdr.genhdr_uid2.msg_out = not_your_turn;
		meta.postprocessing = SENDBACK;
	}
	
/*	else{
		bit<96> add_excl;
		add_excl = 0x202020202020202020202021;
		bit<328> teste;
		teste = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D302D302D300A312D312D312D;
		//hdr.genhdr_uid  2.msg_out = (add_excl + hdr.genhdr_uid1.msg_in) ++ teste ;
		hdr.genhdr_uid2.msg_out =  teste ;
	}*/
	hdr.genhdr_uid1.setInvalid();
	meta.size_growth = 39;
	meta.size_loss = 0;
	#undef OUTPUT_HEADER_SIZE
}
else{
	if (hdr.genhdr_uid3.isValid()){
		hdr.genhdr_uid2.setValid();
		#define OUTPUT_HEADER_SIZE 41
		BOOL_T l;
		BOOL_T l1;
		BOOL_T l2;
		
		bit<64> start_game;
		bit<64> jog1;
		bit<64> jog2;
		
		start_game = 0x302030203020300A;
		jog1 = 0x312031203220320A;
		jog2 = 0x312033203220320A;
		
		
		bit<96> msg_tmp;
		msg_tmp = 0x48656c6c6f20576f726c6421;
		bit<376> jog_inv;
		jog_inv = 0x6A6F6761646120696E76616C696461202020202020202020202020202020202020202020202020200A;
		
		bit<376> not_your_turn;
		not_your_turn = 0x6E6F7420796F7572207475726E0A;
	
		//l = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == msg_tmp);
		lstart = (BOOL_T)(bit<1>)(hdr.genhdr_uid3.msg_in == start_game);
		l1 = (BOOL_T)(bit<1>)(hdr.genhdr_uid3.msg_in == jog1);
		l2 = (BOOL_T)(bit<1>)(hdr.genhdr_uid3.msg_in == jog2);
		//l3 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog3);
		//l4 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog4);
		//l5 = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == jog5);
		bit<1> a = 0;
		bit<1> b = 1;
		bit<1> teste;
		checkers_turn.read(teste, 0);
		BOOL_T turn = (BOOL_T)(bit<1>) teste ;
		//Vez das Pretas 
		if(turn == 1 ){
			//Se entrada for 0 0 0 0 mostra o mapa
			if (lstart ==1){
				map.read(hdr.genhdr_uid2.msg_out, 0);
				meta.postprocessing = SENDBACK;

			}else{
				if (l1==1){
					hdr.genhdr_uid2.msg_out = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D312D302D300A302D312D312D0A0A;
					teste = (bit<1>) 0;
					checkers_turn.write(0, teste);
				}
				else{
					if(l2==1){
						hdr.genhdr_uid2.msg_out = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D312D302D300A312D302D312D0A0A;
						teste = (bit<1>) 0;
						checkers_turn.write(0, teste);
					}
					else{
						hdr.genhdr_uid2.msg_out = jog_inv;
						meta.postprocessing = SENDBACK;
					}
				}
			}
		}
		else{
			hdr.genhdr_uid2.msg_out = not_your_turn;
			meta.postprocessing = SENDBACK;
		}
		
	/*	else{
			bit<96> add_excl;
			add_excl = 0x202020202020202020202021;
			bit<328> teste;
			teste = 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D302D302D300A312D312D312D;
			//hdr.genhdr_uid  2.msg_out = (add_excl + hdr.genhdr_uid1.msg_in) ++ teste ;
			hdr.genhdr_uid2.msg_out =  teste ;
		}*/
		hdr.genhdr_uid3.setInvalid();
		meta.size_growth = 39;
		meta.size_loss = 0;
		#undef OUTPUT_HEADER_SIZE
	}
}





//TESTE

//Verificar se é a sua vez


//Se for a vez de 1
/*if(checker_turn[0] == 0){
	if (checkersyntax_valid()){
		checker_turn[0] = 1;
	}
	else{
		send_error_msg(1);
	}
}
//Se for a vez de 2
else{
	if (checkersyntax_valid()){
		checker_turn[0] = 0;
	}
	else{
		send_error_msg(2);
	}
}*/


/* Verificador de posição

int verify(int linha, int coluna){

	int pos = linha * 8 + coluna;
	bit<8> map_pos = map[pos:pos+7];
	if (map_pos == 0x31){
		return 1;
	}
	else if (map_pos == 0x32){
		return 2;
	}
	else{
		return 0;
	}

}
*/