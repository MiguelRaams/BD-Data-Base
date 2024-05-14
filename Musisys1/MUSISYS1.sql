drop table if exists Participacao ;
drop table if exists Entrevista ;
drop table if exists tecnificam ;
drop table if exists associado ;
drop table if exists pertence ;
drop table if exists Participante ;
drop table if exists Individual ;
drop table if exists Grupo ;
drop table if exists Tema ;
drop table if exists Roadie ;
drop table if exists Tecnico ;
drop table if exists Organizacao ;
drop table if exists Festival ;
drop table if exists Palco ;
drop table if exists Espectador ;
drop table if exists Jornalista ;
drop table if exists Bilhete ;
drop table if exists Pagante ;
drop table if exists Convidado ;
drop table if exists Dia ;
drop table if exists Tipo_bilhete ;
drop table if exists Espectador_bilhete ;
drop table if exists Nacionalidade ;
drop table if exists Localidade ;
drop table if exists Devolucao ;
 
create table Participacao
(
   Participante_Participante_ID_   integer   not null,
   Festival_Festival_ID_   integer   not null,
   Dia_Dia_ID   integer   not null,
   cachet   int(11)   null,
   hora   time   null,
 
   constraint PK_Participacao primary key (Participante_Participante_ID_, Festival_Festival_ID_)
);
 
create table Entrevista
(
   Participante_Participante_ID_   integer   not null,
   Jornalista_Espectador_Espectador_ID_   integer   not null,
   data   date   null,
   hora   time   null,
 
   constraint PK_Entrevista primary key (Participante_Participante_ID_, Jornalista_Espectador_Espectador_ID_)
);
 
create table tecnificam
(
   Tecnico_Tecnico_ID_   integer   not null,
   Palco_Palco_ID_   integer   not null,
 
   constraint PK_tecnificam primary key (Tecnico_Tecnico_ID_, Palco_Palco_ID_)
);
 
create table associado
(
   Dia_Dia_ID_   integer   not null,
   Tipo_bilhete_Tipo_bilhete_ID_   integer   not null,
 
   constraint PK_associado primary key (Dia_Dia_ID_, Tipo_bilhete_Tipo_bilhete_ID_)
);
 
create table pertence
(
   Bilhete_Bilhete_ID_   integer   not null,
   Espectador_bilhete_Espectador_Espectador_ID_   integer   not null,
 
   constraint PK_pertence primary key (Bilhete_Bilhete_ID_, Espectador_bilhete_Espectador_Espectador_ID_)
);
 
create table Participante
(
   Participante_Participante_ID   integer   not null,
   Participante_ID   integer   not null,
   codigo_participante   int(11)   null,
   nome_participante   varchar(255)   null,
   estilo_participante   varchar(255)   null,
   inicio_prev   datetime   null,
   fim_prev   datetime   null,
 
   constraint PK_Participante primary key (Participante_ID)
);
 
create table Individual
(
   Participante_Participante_ID   integer   not null,
   Grupo_Participante_Participante_ID   integer   null,
   Nacionalidade_Nacionalidade_ID   integer   not null,
   nome_artista   varchar(255)   null,
   papel   varchar(255)   null,
   instrumento   varchar(255)   null,
 
   constraint PK_Individual primary key (Participante_Participante_ID, Grupo_Participante_Participante_ID)
);
 
create table Grupo
(
   Participante_Participante_ID   integer   not null,
   num_elementos   int(11)   null,
 
   constraint PK_Grupo primary key (Participante_Participante_ID)
);
 
create table Tema
(
   Participante_Participante_ID   integer   not null,
   Tema_ID   integer   not null,
   titulo   varchar(255)   null,
   ordem   int(11)   null,
 
   constraint PK_Tema primary key (Tema_ID)
);
 
create table Roadie
(
   Participante_Participante_ID   integer   not null,
   Tecnico_Tecnico_ID   integer   not null,
 
   constraint PK_Roadie primary key (Tecnico_Tecnico_ID)
);
 
create table Tecnico
(
   Tecnico_ID   integer   not null,
   num_tecnico   int(11)   null,
   nome_tecnico   varchar(255)   null,
 
   constraint PK_Tecnico primary key (Tecnico_ID)
);
 
create table Organizacao
(
   Tecnico_Tecnico_ID   integer   not null,
 
   constraint PK_Organizacao primary key (Tecnico_Tecnico_ID)
);
 
create table Festival
(
   Localidade_Localidade_ID   integer   not null,
   Festival_ID   integer   not null,
   edicao_festival   int(11)   null,
   nome_festival   varchar(255)   null,
   lotacao   int(11)   null,
 
   constraint PK_Festival primary key (Festival_ID)
);
 
create table Palco
(
   Palco_ID   integer   not null,
   codigo_palco   int(11)   null,
   nome_palco   varchar(255)   null,
 
   constraint PK_Palco primary key (Palco_ID)
);
 
create table Espectador
(
   Festival_Festival_ID   integer   not null,
   Espectador_ID   integer   not null,
   id_espectador   int(11)   null,
   genero   varchar(255)   null,
 
   constraint PK_Espectador primary key (Espectador_ID)
);
 
create table Jornalista
(
   Espectador_Espectador_ID   integer   not null,
   num_car_jor   int(11)   null,
   media   varchar(255)   null,
   num_liv_trans   int(11)   null,
 
   constraint PK_Jornalista primary key (Espectador_Espectador_ID)
);
 
create table Bilhete
(
   Tipo_bilhete_Tipo_bilhete_ID   integer   not null,
   Bilhete_ID   integer   not null,
   num_serie   int(11)   null,
 
   constraint PK_Bilhete primary key (Bilhete_ID)
);
 
create table Pagante
(
   Espectador_bilhete_Espectador_Espectador_ID   integer   not null,
   idade_pagante   int(11)   null,
 
   constraint PK_Pagante primary key (Espectador_bilhete_Espectador_Espectador_ID)
);
 
create table Convidado
(
   Espectador_bilhete_Espectador_Espectador_ID   integer   not null,
   profissao   varchar(255)   null,
 
   constraint PK_Convidado primary key (Espectador_bilhete_Espectador_Espectador_ID)
);
 
create table Dia
(
   Festival_Festival_ID   integer   not null,
   Dia_ID   integer   not null,
   data_dia   date   null,
 
   constraint PK_Dia primary key (Dia_ID)
);
 
create table Tipo_bilhete
(
   Tipo_bilhete_ID   integer   not null,
   preco_bilhete   float(11)   null,
   tipo   varchar(255)   null,
 
   constraint PK_Tipo_bilhete primary key (Tipo_bilhete_ID)
);
 
create table Espectador_bilhete
(
   Espectador_Espectador_ID   integer   not null,
 
   constraint PK_Espectador_bilhete primary key (Espectador_Espectador_ID)
);
 
create table Nacionalidade
(
   Nacionalidade_ID   integer   not null,
   pais   varchar(255)   null,
 
   constraint PK_Nacionalidade primary key (Nacionalidade_ID)
);
 
create table Localidade
(
   Localidade_ID   integer   not null,
   pais_localidade   varchar(255)   null,
   local   varchar(255)   null,
   localidade   varchar(255)   null,
 
   constraint PK_Localidade primary key (Localidade_ID)
);
 
create table Devolucao
(
   Pagante_Espectador_bilhete_Espectador_Espectador_ID   integer   not null,
   Devolucao_ID   integer   not null,
   estado   varchar(3)   null,
 
   constraint PK_Devolucao primary key (Devolucao_ID)
);
 
alter table Participacao
   add constraint FK_Participante_Participacao_Festival_ foreign key (Participante_Participante_ID_)
   references Participante(Participante_ID)
   on delete cascade
   on update cascade
; 
alter table Participacao
   add constraint FK_Festival_Participacao_Participante_ foreign key (Festival_Festival_ID_)
   references Festival(Festival_ID)
   on delete cascade
   on update cascade
; 
alter table Participacao
   add constraint FK_Participacao_atuacao_Dia foreign key (Dia_Dia_ID)
   references Dia(Dia_ID)
   on delete restrict
   on update cascade
;
 
alter table Entrevista
   add constraint FK_Participante_Entrevista_Jornalista_ foreign key (Participante_Participante_ID_)
   references Participante(Participante_ID)
   on delete cascade
   on update cascade
; 
alter table Entrevista
   add constraint FK_Jornalista_Entrevista_Participante_ foreign key (Jornalista_Espectador_Espectador_ID_)
   references Jornalista(Espectador_Espectador_ID)
   on delete cascade
   on update cascade
;
 
alter table tecnificam
   add constraint FK_Tecnico_tecnificam_Palco_ foreign key (Tecnico_Tecnico_ID_)
   references Tecnico(Tecnico_ID)
   on delete cascade
   on update cascade
; 
alter table tecnificam
   add constraint FK_Palco_tecnificam_Tecnico_ foreign key (Palco_Palco_ID_)
   references Palco(Palco_ID)
   on delete cascade
   on update cascade
;
 
alter table associado
   add constraint FK_Dia_associado_Tipo_bilhete_ foreign key (Dia_Dia_ID_)
   references Dia(Dia_ID)
   on delete cascade
   on update cascade
; 
alter table associado
   add constraint FK_Tipo_bilhete_associado_Dia_ foreign key (Tipo_bilhete_Tipo_bilhete_ID_)
   references Tipo_bilhete(Tipo_bilhete_ID)
   on delete cascade
   on update cascade
;
 
alter table pertence
   add constraint FK_Bilhete_pertence_Espectador_bilhete_ foreign key (Bilhete_Bilhete_ID_)
   references Bilhete(Bilhete_ID)
   on delete cascade
   on update cascade
; 
alter table pertence
   add constraint FK_Espectador_bilhete_pertence_Bilhete_ foreign key (Espectador_bilhete_Espectador_Espectador_ID_)
   references Espectador_bilhete(Espectador_Espectador_ID)
   on delete cascade
   on update cascade
;
 
alter table Participante
   add constraint FK_Participante_convite_Participante foreign key (Participante_Participante_ID)
   references Participante(Participante_ID)
   on delete restrict
   on update cascade
;
 
alter table Individual
   add constraint FK_Individual_Participante foreign key (Participante_Participante_ID)
   references Participante(Participante_ID)
   on delete cascade
   on update cascade
; 
alter table Individual
   add constraint FK_Individual_noname_Grupo foreign key (Grupo_Participante_Participante_ID)
   references Grupo(Participante_Participante_ID)
   on delete cascade
   on update cascade
; 
alter table Individual
   add constraint FK_Individual_nascido_Nacionalidade foreign key (Nacionalidade_Nacionalidade_ID)
   references Nacionalidade(Nacionalidade_ID)
   on delete restrict
   on update cascade
;
 
alter table Grupo
   add constraint FK_Grupo_Participante foreign key (Participante_Participante_ID)
   references Participante(Participante_ID)
   on delete cascade
   on update cascade
;
 
alter table Tema
   add constraint FK_Tema_tocam_Participante foreign key (Participante_Participante_ID)
   references Participante(Participante_ID)
   on delete restrict
   on update cascade
;
 
alter table Roadie
   add constraint FK_Roadie_orientam_Participante foreign key (Participante_Participante_ID)
   references Participante(Participante_ID)
   on delete restrict
   on update cascade
; 
alter table Roadie
   add constraint FK_Roadie_Tecnico foreign key (Tecnico_Tecnico_ID)
   references Tecnico(Tecnico_ID)
   on delete cascade
   on update cascade
;
 
 
alter table Organizacao
   add constraint FK_Organizacao_Tecnico foreign key (Tecnico_Tecnico_ID)
   references Tecnico(Tecnico_ID)
   on delete cascade
   on update cascade
;
 
alter table Festival
   add constraint FK_Festival_noname_Localidade foreign key (Localidade_Localidade_ID)
   references Localidade(Localidade_ID)
   on delete restrict
   on update cascade
;
 
 
alter table Espectador
   add constraint FK_Espectador_noname_Festival foreign key (Festival_Festival_ID)
   references Festival(Festival_ID)
   on delete restrict
   on update cascade
;
 
alter table Jornalista
   add constraint FK_Jornalista_Espectador foreign key (Espectador_Espectador_ID)
   references Espectador(Espectador_ID)
   on delete cascade
   on update cascade
;
 
alter table Bilhete
   add constraint FK_Bilhete_tem_Tipo_bilhete foreign key (Tipo_bilhete_Tipo_bilhete_ID)
   references Tipo_bilhete(Tipo_bilhete_ID)
   on delete restrict
   on update cascade
;
 
alter table Pagante
   add constraint FK_Pagante_Espectador_bilhete foreign key (Espectador_bilhete_Espectador_Espectador_ID)
   references Espectador_bilhete(Espectador_Espectador_ID)
   on delete cascade
   on update cascade
;
 
alter table Convidado
   add constraint FK_Convidado_Espectador_bilhete foreign key (Espectador_bilhete_Espectador_Espectador_ID)
   references Espectador_bilhete(Espectador_Espectador_ID)
   on delete cascade
   on update cascade
;
 
alter table Dia
   add constraint FK_Dia_noname_Festival foreign key (Festival_Festival_ID)
   references Festival(Festival_ID)
   on delete restrict
   on update cascade
;
 
 
alter table Espectador_bilhete
   add constraint FK_Espectador_bilhete_Espectador foreign key (Espectador_Espectador_ID)
   references Espectador(Espectador_ID)
   on delete cascade
   on update cascade
;
 
 
 
alter table Devolucao
   add constraint FK_Devolucao_noname_Pagante foreign key (Pagante_Espectador_bilhete_Espectador_Espectador_ID)
   references Pagante(Espectador_bilhete_Espectador_Espectador_ID)
   on delete restrict
   on update cascade
;
 
