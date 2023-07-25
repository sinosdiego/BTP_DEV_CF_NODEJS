
namespace sinosbyte.flights;

type buspatyp : String(4) enum {
    FC = 'Passageiros';
    TA = 'Agência de Viagens';
}
type custtype : String(2) enum {
    B = 'Empresa';
    P = 'Privado';
}

entity Scurx {
    key currkey : String(3);
    currname    : String(30);
    currdec     : Integer;
    curr_quo_usd: Decimal(5,4);
}

entity Scitairp {
    key city      : String(40);
    key country   : String(6);    
    key airport   : String(6);
    mastercity    : String(40);
}


entity Scarr{
    key carrid  : String(6);
    carrname    : String(40);
    currcode    : String(3);
    url         : String(510);
    curr        : Association to Scurx on curr.currkey = currcode;
    spflis      : Composition of many Spfli on spflis.carrid = $self.carrid;
}


entity Spfli {   
    key carrid  : String(6);
    key connid  : String(8);
    airpfrom    : Association to Scitairp;
    airpto      : Association to Scitairp;
    fltime      : String(5); //tempo duração
    deptime     : String(8); //hora partida
    arrtime     : String(8); //hora chegada
    distance    : Decimal(10,4);
    distid      : String(6);
    fltype      : String(2);
    period      : Integer;
    scarr       : Association to one Scarr    on scarr.carrid    = $self.carrid;
    sflights    : Composition of many Sflight on sflights.carrid = $self.carrid
                                             and sflights.connid = $self.connid;
}

entity Sflight {
    key carrid  : String(6);
    key connid  : String(8);    
    key fldate  : String(10);
    price       : Decimal(15,2);
    curr        : Association to Scurx;
    saplane     : Association to Saplane;      //SAPLANE
    seatsmax    : Integer;
    seatsocc    : Integer;
    paymentsum  : Decimal(17, 2);
    seatsmax_b  : Integer;
    seatsocc_b  : Integer;
    seatsmax_f  : Integer;
    seatsocc_f  : Integer;
    spfli       : Association to one Spfli  on spfli.carrid  = $self.carrid
                                           and spfli.connid  = $self.connid;
    sbooks      : Composition of many Sbook on sbooks.carrid = $self.carrid 
                                           and sbooks.connid = $self.connid
                                           and sbooks.fldate = $self.fldate;
}

entity Sbook {
    key carrid  : String(6);
    key connid  : String(8);
    key fldate  : String(10);
    key bookid  : String(16); 
    custom      : Association to Scustom;       // scustom
    custtype    : custtype;        //B - Empresa, P - Privado
    smoker      : String(2);        //  - Não Fumante, X - Fumante
    luggweight  : Decimal(15, 2);
    wunit       : String(6);
    invoice     : String(2);        //  - Não Marcado, X - Marcado
    class       : String(2);        //C - Executiva, Y - Economica, F - 1ªClasse
    forcuram    : Decimal(15,2);
    forcurkey   : String(8);
    loccuram    : Decimal(15, 2);
    loccurkey   : String(8);
    order_date  : String(10);
    counter     : String(16);       //SCOUNTER
    @Common.Label : 'AgencyNum'
    sbuspart    : Association to one Sbuspart;       //Sbuspart - 
    cancelled   : String(2);        //  - Marcado, X - Marcação Cancelado
    reserved    : String(2);        //  - Não Reservado, X - Reservado
    passname    : String(50) null;
    passform    : String(30) null;
    passbirth   : String(10) null;
    sflight     : Association to one Sflight on sflight.carrid = $self.carrid
                                            and sflight.connid = $self.connid
                                            and sflight.fldate = $self.fldate;
}


entity Scustom {
    key id      : String(16);
    name        : String(50);
    form        : String(30);
    street      : String(60);
    postbox     : String(20);
    postcode    : String(20);
    city        : String(50);
    country     : String(6);
    region      : String(6);
    telephone   : String(60);
    custtype    : custtype;        //B - Empresa, P - Privado
    discount    : Integer;
    langu       : String(2);
    email       : String(80);
    webuser     : String(50);
}

entity Saplane {
    key planetype   : String(20);
    seatsmax        : Integer;
    consum          : Decimal(16, 5);
    con_unit        : String(6);
    tankcap         : Decimal(16, 4);
    cap_unit        : String(6);
    weight          : Decimal(16, 4);
    wei_unit        : String(6);
    span            : Decimal(16, 5);
    span_unit       : String(6);
    leng            : Decimal(16, 5);
    leng_unit       : String(6);
    op_speed        : Decimal(16, 4);
    speed_unit      : String(6);
    producer        : String(10);
    seatsmax_b      : Integer;
    seatsmax_f      : Integer;
}


entity Sbuspart {
    key buspartnum  : String(16);
    contact         : String(50);
    contphono       : String(60);
    buspatyp        : buspatyp    //FC - Passageiros,  TA - Agencia Viagens
}

entity Scounter {
    key scarr       : Association to one Scarr;    //scarr
    key countnum    : String(16);
    airport         : String(6);    //Scitairp
}
