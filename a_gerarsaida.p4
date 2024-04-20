action gerarsaida(inout bit<640> saida){
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
	
	
	saida = item0 ++ item1 ++ item2 ++ item3 ++ item4 ++ item5 ++ item6 ++ item7 ++ (bit<16>)0x0D0A ++ 	
			item8 ++ item9 ++ item10 ++ item11 ++ item12 ++ item13 ++ item14 ++ item15 ++ (bit<16>)0x0D0A ++ 
			item16 ++ item17 ++ item18 ++ item19 ++ item20 ++ item21 ++ item22 ++ item23 ++ (bit<16>)0x0D0A ++ 
			item24 ++ item25 ++ item26 ++ item27 ++ item28 ++ item29 ++ item30 ++ item31 ++ (bit<16>)0x0D0A ++ 	
			item32 ++ item33 ++ item34 ++ item35 ++ item36 ++ item37 ++ item38 ++ item39 ++ (bit<16>)0x0D0A ++ 	
			item40 ++ item41 ++ item42 ++ item43 ++ item44 ++ item45 ++ item46 ++ item47 ++ (bit<16>)0x0D0A ++ 	
			item48 ++ item49 ++ item50 ++ item51 ++ item52 ++ item53 ++ item54 ++ item55 ++ (bit<16>)0x0D0A ++ 	
			item56 ++ item57 ++ item58 ++ item59 ++ item60 ++ item61 ++ item62 ++ item63 ++ (bit<16>)0x0D0A; 
			
	
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